# EstemPMM-GMDH

`gmdhpmm` is an experimental R package for cumulant-adaptive GMDH models built on top of [`EstemPMM`](https://github.com/SZabolotnii/EstemPMM).

The package keeps the classical multilayer GMDH tournament structure, but changes the inner coefficient-estimation step of each KG-2 partial model. Each candidate starts from an LSE warm start, estimates residual cumulants with bootstrap stabilization, and dispatches to LSE, PMM2, or PMM3. PMM2/PMM3 solvers are delegated to `EstemPMM`; this repository contributes the GMDH tournament, small-partition cumulant diagnostics, reserve-aware external criteria, robust baselines, and experimental weak-moment extensions.

## Status

Private working repository for the GMDH-PMM methodology paper and companion experiments.

- Package name: `gmdhpmm`
- GitHub repository name: `EstemPMM-GMDH`
- Core dependency: `EstemPMM`
- Current package tests: 76 testthat checks in the source workspace

This repository intentionally starts private. It should become public only when the submission strategy permits it.

## Installation

```r
install.packages("EstemPMM")

# from a local checkout
remotes::install_local(".")

# after the private GitHub repository exists and access is configured
remotes::install_github("SZabolotnii/EstemPMM-GMDH")
```

## Quick Start

```r
library(gmdhpmm)

set.seed(7)
X <- matrix(rnorm(600 * 4), 600, 4)
y <- 1 + 1.5 * X[, 1] - X[, 2] +
  0.8 * X[, 1] * X[, 2] + 0.5 * X[, 3]^2 +
  (rexp(600) - 1) * 2

fit <- gmdh_pmm(
  X, y,
  gmdh_pmm_control(B = 200, L_max = 4, F = 6, seed = 7)
)

fit
pred <- predict(fit, X)
```

## Main Functions

| Function | Role |
|---|---|
| `gmdh_pmm()` | Fit the cumulant-adaptive GMDH tournament. |
| `gmdh_pmm_control()` | Configure layers, survivor count, bootstrap size, dispatch thresholds, and external criteria. |
| `inner_estimate()` | Fit one KG-2 partial model using LSE, PMM2, PMM3, or a forced baseline. |
| `bootstrap_cumulant_diag()` | Bootstrap-stabilized residual cumulant diagnostics. |
| `dispatch_method()` | Conservative LSE/PMM2/PMM3 decision rule. |
| `external_criterion()` | MSE, PMM-loss, reserve-aware, and spike-aware selection criteria. |
| `fit_kg2_weak_pmm2()` | Experimental weak-moment PMM2 inner estimator. |

## Verification

```bash
Rscript -e 'testthat::test_local(".")'
Rscript experiments/run_sanity.R
Rscript experiments/run_synthetic.R 20 500 80
Rscript experiments/run_cascade.R 10 500 80
Rscript experiments/run_coverage.R 10 400 40 40
```

`experiments/` contains both lightweight package checks and heavier paper-facing scripts. Some application scripts require private or externally licensed datasets and are retained for provenance; those data files are not included in this initial repository payload.

## Data Policy

The initial repository excludes raw and processed drilling/application datasets. Place local data under `data/` or provide manifests in a downstream research workspace. Synthetic experiments and unit tests run without private data.

## Relationship to EstemPMM

`EstemPMM` is the core PMM estimation package. `gmdhpmm` is the GMDH layer that uses `EstemPMM::lm_pmm2()` and `EstemPMM::lm_pmm3()` internally. Keep this dependency direction:

```text
EstemPMM  -> core PMM estimators
gmdhpmm   -> GMDH tournament using EstemPMM
```

Do not merge the GMDH tournament into `EstemPMM` until the GMDH API has stabilized.

## License

GPL-3.
