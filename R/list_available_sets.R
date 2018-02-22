#' List Available Set Names and Their Description
#'
#' Sets are pre-defined lists of time series. Sets are the convenient alternative to concatenating many series in an URL.
#'
#' @param use_tempfile Store downloaded data to a temporary file and read from there.
#' This option can be used to work around security measures preventing reading directly into RStudio's memory.
#'
#' @return A data frame with the names, descriptions and public availability of datasets. These sets can be downloaded via get_dataset.
#' @import httr
#' @import jsonlite
#' @examples 
#' list_available_sets()
#' @export
list_available_sets <- function(use_tempfile = FALSE) {
  # Build request URL
  url <- "https://datenservice.kof.ethz.ch/api/v1/sets/"

  response <- kofdata_get(url, use_tempfile)
  
  if(response$status_code == 200) {
    fromJSON(content(response, as = "text"))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  }
}
