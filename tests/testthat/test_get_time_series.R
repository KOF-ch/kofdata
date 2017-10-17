context("get_time_series")

test_that("get_time_series works", {
  expect_error(get_time_series("some_nonexistent_key"), "The API responded")
  expect_error(get_time_series("key_doesnt_matter", "GandalfTheGray"), "Could not authenticate.")
  
  baro <- get_time_series("kofbarometer")
  
  expect_is(baro, "list")
  expect_equal(names(baro), "kofbarometer")
  expect_is(baro$kofbarometer, "ts")
})