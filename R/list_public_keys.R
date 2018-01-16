#' List Keys for All Publicly Available Time Series
#'
#' @return An array of all public time series keys.
#' @import httr
#' @import jsonlite
#' @examples 
#' list_public_keys()
#' @export
list_public_keys <- function() {
  # Build request URL
  url <- "https://datenservice.kof.ethz.ch/api/v1/public/listkeys"
  
  response <- GET(url)
  
  if(response$status_code == 200) {
    fromJSON(content(response, as = "text"))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  } 
}
