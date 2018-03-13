context("test-file-checks.R")

test_that("output is tibble", {
  expect_true(tibble::is_tibble(build_cwsdb()))
  expect_true(tibble::is_tibble(build_tokyo()))
})
