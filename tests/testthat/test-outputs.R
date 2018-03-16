context("test-outputs.R")

test_that("output matches gluwasp data", {

  expect_equal(which((build_gluwasp() == gluwasp) == F)
              %>% length(), 0)

})



