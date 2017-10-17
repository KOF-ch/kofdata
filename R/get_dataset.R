#' get_dataset
#'
#' Download a predefined set of time series.
#' @param set_name The name of the set you wish to download. For a list of available sets, go to [TODO]
#' @param api_key Your API key. This is only needed if accessing non-public time series.
#' @param show_progress If set to true, shows a progress bar of the data being downloaded.
#' @import httr
#' @import jsonlite
#' @export
get_dataset <- function(set_name, api_key="", show_progress=F) {
    # Build request URL
    url <- "https://datenservice.kof.ethz.ch/api/v1/%s/sets/%s"
    
    if(nchar(api_key) != 0) {
      url <- paste0(sprintf(url, "main", set_name), "&apikey=", api_key)
    } else {
      url <- sprintf(url, "public", set_name)
    }
    
    # Call the API
    if(show_progress) {
      response <- GET(url, progress())
    } else {
      response <- GET(url)
    }
    data <- fromJSON(content(response, as="text"))
    
    switch(as.character(response$status_code), 
           "200" = {
             lapply(data, json_to_ts)
           },
           "403" = {
             stop("Could not authenticate. Please check your API key!")
           },
           "404" = {
             stop(sprintf("The API responded with\n%s.\nAre you sure the requested set exists and is %s?",
                          data$message,
                          ifelse(nchar(api_key) == 0, "public", "non-public")))
           }
    )
}