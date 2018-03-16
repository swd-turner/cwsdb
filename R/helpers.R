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
    operator = as.character(NA),
    ownership = factor(NA,
                      levels = c("state",
                                 "private",
                                 "fragmented")),
    finance_model = factor(NA,
                          levels = c("state",
                                     "PPP")))
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


# read_input_comments
# read in comments for testing
read_input_comments <- function(file, city){

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


# is_input_csv
# T/F for whether a file name has ".csv" at the end
is_input_csv = function(file){
  substr(file, nchar(file) - 3, nchar(file)) == ".csv"
}





