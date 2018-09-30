context("test-outputs.R")

gluwasp_current <- build_gluwasp()

test_that("output matches gluwasp data", {

  expect_equal(which((gluwasp_current == gluwasp) == F)
              %>% length(), 0)

})

test_that("resources add up to 100%", {

  gluwasp_current %>%
    rowwise() %>%
    mutate(total_resource = sum(surface, ground, desal, recyc, na.rm = T),
           test = if_else(total_resource == 100, TRUE, FALSE)) -> resource_test
  expect_true(all(resource_test$test))

})



