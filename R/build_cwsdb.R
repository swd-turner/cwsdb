## this function will be for building the cwsdb from the source data

#' build_cwsdb
#'
#' Build the city water supply database
#'
#' @details Builds the cws entry for Tokyo
#' @return cwsdb
#' @importFrom tibble tibble
#' @importFrom dplyr mutate
#' @author SWDT March 2018
#' @export

build_cwsdb <- function() {

  building("Building city water supply database from raw sources...")

  # build db for each city
  cws_tokyo <- build_tokyo(); done("Tokyo")

  # combine to create cwsdb
  bind_rows(cws_tokyo)

}

# usethis::use_data(cwsdb, overwrite = T)

