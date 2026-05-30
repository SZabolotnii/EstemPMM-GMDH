# Repository Setup Notes

*Date: 2026-05-30*

Target remote:

```text
git@github.com:SZabolotnii/EstemPMM-GMDH.git
```

Recommended initial setup after the private GitHub repository is created:

```bash
cd /Users/docua/Project/Research/EstemPMM-GMDH
git init
git branch -M main
git add .
git commit -m "Initial gmdhpmm package extraction"
git remote add origin git@github.com:SZabolotnii/EstemPMM-GMDH.git
git push -u origin main
```

Before pushing, run:

```bash
Rscript -e 'testthat::test_local(".")'
R CMD build .
R CMD check --no-manual gmdhpmm_0.1.0.tar.gz
```

Private-data rule:

- Do not commit raw or processed drilling datasets.
- Do not commit per-row prediction dumps unless the data license permits redistribution.
- Keep synthetic and summary CSV files only when they are needed for paper reproducibility.

Suggested public-release gate:

- JSCS / methodology submission strategy allows public code.
- Code supplement has been checked against the exact manuscript tables and figures.
- `R CMD check` is at least `0 ERROR, 0 WARNING`; notes are documented.
