# convert_storage_units
# convert storage units to Mm3
convert_storage_units <- function(raw_data){
  raw_data %>%
    mutate(str_Mm3 = case_when(
      stor_unit == "Mm3" ~ storage,
      stor_unit == "m3" ~ storage * m3_to_Mm3
    ))
}

# convert_treatcap_units
# convert treatment capacity units to Mm3/day
convert_treatcap_units <- function(raw_data){
  raw_data %>%
    mutate(treatment_cap_Mm3perDay = case_when(
      unit == "Mm3/day" ~ treatment_cap,
      unit == "m3/day" ~ treatment_cap * m3_to_Mm3
    ))
}

# convert_demand_units
# convert city demand units to Mm3/day
convert_demand_units <- function(raw_data){
  raw_data %>%
    mutate(demand_Mm3perDay = case_when(
      dem_unit == "Mm3/year" ~ demand,
      dem_unit == "Mm3/d" ~ demand * perday_to_peryear,
      dem_unit == "MGi/d" ~ demand * perday_to_peryear * Gi_to_m3
    ))
}

# convert_costs
# join the currency conversion table into the cost data and convert volume to m3
convert_costs <- function(raw_data){
  raw_data %>%
    left_join(
      read_gluwasp_data("currency_conversion.csv"),
      by = c("currency" = "code")
    ) %>%
    mutate(cost_USD = cost * rate) %>%
    mutate(cost_USD_per_m3 = case_when(
      volumetric_unit == "m3" ~ cost_USD
    )) %>%
    select(city, cost_USD_per_m3) %>%
    rename(unit_cost = cost_USD_per_m3)
}

# lose_source
# remove source_ref from data
lose_source <- function(data){
  data %>% select(-source_ref)
}
