#' get_dataset 
#' 
#' Download a predefined set of time series. 
#' @param username Your dataservice user name 
#' @param api_key Your API key
#' @param file_to_download The name of the file to retrieve.
#' @param target Path to the location, at which to store the file. If NULL, the file will be
#' saved to the working directory.
#' @examples
#' f <-  download_cached_file("kofdatapkg", "313984fcd9f343d3961891319b0ed321",
#' "empty.txt",file.path(tempdir(),"empty.txt"))
#' @import httr
#' @export 
download_cached_file <- function(username, api_key, file_to_download, target=NULL) {
  
  # Make a listing call to check credentials
  # Otherwise the API response will be written to the target location without error
  files <- .get_cdc_files(username, api_key)
  
  if(!(file_to_download %in% files$files$name)) {
    stop(sprintf("Could not find file %s!", file_to_download))
  }
  
  url_template <- "https://datenservice.kof.ethz.ch/api/v1/user/%s/datasets/%s"
  
  query <- list(apikey = api_key)
  
  download_url <- sprintf(url_template, username, file_to_download)
  
  if(is.null(target)) {
    target <- file_to_download
  }
  
  GET(download_url, write_disk(target, overwrite=TRUE), query = query)
}
