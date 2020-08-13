contains_rmarkdown <- function(filepath) {

  libs_file_lines <-
    readr::read_lines(filepath)

  any(grepl("^library\\(rmarkdown\\)", libs_file_lines))

}



`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}


#' Load packages in the packages.R file
#'
#' @return All packages
#' @export
#'
loadd_packages <- function(){

  ## Load your packages, e.g. library(drake).
  source("./packages.R")

}

#' Loads all current packages and sources all functions
#'
#' @return All scripts and functions
#' @export
loadd_functions <- function() {

  loadd_packages()

  ## Load your R functions after restarting R
  lapply(list.files("./R", full.names = TRUE), source)

}
