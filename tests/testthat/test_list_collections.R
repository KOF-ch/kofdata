context("list_available_collections")

test_that("list_available_collections works", {

  collections <- list_available_collections()

  expect_is(collections, "data.frame")
  expect_equal(ncol(collections), 3)
  expect_equal(names(collections), c("collection_name", "collection_description", "is_public"))

  if(nrow(collections) > 0) {
    expect_is(collections[1, "collection_name"], "character")
    expect_is(collections[1, "collection_description"], "character")
    expect_is(collections[1, "is_public"], "logical")
  }
})
