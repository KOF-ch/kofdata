#' get_dataset 
#' 
#' Download a predefined set of time series. 
#' @param username Your dataservice user name 
#' @param api_key Your API key
#' @param file_to_download The name of the file to retrieve. If this is NULL, a get_cached_data
#' returns a vector of available file names instead.
#' @param target Path to the location, at which to store the file. If NULL, the file will be
#' saved to the working directory.
#' @examples 
#' available_files <- get_cached_data(username, apikey)
#' httr_response <- get_cached_data(userame, apikey, "some_file.xlsx")
#' get_cached_data(username, apikey, "some_file.xlsx", target="C:/data/some_other_name.xlsx")
#' @import httr
#' @export 
get_cached_data <- function(username, api_key, file_to_download=NULL, target=NULL) {
  
  if(is.null(file_to_download)) {
    files <- get_cdc_files(username, api_key)
    
    # TODO: what happens if there are no files? Probably c()
    files$files$name
  } else {
    # Make a listing call to check credentials
    # Otherwise the API response will be written to the target locaton without error
    get_cdc_files(username, api_key)
    
    url_template <- "https://datenservice.kof.ethz.ch/api/v1/user/%s/datasets/%s?api_key=%s"
    
    download_url <- sprintf(url_template, username, file_to_download, api_key)
    
    if(is.null(target)) {
      target <- file_to_download
    }
    
    GET(download_url, write_disk(target, overwrite=TRUE))
  }
}

# Helper to get file listing
#' @import httr
#' @import jsonlite
get_cdc_files <- function(username, api_key) {
  url_template <- "https://datenservice.kof.ethz.ch/api/v1/user/%s/datasets?api_key=%s"
  listing_url <- sprintf(url_template, username, api_key)
  listing <- GET(listing_url)
  files <- fromJSON(content(listing, as="text"))
  if(!is.null(files$message)) {
    if(grepl("Invalid authentication credentials", files$message)) {
      stop("Invalid API key!")
    } else if(grepl("no API found", files$message)) {
      stop("Username not found!")
    }
  }
  
  files
}