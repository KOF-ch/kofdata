#' List Keys for All Publicly Available Time Series
#'
#' @param use_tempfile Store downloaded data to a temporary file and read from there.
#' This option can be used to work around security measures preventing reading directly into RStudio's memory.
#'
#' @return An array of all public time series keys.
#' @import httr
#' @import jsonlite
#' @examples 
#' list_public_keys()
#' @export
list_public_keys <- function(use_tempfile = FALSE) {
  # Build request URL
  url <- "https://datenservice.kof.ethz.ch/api/v1/public/listkeys"
  
  response <- kofdata_get(url, use_tempfile = use_tempfile)
  
  if(response$status_code == 200) {
    fromJSON(content(response, as = "text"))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  } 
}
