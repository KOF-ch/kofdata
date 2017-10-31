#' list_available_sets
#'
#' Get a list of all available data sets.
#' @return A data frame with the names, descriptions and public availability of datasets. These sets can be downloaded via get_dataset.
#' @import httr
#' @import jsonlite
#' @export
list_available_sets <- function() {
  # Build request URL
  url <- "https://datenservice.kof.ethz.ch/api/v1/sets/"

  response <- GET(url)
  
  if(response$status_code == 200) {
    fromJSON(content(response, as = "text"))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  }
}
