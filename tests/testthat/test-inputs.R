context("test-inputs.R")

all_files = list.files(system.file("extdata/",
                                   package = "gluwasp"),
                       recursive = T)

test_that("inputs are type .csv", {
  expect_equal(sum(sapply(all_files, is_input_csv)),
               length(all_files))
})

# test_that("inputs are commented correctly", {
# })

test_that("sources are cross-referenced", {

})
