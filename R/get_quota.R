#' Check Remaining Quota
#' 
#' Query the API for the number of time series downloads remaining in the current month. 
#' @param api_key Your API key
#' @examples 
#' get_remaining_quota("313984fcd9f343d3961891319b0ed321")
#' @import httr
#' @export 
get_remaining_quota <- function(api_key) {
  response <- GET(paste0("https://datenservice.kof.ethz.ch/api/v1/main/remainingquota?apikey=", api_key))
  
  if(response$status_code == 200) {
    fromJSON(content(response, as="text"))$quota
  } else {
    stop(sprintf("The API returned a status code of %d. Are you sure you provided a valid API key?", response$status_code))
  }
}
