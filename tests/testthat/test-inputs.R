context("test-inputs.R")

all_files = list.files(system.file("extdata/",
                                   package = "gluwasp"),
                       recursive = T)

common_files = all_files[which(grepl("common/", all_files))]

city_files = all_files[which(!grepl("common/", all_files)
                             & grepl("/", all_files))]

source_file = system.file("extdata/sources.csv",
                          package = "gluwasp")

test_that("inputs are type .csv", {
  expect_equal(sum(sapply(all_files, is_input_csv)),
               length(all_files))
})

# test_that("inputs are commented correctly", {
# })

test_that("sources are cross-referenced", {
  sources <- readr::read_csv(source_file, comment = "#") %>% .$abbrv
  cmn_src_names <- unlist(lapply(common_files, get_cmn_src_names))
  expect_equal(sum(cmn_src_names %in% sources), length(cmn_src_names))
})
