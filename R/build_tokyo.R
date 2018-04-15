#' build_tokyo
#'
#' Build the Tokyo gluwasp entry from raw data
#'
#' @details Builds the gluwasp entry for Tokyo
#' @return A row of gluwasp data for the city of Tokyo, Japan.
#' @importFrom tibble tibble
#' @importFrom tidyr replace_na spread
#' @importFrom rlang .data
#' @import dplyr
#' @author SWDT March 2018
#' @export

build_tokyo <- function() {

  #=====================================================//
  # SETUP =============================================//

  # read city name (must be identical to data folder name for city)
  city <- "Tokyo"

  # suppress readr column parsing messages
  options(readr.num_columns = 0)

  # get shell tibble and name city
  make_gluwasp_tb() %>%
    mutate(city = !! city,
           country = "Japan") -> gluwasp_tky

  #=====================================================//
  # READ DATA FILES ===================================//

  # read reservoir data
  read_gluwasp_data("tokyo_storage.csv", city) ->
    res_tky

  # read water treatment data
  read_gluwasp_data("tokyo_treatment.csv", city) %>%
    mutate(treatmt_1 = case_when(
      grepl("rapid", .data$treatmt_1) ~ "rapid_sand",
      grepl("slow", .data$treatmt_1) ~ "slow_sand",
      grepl("membrane", .data$treatmt_1) ~ "membrane")) %>%
    mutate(resource = if_else(.data$river_basin == "groundwater",
                              .data$river_basin, "surface")) ->
    trt_tky


  #=====================================================//
  # COMPUTE STATS =====================================//

  # compute total storage
  res_tky %>%
    select(.data$eff_storage) %>%
    sum() ->
    gluwasp_tky[["storage"]]

  # compute treatment capacity
  trt_tky %>%
    select(.data$capacity) %>%
    sum() * m3_to_Mm3 ->
    gluwasp_tky[["treat_cap"]]

  # compute resource breakdown using treatment capacity data
  trt_tky %>%
    group_by(.data$resource) %>%
    summarise(cap = sum(.data$capacity)) %>%
    mutate(share = .data$cap / sum(.data$cap)) %>%
    select(-.data$cap) %>%
    spread(.data$resource, .data$share) -> resource_share

  resource_share %>% .$surface -> gluwasp_tky[["surface"]]
  resource_share %>% .$groundwater -> gluwasp_tky[["ground"]]

  # determine main modes of treatment
  trt_tky %>%
    group_by(.data$treatmt_1) %>%
    summarise(capacity = sum(.data$capacity) * m3_to_Mm3) ->
    trt_tky_by_type

  trt_tky_by_type %>%
    filter(.data$capacity == max(.data$capacity)) %>%
    .$treatmt_1 ->
    gluwasp_tky[["treat_main"]]

  trt_tky_by_type %>%
    filter(.data$treatmt_1 != gluwasp_tky[["treat_main"]]) %>%
    filter(.data$capacity == max(.data$capacity)) %>%
    .$treatmt_1 ->
    gluwasp_tky[["treat_sec"]]

  # significant (i.e., >50% output) advanced stage treatment?
  trt_tky %>%
    replace_na(list(treatmt_2 = "none")) %>%
    group_by(.data$treatmt_2) %>%
    summarise(capacity= sum(.data$capacity)) %>%
    mutate(prop_cap = .data$capacity / sum(.data$capacity),
           more_than_50p = if_else(.data$prop_cap > 0.5,
                                   TRUE,
                                   FALSE)) %>%
    filter(.data$treatmt_2 == "advanced water treatment") %>%
    .$more_than_50p ->
    gluwasp_tky[["adv_treatment"]]

  #=====================================================//
  # EXTRACT STATS FROM COMMON DATA ====================//

  #population and demographics
  read_common_data("pop_and_demand.csv", quo(city), "pop_served") ->
    gluwasp_tky[["pop"]]

  (1 - read_common_data("pop_and_demand.csv",
                        quo(city),
                        "pop_unserved_pc")) * 100 ->
    gluwasp_tky[["access"]]

  read_common_data("pop_and_demand.csv", quo(city), "demand") ->
    gluwasp_tky[["demand_total"]]

  read_common_data("pop_and_demand.csv", quo(city), "share_dom") *
    0.01 * gluwasp_tky$demand_total ->
    gluwasp_tky[["demand_dmstc"]]

  # business model detail
  get_business_model_detail(gluwasp_tky, quo(city)) ->
    bus_mod_detail
  bus_mod_detail$bm -> gluwasp_tky[["business_model"]]
  bus_mod_detail$rs -> gluwasp_tky[["revenue_source"]]
  bus_mod_detail$fm -> gluwasp_tky[["finance"]]
  bus_mod_detail$cr -> gluwasp_tky[["cost_rec"]]

  # catchment
  read_common_data("catchment_status.csv",
                   quo(city), "catchment_status") ->
    gluwasp_tky[["catch_type"]]

  # disinfection
  read_common_data("disinfection.csv",
                   quo(city), "dis") ->
    gluwasp_tky[["disinf_main"]]

  # fluoridation
  read_common_data("fluoridation.csv",
                   quo(city), "fluoridation") ->
    gluwasp_tky[["fluorid"]]

  # unit costs to consumer
  get_unit_cost_USD_per_m3(quo(city)) ->
    gluwasp_tky[["unit_cost"]]

  # meter penetration
  read_common_data("meter_penetration.csv",
                   quo(city), "meter_pen") ->
    gluwasp_tky[["meter_pen"]]

  # leakage
  read_common_data("leakage_rates.csv", quo(city), "leak_rate") ->
    gluwasp_tky[["leakage"]]



  #=====================================================//
  # RETURN OUTPUT =====================================//

  gluwasp_tky

}

