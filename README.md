# AVX2 Optimized Impact Price Calculation for Crytocurrencies

## Overview

This project implements an **AVX2-optimized algorithm** for calculating impact prices in cryptocurrency order books, leveraging SIMD (Single Instruction, Multiple Data) intrinsics to significantly accelerate computations. The implementation draws inspiration from Stoikov's 2017 micro-price concept, adapting it for high-frequency trading scenarios in cryptocurrency markets.

Key features include:

1. **AVX2 Optimization**: Utilizes 256-bit vector operations for parallel processing of order book data.
2. **Dynamic CPU Feature Detection**: Automatically selects between AVX2 and scalar implementations based on runtime CPU capabilities.
3. **Cython Integration**: Combines Python's ease of use with C-level performance for optimal execution speed.
4. **Micro-Price Inspired Calculations**: Incorporates elements of Stoikov's micro-price, which accounts for order book imbalance and provides a potentially more accurate predictor of short-term price movements than traditional mid-price calculations

This implementation is particularly suited for high-frequency trading systems and market microstructure analysis in cryptocurrency markets, where rapid price calculations are crucial for making informed trading decisions



✅ **Scalar Implementation** (Baseline, no SIMD) ✅ **AVX2 Optimized Implementation** (Faster execution using vectorization) ✅ **Automatic SIMD Detection** (Dynamically selects best available implementation)

##  Performance

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

##  Acknowledgement

I would like to acknowledge HangukQuant, his private repository named Quantlib helped me come up with this. If anyone wants to seriously learn quant development then please purchase his thinkific lectures or substack subscription.  

## 🔗 References

- [Cython Documentation](https://cython.readthedocs.io/)
- [AVX2 Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)
- [HangukQuant's Lectures](https://hangukquant.thinkific.com/)
- [Stoikov's Micro-Price Model](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2970694)
- [Understanding Cryptocurrency Market Impact](https://coinledger.io/learn/how-does-a-cryptocurrency-gain-value)
- [Advanced Vector Extensions](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)
- [High-Frequency Trading Research](https://arxiv.org/pdf/2307.15599.pdf)
- [Market Microstructure Theory](https://www.semanticscholar.org/paper/The-micro-price:-a-high-frequency-estimator-of-Stoikov/791b497158d3e5eb5f6ad934e205bd637ca409ec)
- [Stanford Market Structure Analysis](http://stanford.edu/class/msande448/2021/Final_reports/gr1.pdf)
- [Intel SIMD Optimization Guide](https://community.intel.com/t5/Intel-ISA-Extensions/Is-there-some-books-about-SIMD-sse-avx-and-so-on-optimization/td-p/939782)
- [Cryptocurrency Market Impact](https://towardsdatascience.com/price-impact-of-order-book-imbalance-in-cryptocurrency-markets-bf39695246f6)
- [Real-World AVX2 vs AVX512 Performance](https://www.reddit.com/r/hardware/comments/18q708v/what_is_the_real_world_impact_of_avx2_vs_avx512)
- [Sparse Array Compression Using SIMD](https://stackoverflow.com/questions/18971401/sparse-array-compression-using-simd-avx2)




 **Optimized for speed. Built for high-frequency trading.**


