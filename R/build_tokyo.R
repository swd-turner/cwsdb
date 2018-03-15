#' build_tokyo
#'
#' Build the Tokyo csw entry from raw data
#'
#' @details Builds the cws entry for Tokyo
#' @return A row of
#' @importFrom tibble tibble
#' @importFrom tidyr replace_na
#' @import dplyr
#' @author SWDT March 2018
#' @export

build_tokyo <- function() {

  #=====================================================//
  # SETUP =============================================//

  # read city name (must be identical to data folder name for city)
  cty ="Tokyo"

  # suppress readr column parsing messages
  options(readr.num_columns = 0)

  # get shell tibble and name city
  make_gluwasp_tb() %>%
    mutate(city = cty,
           country = "Japan") -> gluwasp_tky

  #=====================================================//
  # READ DATA FILES ===================================//

  # read reservoir data
  read_gluwasp_data("tokyo_storage.csv", cty) ->
    res_tky

  # read water treatment data
  read_gluwasp_data("tokyo_treatment.csv", cty) %>%
    mutate(treatment1 = case_when(
      grepl("rapid", treatment1) ~ "rapid_sand",
      grepl("slow", treatment1) ~ "slow_sand",
      grepl("membrane", treatment1) ~ "membrane")) ->
    trt_tky


  #=====================================================//
  # COMPUTE STATS =====================================//

  # compute total storage
  res_tky %>%
    select(effective_capacity) %>%
    sum() ->
    gluwasp_tky[["storage"]]

  # compute number of reservoirs
  res_tky %>%
    nrow() ->
    gluwasp_tky[["num_res"]]

  # compute treatment capacity
  trt_tky %>%
    select(capacity) %>%
    sum() * m3_to_Mm3 ->
    gluwasp_tky[["treat_cap"]]

  # determine main modes of treatment
  trt_tky %>%
    group_by(treatment1) %>%
    summarise(capacity = sum(capacity) * m3_to_Mm3) ->
    trt_tky_by_type

  trt_tky_by_type %>%
    filter(capacity == max(capacity)) %>%
    .$treatment1 ->
    gluwasp_tky[["treat_main"]]

  trt_tky_by_type %>%
    filter(treatment1 != gluwasp_tky[["treat_main"]]) %>%
    filter(capacity == max(capacity)) %>%
    .$treatment1 ->
    gluwasp_tky[["treat_sec"]]

  # significant (i.e., >50% output) advanced stage treatment?
  trt_tky %>%
    tidyr::replace_na(list(treatment2 = "none")) %>%
    group_by(treatment2) %>%
    summarise(capacity= sum(capacity)) %>%
    mutate(prop_cap = capacity / sum(capacity),
           more_than_50p = if_else(prop_cap > 0.5,
                                   TRUE,
                                   FALSE)) %>%
    filter(treatment2 == "advanced water treatment") %>%
    .$more_than_50p ->
    gluwasp_tky[["adv_treatment"]]

  #=====================================================//
  # EXTRACT STATS FROM COMMON DATA ====================//

  read_common_data("leakage_rates.csv", cty, "leakRate") ->
    gluwasp_tky[["leakage"]]

  #=====================================================//
  # RETURN OUTPUT =====================================//

  gluwasp_tky

}

