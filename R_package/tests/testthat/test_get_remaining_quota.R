context("get_remaining_quota")

test_that("get_remaining_quota works", {
  expect_error(get_remaining_quota("some_nonexistent_key"), "The API returned a status code of")
})