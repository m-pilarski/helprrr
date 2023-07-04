#' Write environment variables to the project .Renviron-file
#'
#' \code{setenv_persist} - Convert all Emojis to some ...
#'
#' @param ... ...
#' @param .path_proj ...
#' @return invisible \code{NULL}
#' @rdname setenv_persist
#' @export
#' @examples
#' setenv_persist
setenv_persist <- function(..., .path_proj=here::here()){

  stopifnot(dir.exists(.path_proj))

  .path_renviron <- file.path(.path_proj, ".Renviron")

  if(!file.exists(.path_renviron)){file.create(.path_renviron)}

  .lines_new <-
    list(...) |>
    (\(..x){`names<-`(as.character(..x), names(..x))})()

  stopifnot(all(sapply(.lines_new, is.character)))

  .lines_old <-
    readLines(con=.path_renviron, skipNul=TRUE) |>
    (\(..x){regmatches(..x, regexpr("=", ..x), invert=TRUE)})() |>
    sapply(function(.x){`names<-`(.x[2], .x[1])})

  c(.lines_new, .lines_old) |>
    (\(..x){..x[!duplicated(names(..x))]})() |>
    (\(..x){paste0(names(..x), "=", ..x)})() |>
    c("") |>
    writeLines(con=.path_renviron)

  readRenviron(.path_renviron)

  return(invisible(NULL))

}
