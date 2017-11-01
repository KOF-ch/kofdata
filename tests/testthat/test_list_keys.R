context("list_keys_in_set")

test_that("list_keys_in_set works", {
  
  sets <- list_available_sets()
  
  if(nrow(sets) > 0) {
    keys <- list_keys_in_set(sets[1, "set_name"])
    expect_true(length(keys) > 0)
    expect_is(keys, "character")
  }
  
  if(nrow(sets) > 1) {
    keylists <- list_keys_in_set(sets[1:2, "set_name"])
    expect_is(keylists, "list")
    expect_equal(names(keylists), sets[1:2, "set_name"])
  }
})
