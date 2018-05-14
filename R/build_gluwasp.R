## this function will be for building gluwasp from the source data

#' build_gluwasp
#'
#' Build the city water supply database
#'
#' @details Builds the gluwasp database
#' @return gluwasp
#' @importFrom tibble tibble
#' @importFrom dplyr mutate
#' @author SWDT May 2018
#' @export

build_gluwasp <- function() {

  building("Building the global urban water supply database from raw sources...")

  # build db for each city [DEPRECATED APPROACH!!]
  # gluwasp_tokyo <- build_tokyo(); done("Tokyo")
  # gluwasp_delhi <- build_delhi(); done("Delhi")

  # normalise units in input datasets
  read_gluwasp_data("business_models.csv") -> business_models
  read_gluwasp_data("catchment_status.csv") -> catchment_detail
  read_gluwasp_data("disinfection.csv") -> disinf
  read_gluwasp_data("fluoridation.csv") -> fluor
  read_gluwasp_data("leakage_rates.csv") -> leakage
  read_gluwasp_data("meter_penetration.csv") -> meter_pen
  read_gluwasp_data("pop_and_demand.csv") -> demand_detail
  read_gluwasp_data("water_costs.csv") -> cost_detail



  done("raw data loaded")
  done("units converted")
  done("gluwasp built!")

  city_complete("gluwasp cities: ...")


}



# to update main datafile:
# gluwasp <- gluwasp::build_gluwasp()
# usethis::use_data(gluwasp, overwrite = T)

