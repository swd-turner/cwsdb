## this function will be for building gluwasp from the source data

#' build_gluwasp
#'
#' Build the city water supply database
#'
#' @details Builds the gluwasp entry for Tokyo
#' @return gluwasp
#' @importFrom tibble tibble
#' @importFrom dplyr mutate
#' @author SWDT March 2018
#' @export

build_gluwasp <- function() {

  building("Building the global urban water supply database from raw sources...")

  # build db for each city
  gluwasp_tokyo <- build_tokyo(); done("Tokyo")

  # combine to create gluwasp
  bind_rows(gluwasp_tokyo)

}



# to update main datafile:
# gluwasp = gluwasp = gluwasp::build_gluwasp()
# usethis::use_data(gluwasp, overwrite = T)

