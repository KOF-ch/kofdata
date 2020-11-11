context("get_dataset")

test_that("get_dataset works", {
  expect_error(get_dataset("some_nonexistent_set"), "The API responded")
  expect_error(get_dataset("set_doesnt_matter", "GandalfTheGray"), "Could not authenticate.")

  baros <- get_dataset("baro_vintages_monthly")

  expect_is(baros, "list")
  expect_equal(sort(names(baros))[1:3], c("baro_2014m04", "baro_2014m05", "baro_2014m06"))
  expect_is(baros[[1]], "ts")
})
