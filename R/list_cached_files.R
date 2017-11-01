#' get_dataset 
#' 
#' Download a predefined set of time series. 
#' @param username Your dataservice user name 
#' @param api_key Your API key
#' @examples 
#' available_files <- list_cached_files(username, apikey)
#' @import httr
#' @export 
list_cached_files <- function(username, api_key) {
  get_cdc_files(username, api_key)$files$name
}