context("get_collection")

test_that("get_collection works", {
  expect_error(get_collection("some_nonexistent_set"), "The API responded")
  expect_error(get_collection("set_doesnt_matter", "GandalfTheGray"), "Could not authenticate.")

  baros <- get_collection("baro_vintages_monthly")

  expect_is(baros, "list")
  expect_equal(sort(names(baros))[1:3], c("baro_2014m04", "baro_2014m05", "baro_2014m06"))
  expect_is(baros[[1]], "ts")
})
