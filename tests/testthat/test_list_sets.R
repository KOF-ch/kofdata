context("list_available_sets")

test_that("list_available_sets works", {
  
  sets <- list_available_sets()
  
  expect_is(sets, "data.frame")
  expect_equal(ncol(sets), 3)
  expect_equal(names(sets), c("set_name", "set_description", "is_public"))
  
  if(nrow(sets) > 0) {
    expect_is(sets[1, "set_name"], "character")
    expect_is(sets[1, "set_description"], "character")
    expect_is(sets[1, "is_public"], "logical")
  }
})
  