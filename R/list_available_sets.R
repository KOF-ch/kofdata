#' List Available Set Names and Their Description
#'
#' Sets are pre-defined lists of time series. Sets are the convenient alternative to concatenating many series in an URL.
#' @return A data frame with the names, descriptions and public availability of datasets. These sets can be downloaded via get_dataset.
#' @import httr
#' @import jsonlite
#' @examples 
#' list_available_sets()
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
