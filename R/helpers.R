# make_gluwasp_tb
# Sets up a basic empty tibble with gluwasp column headers
make_gluwasp_tb <- function(){
  tibble(city = as.character(NA),
         country = as.character(NA),
         pop = as.integer(NA),
         demand = as.double(NA),
         storage = as.double(NA),
         num_res = as.integer(NA),
         catch_area = as.double(NA),
         catch_type = factor(NA, levels = c("unprotected",
                                            "protected",
                                            "mixed")),
         surf = as.double(NA),
         ground = as.double(NA),
         unconv = as.double(NA),
         desal_max = as.double(NA),
         treatment_cap = as.double(NA),
         purif_main = factor(NA, levels = c("slow_sand",
                                            "rapid_sand",
                                            "natural",
                                            "membrane",
                                            "reverse_osmosis")),
         purif_sec = purif_main,
         adv_treatment = as.logical(NA),
         disinf_main = factor(NA, levels = c("chlorine",
                                             "chlorine_dioxide",
                                             "chloramine",
                                             "ozone",
                                             "UV")),
         fluoride = as.logical(NA),
         leakRate = as.double(NA),
         operator = as.character(NA),
         ownership = factor(NA, levels = c("public",
                                           "private")))
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

