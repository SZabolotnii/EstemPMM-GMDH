#' gmdhpmm: GMDH with PMM coefficient estimation
#'
#' MIA-GMDH whose inner coefficient step dispatches automatically between LSE,
#' PMM2 and PMM3 based on bootstrap-stabilized residual cumulants. See
#' \code{\link{gmdh_pmm}} for the entry point. The PMM2/PMM3 estimators are
#' provided by \pkg{EstemPMM}; this package contributes the GMDH tournament
#' layer and small-partition dispatch machinery.
#'
#' @keywords internal
"_PACKAGE"

# NULL-coalescing helper used throughout.
`%||%` <- function(a, b) if (is.null(a)) b else a
