#' get_dataset 
#' 
#' Download a predefined set of time series. 
#' @param username Your dataservice user name 
#' @param api_key Your API key
#' @param file_to_download The name of the file to retrieve.
#' @param target Path to the location, at which to store the file. If NULL, the file will be
#' saved to the working directory.
#' @examples
#' httr_response <- get_cached_data(userame, apikey, "some_file.xlsx")
#' get_cached_data(username, apikey, "some_file.xlsx", target="C:/data/some_other_name.xlsx")
#' @import httr
#' @export 
get_cached_data <- function(username, api_key, file_to_download, target=NULL) {
  
  # Make a listing call to check credentials
  # Otherwise the API response will be written to the target location without error
  get_cdc_files(username, api_key)
  
  url_template <- "https://datenservice.kof.ethz.ch/api/v1/user/%s/datasets/%s?apikey=%s"
  
  download_url <- sprintf(url_template, username, file_to_download, api_key)
  
  if(is.null(target)) {
    target <- file_to_download
  }
  
  GET(download_url, write_disk(target, overwrite=TRUE))
}