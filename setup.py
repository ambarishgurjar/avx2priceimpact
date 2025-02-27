from setuptools import setup
from Cython.Build import cythonize
from setuptools.extension import Extension

extensions = [
    Extension(
        "benchmark_avx2",
        ["benchmark_avx2.pyx"],
        extra_compile_args=["-mavx2", "-mfma"],  # Ensure AVX2 and FMA enabled
        extra_link_args=["-mavx2", "-mfma"],
    )
]

setup(
    ext_modules=cythonize(extensions, compiler_directives={"boundscheck": False, "wraparound": False})
)
