# gmdhpmm 0.2.0

First public release.

- Windowed (weak-moment) inner estimator `WPMM3` (`fit_kg2_weak_pmm3()`) beside `WPMM2`,
  with windowed cumulant diagnostics (`weak_sample_cumulants()`,
  `weak_cumulant_diag()`) and the cumulant dispatch `"auto-weak"` (`dispatch_method_weak()`).
- Validation gate `"auto-valgate"`: the inner estimator of each partial model is the
  candidate (`valgate_candidates`) with the lowest inner-cross-validated trimmed RMSE over
  `valgate_folds` contiguous folds (`valgate_inner = "random"` for interleaved folds).
- `PATP3` inner estimator and `MAE` external criterion.
- Loaders and a manifest for the open Volve and Utah FORGE drilling logs
  (`load_forge_standard_drilling()`, `drilling_data_manifest()`, `ku_ng_data_root()`).
- All exported functions documented; `R CMD check --as-cran` clean apart from the
  new-submission note.

# gmdhpmm 0.1.0

Initial private extraction of the GMDH-PMM package layer.

- `gmdh_pmm()` for cumulant-adaptive GMDH tournaments.
- Bootstrap-stabilized cumulant diagnostics and conservative LSE/PMM2/PMM3 dispatch.
- Forced baseline modes: `LSE`, `ridge-LSE`, `Huber`, and `L1`.
- Reserve-aware and spike-aware external selection criteria.
- Experimental windowed PMM2 inner estimator `WPMM2` (`fit_kg2_weak_pmm2()`).
