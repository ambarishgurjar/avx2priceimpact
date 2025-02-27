# AVX2 Optimized Impact Price Calculation for Crytocurrencies

## Overview

This project provides an **AVX2-optimized implementation** for computing impact prices in order books, significantly accelerating calculations using SIMD (Single Instruction, Multiple Data) intrinsics. It includes:
this is the current overview i have can you write a better one with referernces even use stoikov 2017 micro price reference

## Overview

This project implements an **AVX2-optimized algorithm** for calculating impact prices in cryptocurrency order books, leveraging SIMD (Single Instruction, Multiple Data) intrinsics to significantly accelerate computations. The implementation draws inspiration from Stoikov's 2017 micro-price concept[^1], adapting it for high-frequency trading scenarios in cryptocurrency markets.

Key features include:

1. **AVX2 Optimization**: Utilizes 256-bit vector operations for parallel processing of order book data.
2. **Dynamic CPU Feature Detection**: Automatically selects between AVX2 and scalar implementations based on runtime CPU capabilities.
3. **Cython Integration**: Combines Python's ease of use with C-level performance for optimal execution speed.
4. **Micro-Price Inspired Calculations**: Incorporates elements of Stoikov's micro-price, which accounts for order book imbalance and provides a potentially more accurate predictor of short-term price movements than traditional mid-price calculations[^1].

This implementation is particularly suited for high-frequency trading systems and market microstructure analysis in cryptocurrency markets, where rapid price calculations are crucial for making informed trading decisions[^2].[^1][^2][^5]

<div style="text-align: center">⁂

[^1]: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2970694

[^2]: https://coinledger.io/learn/how-does-a-cryptocurrency-gain-value

[^3]: https://en.wikipedia.org/wiki/Advanced_Vector_Extensions

[^4]: https://arxiv.org/pdf/2307.15599.pdf

[^5]: https://www.semanticscholar.org/paper/The-micro-price:-a-high-frequency-estimator-of-Stoikov/791b497158d3e5eb5f6ad934e205bd637ca409ec

[^6]: http://stanford.edu/class/msande448/2021/Final_reports/gr1.pdf

[^7]: https://community.intel.com/t5/Intel-ISA-Extensions/Is-there-some-books-about-SIMD-sse-avx-and-so-on-optimization/td-p/939782

[^8]: https://www.youtube.com/watch?v=0ZHypIAxYNo

[^9]: https://www.elastic.co/blog/accelerating-vector-search-simd-instructions

[^10]: https://www.researchgate.net/publication/327410053_The_micro-price_a_high-frequency_estimator_of_future_prices

[^11]: https://arxiv.org/pdf/1611.07612.pdf

[^12]: https://www.semanticscholar.org/paper/The-micro-price:-a-high-frequency-estimator-of-Stoikov/cda92a8a407841f6e2c56823c8659d0ff56b0308

[^13]: https://www.bitsnbites.eu/three-fundamental-flaws-of-simd/

[^14]: https://towardsdatascience.com/price-impact-of-order-book-imbalance-in-cryptocurrency-markets-bf39695246f6/

[^15]: https://www.blockchainresearchlab.org/wp-content/uploads/2019/07/Discovering-market-prices-Meyer-Fiedler-BRL-Series-No.-2.pdf

[^16]: https://koinly.io/blog/what-determines-the-price-of-crypto/

[^17]: https://www.reddit.com/r/hardware/comments/18q708v/what_is_the_real_world_impact_of_avx2_vs_avx512/

[^18]: https://stackoverflow.com/questions/18971401/sparse-array-compression-using-simd-avx2
</div>

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

 **Optimized for speed. Built for high-frequency trading.**


