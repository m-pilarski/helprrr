#' Write environment variables to the project .Renviron-file
#'
#' \code{install_missing} - Install missing packages from CRAN and/or GitHub
#'
#' @param .pkg_cran ...
#' @param .pkg_gith ...
#' @return invisible \code{NULL}
#' @rdname install_missing
#' @export
#' @examples
#' install_missing
install_missing <- function(.pkg_cran=character(0L), .pkg_gith=character(0L)){

  .pkg_have <- utils::installed.packages()[, "Package"]

  .pkg_cran_miss <- .pkg_cran[!.pkg_cran %in% .pkg_have]

  .pkg_gith_repo <- regmatches(.pkg_gith ,regexpr("[^/]+$", .pkg_gith))

  .pkg_gith_miss <- .pkg_gith[!.pkg_gith_repo %in% .pkg_have]

  remotes::install_cran(pkgs=.pkg_cran_miss)

  for(.pkg_gith_i in .pkg_gith_miss){remotes::install_github(.pkg_gith_miss)}

  return(invisible(NULL))

}
