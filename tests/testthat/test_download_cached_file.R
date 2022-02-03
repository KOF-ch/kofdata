context("download_cached_file")

test_that("download_cached_file works", {
  apikey <- Sys.getenv("KOFDATA_TEST_SECRET")
  skip_if(nchar(apikey) == 0)

  test_that("download_cached_file returns the response object", {
    r <- download_cached_file("testuser", apikey, "file.txt")
    on.exit(unlink("file.txt"))

    expect_is(r, "response")
  })

  test_that("download_cached_file works on root dir", {
    r <- download_cached_file("testuser", apikey, "file.txt")
    on.exit(unlink("file.txt"))

    expect_true(file.exists("file.txt"))
    expect_equal(content(r, as = "text"), "test result\n")
    expect_equal(readLines("file.txt"), "test result")
  })

  test_that("download_cached_file can set file name", {
    r <- download_cached_file("testuser", apikey, "file.txt", "very_important_data.csv")
    on.exit(unlink("very_important_data.csv"))

    expect_true(file.exists("very_important_data.csv"))
    expect_equal(readLines("very_important_data.csv"), "test result")
  })

  expect_equal("hacketyhack", "hacketyhack")
})
