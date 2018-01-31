#' @import httr
#' @import jsonlite
.get_cdc_files <- function(username, api_key) {
  url_template <- "https://datenservice.kof.ethz.ch/api/v1/user/%s/datasets"
  
  query <- list(apikey = api_key)
  
  listing_url <- sprintf(url_template, username)
  listing <- GET(listing_url, query = query)
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
