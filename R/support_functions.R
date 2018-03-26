# make_gluwasp_tb
# Sets up a basic empty tibble with gluwasp column headers
make_gluwasp_tb <- function(){
  tibble::tibble(
    city = as.character(NA),
    country = as.character(NA),
    pop = as.integer(NA),
    demand = as.double(NA),
    storage = as.double(NA),
    num_res = as.integer(NA),
    catch_area = as.double(NA),
    catch_type = factor(NA,
                       levels = c("unprotected",
                                  "protected",
                                  "mixed")),
    surface = as.double(NA),
    ground = as.double(NA),
    desal = as.double(NA),
    recyc = as.double(NA),
    desal_max = as.double(NA),
    recyc_max = as.double(NA),
    treat_cap = as.double(NA),
    treat_main = factor(NA,
                       levels = c("slow_sand",
                                  "rapid_sand",
                                  "natural",
                                  "membrane",
                                  "reverse_osmosis")),
    treat_sec = .data$treat_main,
    adv_treatment = as.logical(NA),
    disinf_main = factor(NA,
                        levels = c("chlorine",
                                   "chlorine_dioxide",
                                   "chloramine",
                                   "ozone",
                                   "UV")),
    fluoride = as.logical(NA),
    leakage = as.double(NA),
    meter_pen = as.double(NA),
    business_model = factor(NA,
                            levels = c("gvt_utility",
                                       "municipal_brd",
                                       "coop",
                                       "corp_utility",
                                       "private_utility")),
    revenue_source = factor(NA,
                            levels = c("user_rates",
                                       "property_taxes",
                                       "subsidy")),
    cost_rec = as.logical(NA),
    finance = factor(NA, levels = c("state_subsidy",
                                    "bond_issue",
                                    "PPP",
                                    "mixed")))
}

# read_gluwasp_data
# read in gluwasp data
read_gluwasp_data <- function(file, city){

  # ensure file is csv type
  if (substr(file, nchar(file) - 3, nchar(file)) != ".csv") {
    stop(
      "first argument must be of type .csv and be named with .csv extension",
      call. = FALSE
    )
  }

  # read in data
  readr::read_csv(system.file(paste0("extdata/", city),
                              file,
                              package = "gluwasp"),
                  comment = "#")
}


# read_common_data
# read in data from common file
read_common_data <- function(file, city, col_name){

  # ensure file is csv type
  if (substr(file, nchar(file) - 3, nchar(file)) != ".csv") {
    stop(
      "first argument must be of type .csv and be named with .csv extension",
      call. = FALSE
    )
  }

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
get_cmn_src_names = function(file){
  readr::read_csv(system.file("extdata",
                              file,
                              package = "gluwasp"),
                  comment = "#") %>% .$source_ref
}

