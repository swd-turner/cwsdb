# make_gluwasp_tb
# Sets up a basic empty tibble with gluwasp column headers
make_gluwasp_tb <- function(){
  tibble::tibble(
    city = as.character(NA),
    country = as.character(NA),
    pop = as.integer(NA),
    access = as.double(NA),
    demand_total = as.double(NA),
    demand_dmstc = as.double(NA),
    storage = as.double(NA),
    catch_type = as.character(NA),
    # ^^ allowed values: "protected", "managed", "unmanaged"
    surface = as.double(NA),
    ground = as.double(NA),
    desal = as.double(NA),
    recyc = as.double(NA),
    treat_cap = as.double(NA),
    treat_main = as.character(NA),
    # ^^ allowed values: "slow_sand", "rapid_sand", "natural", ...
    # ... "membrane", "reverse_osmosis"
    treat_sec = as.character(NA),
    # ^^ allowed values as treat_main
    adv_treatment = as.logical(NA),
    disinf_main = as.character(NA),
    # ^^ allowed values: "chlorine", "chlorine_dioxide", ...
    # ... "chloramine", "ozone", "UV"
    fluorid = as.logical(NA),
    unit_cost = as.double(NA),
    leakage = as.double(NA),
    meter_pen = as.double(NA),
    business_model = as.character(NA),
    # ^^ allowed values: "gvt_utility", "delegated_man", ...
    # ... "municipal_brd", "coop","corp_utility", ...
    # ... "pub_corp", "private_utility"
    revenue_source = factor(NA),
    # ^^ allowed values: "user_rates", "property_taxes", "subsidy"
    cost_rec = as.logical(NA),
    finance = as.character(NA)
    # allowed values: "state_subsidy", "bond_issue", "PPP", "mixed"
  )
}

# read_gluwasp_data
# read in gluwasp data
read_gluwasp_data <- function(file){

  # suppress readr column parsing messages
  options(readr.num_columns = 0)

  readr::read_csv(system.file(paste0("extdata/common"),
                              file,
                              package = "gluwasp"),
                  comment = "#")
}


# read_common_data
# read in data from common file
read_common_data <- function(file, city, col_name){

  read_gluwasp_data(file, "common") %>%
    filter(city == !! city) %>%
    select(one_of(col_name)) %>%
    `[[`(1)
}




# check_input_comments
# check comments include necessary fields
check_input_comments <- function(file){

  # ensure file is csv type
  if (substr(file, nchar(file) - 3, nchar(file)) != ".csv") {
    stop(
      "first argument must be of type .csv and be named with .csv extension",
      call. = FALSE
    )
  }

  # read in comment lines
  readr::read_lines(system.file(paste0("extdata/"),
                              file,
                              package = "gluwasp")) -> fl

  cmt_file <- strsplit(fl[which(grepl("# File:",fl))],
                       "# File: ")[[1]][2]
  cmt_titl <- strsplit(fl[which(grepl("# Title:", fl))],
                       "# Title: ")[[1]][2]
  cmt_unit <- strsplit(fl[which(grepl("# Units:", fl))],
                       "# Units: ")[[1]][2]
  cmt_desc <- strsplit(fl[which(grepl("# Description:", fl))],
                       "Description: ")[[1]][2]
  cmt_scrc <- strsplit(fl[which(grepl("# Source:", fl))],
                       "Source: ")[[1]][2]

  c(
    cmt_file == (strsplit(file, "/")[[1]] %>% last),
    length(cmt_titl) > 0,
    length(cmt_unit) > 0,
    length(cmt_desc) > 0,
    length(cmt_scrc) > 0
  )
}


# is_input_csv
# T/F for whether a file name has ".csv" at the end
is_input_csv = function(file){
  substr(file, nchar(file) - 3, nchar(file)) == ".csv"
}


# get_cmn_src_names
# get source reference names for cross-testing
get_cmn_src_names <- function(file){
  readr::read_csv(system.file("extdata",
                              file,
                              package = "gluwasp"),
                  comment = "#") %>% .$source_ref
}

# get_business_model_detail
# get business model info
get_business_model_detail <- function(tb, city){

  read_common_data("business_models.csv", quo(city), "model") ->
    bm

  read_common_data("business_models.csv", quo(city), "rev_source") ->
    rs

  read_common_data("business_models.csv", quo(city), "finance") ->
    fm

  read_common_data("business_models.csv", quo(city), "cost_rec") ->
    cr

  tibble(bm, rs, fm, cr)

}

# convert_to_USD_per_m3
# convert unit cost to USD per m3
get_unit_cost_USD_per_m3 <- function(city){

  read_gluwasp_data("water_costs.csv", "common") %>%
    filter(city == !! city) ->
    unit_cost_raw

  read_gluwasp_data("currency_conversion.csv", "") %>%
    right_join(unit_cost_raw,
               by = c("code" = "currency")) %>%
    mutate(cost_USD = .data$cost * .data$rate) %>%
    .$cost_USD ->
    cost_USD

  if(unit_cost_raw[["volumetric_unit"]] == "m3") cost_USD

}
