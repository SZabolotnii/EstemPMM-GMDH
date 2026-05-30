# gmdhpmm 0.1.0

Initial private extraction of the GMDH-PMM package layer from the PMM-GMDH research workspace.

- Adds `gmdh_pmm()` for cumulant-adaptive GMDH tournaments.
- Adds bootstrap-stabilized cumulant diagnostics and conservative LSE/PMM2/PMM3 dispatch.
- Adds forced baseline modes: `LSE`, `ridge-LSE`, `Huber`, and `L1`.
- Adds reserve-aware and spike-aware external selection criteria.
- Includes an experimental `fit_kg2_weak_pmm2()` estimator for the Weak-Moment GMDH follow-up.
- Excludes private/raw application data from the package repository.
