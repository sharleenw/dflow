contains_rmarkdown <- function(filepath) {

  libs_file_lines <-
    readr::read_lines(filepath)

  any(grepl("^library\\(rmarkdown\\)", libs_file_lines))

}



`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}
