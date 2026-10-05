# gmdhpmm: GMDH with Polynomial Maximization Method Estimators

[![R-CMD-check](https://github.com/SZabolotnii/EstemPMM-GMDH/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/SZabolotnii/EstemPMM-GMDH/actions/workflows/R-CMD-check.yaml)
[![R](https://img.shields.io/badge/R-%3E%3D%203.5.0-blue)](https://cran.r-project.org/)
[![License: GPL-3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://opensource.org/licenses/GPL-3.0)

## Overview

**gmdhpmm** implements multilayer Group Method of Data Handling (**GMDH**) regression
in which the coefficients of every partial model are estimated by an estimator chosen
for that partial model, inside the self-organizing tournament. It is the GMDH layer of
[**EstemPMM**](https://github.com/SZabolotnii/EstemPMM), which supplies the Polynomial
Maximization Method (PMM) estimators.

Classical GMDH fits each two-input quadratic partial model by least squares. Under heavy
or skewed noise, least squares is inefficient, and PMM estimators keyed on raw residual
cumulants break down when those cumulants are dominated by a few extreme residuals.
`gmdhpmm` replaces the inner least-squares step by a choice among

| Estimator | `force_method` | Notes |
|-----------|----------------|-------|
| Least squares, ridge least squares | `"LSE"`, `"ridge-LSE"` | classical GMDH |
| Huber, least absolute deviations | `"Huber"`, `"L1"` | IRLS |
| PMM2, PMM3 | `"PMM2"`, `"PMM3"` | from `EstemPMM` |
| Windowed (weak-moment) PMM2, PMM3 | `"WPMM2"`, `"WPMM3"` | cumulants of Gaussian-windowed residuals; stable under heavy tails |

and two ways to choose among them:

- **validation gate** (`"auto-valgate"`): the candidate with the lowest inner-cross-validated
  trimmed RMSE on the partial model's training rows; contiguous (blocked) inner folds by
  default, so it is safe on time series;
- **cumulant dispatch** (`"auto"`, `"auto-weak"`): a rule on bootstrap-stabilized residual
  cumulants of the partial model.

## Installation

```r
install.packages("EstemPMM")                       # PMM estimators (CRAN)
remotes::install_github("SZabolotnii/EstemPMM-GMDH")
```

## Quick start

```r
library(gmdhpmm)

set.seed(1)
n <- 500
X <- matrix(rnorm(n * 4), n, 4, dimnames = list(NULL, paste0("x", 1:4)))
y <- 1 + 2 * X[, 1] - X[, 2] + 0.5 * X[, 1] * X[, 3] + rt(n, df = 2)   # heavy-tailed noise
train <- 1:400; test <- 401:n

fit <- gmdh_pmm(X[train, ], y[train],
                gmdh_pmm_control(force_method = "auto-valgate", L_max = 3, F = 6, seed = 1))
fit                       # layers, best external criterion, estimators chosen per partial model
pred <- predict(fit, X[test, ])
```

## Main functions

| Function | Role |
|----------|------|
| `gmdh_pmm()`, `predict()` | Fit and apply the GMDH tournament. |
| `gmdh_pmm_control()` | Layers, survivors, inner estimator (`force_method`), gate candidates and folds, external criterion. |
| `inner_estimate()` | Fit one KG-2 partial model with a given or chosen estimator. |
| `fit_kg2_weak_pmm2()`, `fit_kg2_weak_pmm3()` | Windowed PMM estimators of a partial model. |
| `bootstrap_cumulant_diag()`, `weak_cumulant_diag()` | Residual cumulant diagnostics (raw and windowed). |
| `dispatch_method()`, `dispatch_method_weak()` | Cumulant-keyed estimator choice. |
| `external_criterion()` | MSE, MAE, PMM-loss, reserve-aware and spike-aware selection criteria. |
| `load_volve_drilling()`, `load_forge_drilling()` | Loaders for the open Volve and Utah FORGE drilling logs (data not included). |

## Papers and reproducibility

The code that produces the tables and figures of a paper lives in that paper's code
supplement, which pins the exact version of this package it used:

- *Validation-Gated Weak-Moment Group Method of Data Handling for Heavy-Tailed
  Regression*: <https://github.com/SZabolotnii/Ku-GMDH-WeakMoment-code-supplement>
  (uses `gmdhpmm` 0.2.0).

## Relationship to EstemPMM

`EstemPMM` is the estimation package (PMM2, PMM3, PMM time-series models, dispatch);
`gmdhpmm` depends on it and adds the GMDH model-structure search. The dependency runs one
way only.

## Citation

```r
citation("gmdhpmm")
```

## License

GPL-3.
