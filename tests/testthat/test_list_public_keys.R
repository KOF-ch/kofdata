context("list_public_keys")

test_that("list_public_keys works", {
  
  sets <- list_public_keys()
  
  expect_is(sets, "character")
})
