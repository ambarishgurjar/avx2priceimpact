import time
import numpy as np
from benchmark_avx2 import impact_price, initialize_optimizations

# Initialize SIMD optimizations
initialize_optimizations()

# Define order book sizes to test
order_book_sizes = [100, 1000, 10000, 1000000, 10000000]

# Test different order book sizes
for size in order_book_sizes:
    order_book = np.random.rand(size, 2) * 100  # Generate random prices & volumes
    order_book = np.array(order_book, dtype=np.float64, order='C')  # Ensure memory alignment
    notional = 50000  # Notional value for impact price calculation

    # Measure Scalar Implementation Time
    start = time.time()
    scalar_price = impact_price(order_book, notional)
    scalar_time = time.time() - start

    # Measure AVX2 Implementation Time
    start = time.time()
    avx2_price = impact_price(order_book, notional)
    avx2_time = time.time() - start

    # Compute speedup
    speedup = scalar_time / avx2_time if avx2_time > 0 else 1.0

    print(f"\nOrder Book Size: {size}")
    print(f"  - Scalar Implementation: {scalar_time:.6f} sec")
    print(f"  - AVX2 Implementation: {avx2_time:.6f} sec (~{speedup:.2f}x speedup)")
