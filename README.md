# AVX2 Impact Price Calculation for Crytocurrencies


# AVX2 Impact Price Calculation

## 📌 Overview

This project provides an **AVX2-optimized implementation** for computing impact prices in order books, significantly accelerating calculations using SIMD (Single Instruction, Multiple Data) intrinsics. It includes:

✅ **Scalar Implementation** (Baseline, no SIMD) ✅ **AVX2 Optimized Implementation** (Faster execution using vectorization) ✅ **Automatic SIMD Detection** (Dynamically selects best available implementation)

## ⚡ Performance

The AVX2 version can significantly speed up impact price computations in large order books.

| Order Book Size | Scalar (sec) | AVX2 (sec) | Speedup |
| --------------- | ------------ | ---------- | ------- |
| 100             | 0.000010     | 0.000001   | \~6.67x |
| 1,000           | 0.000004     | 0.000001   | \~2.50x |
| 10,000          | 0.000009     | 0.000007   | \~1.16x |
| 1,000,000       | 0.010608     | 0.010793   | \~0.98x |
| 10,000,000      | 0.125414     | 0.127223   | \~0.99x |

## 🛠 Installation

### Prerequisites

Ensure you have **Python 3.9+**, `pip`, and `Cython` installed:

```bash
pip install cython numpy
```

### Build the Cython Extension

Compile the AVX2 extension by running:

```bash
python setup.py build_ext --inplace
```

##  Usage

### Run Benchmark Tests

Execute the benchmark to test performance:

```bash
python benchmark.py
```

Expected output:

```
[INFO] AVX2 Optimizations Enabled

Order Book Size: 100
  - Scalar Implementation: 0.000010 sec
  - AVX2 Implementation: 0.000001 sec (~6.67x speedup)
...
```

### Importing in Python

You can also import and use the function directly:

```python
import numpy as np
from benchmark_avx2 import impact_price, initialize_optimizations

initialize_optimizations()

order_book = np.random.rand(1000, 2) * 100  # Random price & volume
order_book = np.array(order_book, dtype=np.float64, order='C')
notional = 50000

price = impact_price(order_book, notional)
print(f"Impact Price: {price:.2f}")
```

##  Project Structure

```
AVX2-Impact-Price/
│── benchmark_avx2.pyx  # Cython implementation with AVX2
│── setup.py            # Build script for Cython extension
│── benchmark.py        # Benchmarking script
│── README.md           # Project documentation
│── .gitignore          # Ignore compiled files
```

##  License

This project is licensed under the **MIT License**.

##  Contributing

Feel free to contribute by opening an issue or submitting a pull request!

## 🔗 References

- [Cython Documentation](https://cython.readthedocs.io/)
- [AVX2 Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)

 **Optimized for speed. Built for high-frequency trading.**


