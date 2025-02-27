cimport cython
from libc.math cimport fmin
from libc.stdint cimport uint32_t
from libc.string cimport memset

# Import AVX2 intrinsics properly
cdef extern from "<immintrin.h>":
    ctypedef struct __m256d: pass

    __m256d _mm256_loadu_pd(double*) nogil
    __m256d _mm256_mul_pd(__m256d, __m256d) nogil
    __m256d _mm256_add_pd(__m256d, __m256d) nogil
    __m256d _mm256_setzero_pd() nogil
    __m256d _mm256_hadd_pd(__m256d, __m256d) nogil
    double _mm256_cvtsd_f64(__m256d) nogil

# --------------------------- CPU Feature Detection ---------------------------
cdef extern from "cpuid.h":
    bint __get_cpuid(unsigned int, unsigned int*, unsigned int*, unsigned int*, unsigned int*)

cdef int has_avx2 = -1

cpdef bint check_avx2():
    """
    Check if AVX2 is supported at runtime.
    """
    global has_avx2
    if has_avx2 != -1:
        return has_avx2  # Already checked

    cdef unsigned int eax, ebx, ecx, edx
    __get_cpuid(7, &eax, &ebx, &ecx, &edx)  # Get AVX2 support flag

    has_avx2 = (ebx & (1 << 5)) != 0  # Check AVX2 bit
    return has_avx2

# --------------------------- Scalar Implementation ---------------------------
cdef double impact_price_scalar(double[:, :] ob, double notional) nogil:
    """
    Standard non-SIMD version of impact_price.
    """
    cdef int i, n = ob.shape[0]
    cdef double price, volume, wsum = 0.0, cumvol = 0.0, cum_notional = 0.0

    for i in range(n):
        price = ob[i, 0]
        volume = ob[i, 1]

        if cum_notional + price * volume >= notional:
            volume = (notional - cum_notional) / price
        
        wsum += price * volume
        cumvol += volume
        cum_notional += price * volume

        if cum_notional >= notional:
            break

    return wsum / cumvol if cumvol > 0 else 0.0

# --------------------------- AVX2 Implementation ---------------------------
cdef double impact_price_avx2(double[:, :] ob, double notional) nogil:
    """
    Optimized AVX2 version of impact_price.
    """
    cdef int i, n = ob.shape[0]
    cdef double* ptr = &ob[0, 0]

    cdef __m256d price, volume, wsum, cumvol, cum_notional
    wsum = _mm256_setzero_pd()
    cumvol = _mm256_setzero_pd()
    cum_notional = _mm256_setzero_pd()

    for i in range(0, n, 4):  # Process 4 elements at a time
        price = _mm256_loadu_pd(&ptr[i * 2])      # Load 4 prices
        volume = _mm256_loadu_pd(&ptr[i * 2 + 1]) # Load 4 volumes

        wsum = _mm256_add_pd(wsum, _mm256_mul_pd(price, volume))
        cumvol = _mm256_add_pd(cumvol, volume)
        cum_notional = _mm256_add_pd(cum_notional, _mm256_mul_pd(price, volume))

        # Use _mm256_cvtsd_f64 to extract first element of the vector safely
        if _mm256_cvtsd_f64(cum_notional) >= notional:
            break

    # Use horizontal add to sum values
    wsum = _mm256_hadd_pd(wsum, wsum)
    cumvol = _mm256_hadd_pd(cumvol, cumvol)

    return _mm256_cvtsd_f64(wsum) / _mm256_cvtsd_f64(cumvol) if _mm256_cvtsd_f64(cumvol) > 0 else 0.0

# --------------------------- Dynamic Function Selection ---------------------------
cdef double (*selected_impact_price)(double[:, :], double) nogil

def initialize_optimizations():
    """
    Selects the best available SIMD optimization at runtime.
    """
    global selected_impact_price
    if check_avx2():
        selected_impact_price = impact_price_avx2
        print("[INFO] AVX2 Optimizations Enabled")
    else:
        selected_impact_price = impact_price_scalar
        print("[INFO] Using Scalar Implementation (No AVX2)")

cpdef double impact_price(double[:, :] ob, double notional):
    """
    Calls the best available implementation dynamically.
    """
    return selected_impact_price(ob, notional
