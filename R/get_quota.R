#' Check Remaining Quota
#' 
#' Query the API for the number of time series downloads remaining in the current month. 
#' @param api_key Your API key
#' @examples 
#' get_remaining_quota("313984fcd9f343d3961891319b0ed321")
#' @import httr
#' @export 
get_remaining_quota <- function(api_key, use_tempfile = FALSE) {
  
  query = list(apikey = api_key)
  
  response <- kofdata_get("https://datenservice.kof.ethz.ch/api/v1/main/remainingquota", use_tempfile = use_tempfile, query = query)
  
  if(response$status_code == 200) {
    fromJSON(content(response, as="text"))$quota
  } else {
    stop(sprintf("The API returned a status code of %d. Are you sure you provided a valid API key?", response$status_code))
  }
}
