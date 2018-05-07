#' build_example
#'
#' Build the XXXX gluwasp entry from raw data
#'
#' @details Builds the gluwasp entry for XXXX
#' @return A row of gluwasp data for the city of XXXX, COUNTRY XXXX
#' @importFrom tibble tibble
#' @importFrom rlang .data
#' @import dplyr
#' @author SWDT April 2018
#' @export

build_delhi <- function() {

  #=====================================================//
  # SETUP =============================================//

  # read city name (must be identical to data folder name for city)
  city <- "XXXX"

  # suppress readr column parsing messages
  options(readr.num_columns = 0)

  # get shell tibble and name city
  make_gluwasp_tb() %>%
    mutate(city = !! city,
           country = "XXXX") -> gluwasp_xmp

  #=====================================================//
  # READ DATA FILES ===================================//



  #=====================================================//
  # COMPUTE STATS =====================================//

  # compute total storage


  # compute treatment capacity


  # compute resource breakdown using treatment capacity data


  # determine main modes of treatment


  # significant (i.e., >50% output) advanced stage treatment?


  #=====================================================//
  # EXTRACT STATS FROM COMMON DATA ====================//

  # #population and demographics
  # read_common_data("pop_and_demand.csv", quo(city), "pop_served") ->
  #   gluwasp_xmp[["pop"]]
  #
  # (1 - read_common_data("pop_and_demand.csv",
  #                       quo(city),
  #                       "pop_unserved_pc")) * 100 ->
  #   gluwasp_xmp[["access"]]
  #
  # read_common_data("pop_and_demand.csv", quo(city), "demand") ->
  #   gluwasp_xmp[["demand_total"]]
  #
  # read_common_data("pop_and_demand.csv", quo(city), "share_dom") *
  #   0.01 * gluwasp_tky$demand_total ->
  #   gluwasp_xmp[["demand_dmstc"]]
  #
  # # business model detail
  # get_business_model_detail(gluwasp_xmp, quo(city)) ->
  #   bus_mod_detail
  # bus_mod_detail$bm -> gluwasp_xmp[["business_model"]]
  # bus_mod_detail$rs -> gluwasp_xmp[["revenue_source"]]
  # bus_mod_detail$fm -> gluwasp_xmp[["finance"]]
  # bus_mod_detail$cr -> gluwasp_xmp[["cost_rec"]]
  #
  # # catchment
  # read_common_data("catchment_status.csv",
  #                  quo(city), "catchment_status") ->
  #   gluwasp_xmp[["catch_type"]]
  #
  # # disinfection
  # read_common_data("disinfection.csv",
  #                  quo(city), "dis") ->
  #   gluwasp_xmp[["disinf_main"]]
  #
  # # fluoridation
  # read_common_data("fluoridation.csv",
  #                  quo(city), "fluoridation") ->
  #   gluwasp_xmp[["fluorid"]]
  #
  # # unit costs to consumer
  # get_unit_cost_USD_per_m3(quo(city)) ->
  #   gluwasp_xmp[["unit_cost"]]
  #
  # # meter penetration
  # read_common_data("meter_penetration.csv",
  #                  quo(city), "meter_pen") ->
  #   gluwasp_xmp[["meter_pen"]]
  #
  # # leakage
  # read_common_data("leakage_rates.csv", quo(city), "leak_rate") ->
  #   gluwasp_xmp[["leakage"]]



  #=====================================================//
  # RETURN OUTPUT =====================================//

  gluwasp_xmp

}
