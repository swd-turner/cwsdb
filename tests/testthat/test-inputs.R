context("test-inputs.R")

all_files = list.files(system.file("extdata/",
                                   package = "gluwasp"),
                       recursive = T)

common_files = all_files[which(grepl("common/", all_files))]

source_file = system.file("extdata/sources.csv",
                          package = "gluwasp")

test_that("inputs are type .csv", {
  expect_equal(sum(sapply(all_files, is_input_csv)),
               length(all_files))
})

test_that("inputs are commented correctly", {
  expect_true(all(unlist(lapply(common_files, check_input_comments)) == TRUE))
})

test_that("sources are cross-referenced", {
  sources <- readr::read_csv(source_file, comment = "#") %>% .$abbrv
  cf_filtered <- common_files[!grepl("cities", common_files) & !grepl("currency", common_files)]
  cmn_src_names <- unlist(lapply(cf_filtered, get_cmn_src_names))
  expect_equal(sum(cmn_src_names %in% sources), length(cmn_src_names))
})

test_that("catchment status is valid", {
  status_list <- read_gluwasp_data("catchment_status.csv") %>%
    .$catchment_status
  acceptable_entries <- c("protected", "managed", "unmanaged")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("business model is valid", {
  status_list <- read_gluwasp_data("business_models.csv") %>%
    .$model
  acceptable_entries <- c("gvt_utility", "delegated_man", "municial_brd",
                          "coop", "corp_utility","pub_corp", "private_utility")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("finance models are valid", {
  status_list <- read_gluwasp_data("business_models.csv") %>%
    .$finance
  acceptable_entries <- c("state_subsidy", "bond_issue", "PPP", "mixed")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("revenue sources are valid", {
  status_list <- read_gluwasp_data("business_models.csv") %>%
    .$rev_source
  acceptable_entries <- c("user_rates", "property_taxes", "subsidy")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("revenue sources are valid", {
  status_list <- read_gluwasp_data("business_models.csv") %>%
    .$rev_source
  acceptable_entries <- c("user_rates", "property_taxes", "subsidy")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("disinfection methods are valid", {
  status_list <- read_gluwasp_data("disinfection.csv") %>%
    .$dis
  acceptable_entries <- c("chlorine", "chlorine_dioxide",
                          "chloramine", "ozone", "UV")
  testthat::expect_equal(sum(is.element(status_list, acceptable_entries)),
                         length(status_list))
})

test_that("treatment technologies are valid", {
  status_list_main <- read_gluwasp_data("treatment.csv") %>%
    .$treat_main

  status_list_sec <- read_gluwasp_data("treatment.csv") %>%
    .$treat_sec

  acceptable_entries <- c("slow_sand", "rapid_sand", "natural",
                          "membrane", "reverse_osmosis", "unreported")

  testthat::expect_equal(sum(is.element(status_list_main, acceptable_entries)),
                         length(status_list_main))

  testthat::expect_equal(sum(is.element(status_list_sec, acceptable_entries)),
                         length(status_list_sec))
})




