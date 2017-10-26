context("get_time_series")

test_that("get_time_series works", {
  expect_error(get_time_series("some_nonexistent_key", show_progress = F), "The API responded")
  expect_error(get_time_series("key_doesnt_matter", "GandalfTheGray", show_progress = F), "Could not authenticate.")
  
  baro <- get_time_series("kofbarometer", show_progress = F)
  
  expect_is(baro, "list")
  expect_equal(names(baro), "kofbarometer")
  expect_is(baro$kofbarometer, "ts")
})
