context("test-outputs.R")

gluwasp_current <- build_gluwasp()

test_that("output matches gluwasp data", {

  expect_equal(which((gluwasp_current == gluwasp) == F)
              %>% length(), 0)

})

test_that("resources add up to 100%", {

  gluwasp_current %>%
    mutate(total_resource = surface + ground + desal + recyc,
           test = if_else(total_resource == 1, TRUE, FALSE)) -> resource_test
  expect_equal(nrow(resource_test), sum(resource_test$test))


})



