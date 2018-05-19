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

  read_gluwasp_data("storage.csv") %>%
    group_by(city, effective, stor_unit) %>%
    summarise(storage = sum(storage)) %>% ungroup() %>%
    # may need function here to deal with "effective"
    convert_storage_units() %>%
    select(city, str_Mm3) %>%
    rename(storage = str_Mm3) ->
    gluwasp_stor
  done("storage data prepared...")

  read_gluwasp_data("treatment.csv") %>%
    mutate(treatment_cap = as.double(treatment_cap)) %>%
    # ^^ can maybe remove this line after real numbers are in table!
    convert_treatcap_units() %>%
    select(city, treat_main, treat_sec,
           adv_treatment, treatment_cap_Mm3perDay) %>%
    rename(treatment_cap = treatment_cap_Mm3perDay) ->
    gluwasp_trtm
  done("treatment data prepared...")

  read_gluwasp_data("pop_and_demand.csv") %>%
    convert_demand_units() %>%
    select(city, pop_served, pop_served_pc, demand_Mm3perDay, share_dom) %>%
    mutate(demand_dmstc = demand_Mm3perDay * (share_dom / 100)) %>%
    rename(access = pop_served_pc, demand_total = demand_Mm3perDay) %>%
    select(-share_dom) ->
    gluwasp_popd
  done("population and demand data prepared...")

  read_gluwasp_data("business_models.csv") %>%
    select(city, model, rev_source, cost_rec, finance) %>%
    rename(business_model = model) ->
    gluwasp_bsmd
  done("business model data prepared...")

  read_gluwasp_data("catchment_status.csv") %>%
    rename(catch_type = catchment_status) %>%
    select(city, catch_type) ->
    gluwasp_ctch
  done("catchment data prepared...")

  read_gluwasp_data("disinfection.csv") %>%
    lose_source() %>%
    rename(disinf_main = dis) ->
    gluwasp_dsin

  read_gluwasp_data("fluoridation.csv") %>%
    lose_source() %>%
    rename(fluorid = fluoridation) ->
    gluwasp_flou
  done("disinfection and fluoridation data prepared...")

  read_gluwasp_data("leakage_rates.csv") %>%
    select(city, leak_rate) %>%
    rename(leakage = leak_rate) ->
    gluwasp_leak
  done("leakage data prepared...")

  read_gluwasp_data("meter_penetration.csv") %>%
    lose_source() ->
    gluwasp_metr
  done("metering data prepared...")

  read_gluwasp_data("water_costs.csv") %>%
    convert_costs() ->
    gluwwasp_cost
  done("currencies converted...")


  list(gluwasp_stor,
       gluwasp_trtm,
       gluwasp_popd,
       gluwasp_bsmd,
       gluwasp_ctch,
       gluwasp_dsin,
       gluwasp_flou,
       gluwasp_leak,
       gluwasp_metr,
       gluwwasp_cost) %>%
    Reduce(function(dtf1,dtf2) left_join(dtf1, dtf2, by="city"), .) ->
    gluwasp

  done("gluwasp built!")
  city_complete(paste0("gluwasp cities: ", gluwasp$city))

  gluwasp

}


# to update main datafile:
# gluwasp <- gluwasp::build_gluwasp()
# usethis::use_data(gluwasp, overwrite = T)

