#' Get Time Series form KOF Datenservice API
#'
#' Download time series data from the KOF web API. 
#' To explore the available data and find the keys to series you are interested
#' in, run \code{\link{start_key_explorer}}.
#' @param ts_keys A vector of timeseries keys
#' @param api_key Your API key. This is only needed if accessing non-public time series.
#' @param show_progress If set to true, shows a progress bar of the data being downloaded.
#' @import httr
#' @import jsonlite
#' @examples 
#' get_time_series("kofbarometer")
#' @export
get_time_series <- function(ts_keys, api_key = NULL,
                            show_progress = FALSE) {
  
  # Build request URL
  keys <- paste(ts_keys, collapse=",")
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/%s/ts"
  
  query <- list(keys = keys)
  
  if(!is.null(api_key)) {
    url <- sprintf(url, "main")
    query$apikey <- api_key
  } else {
    url <- sprintf(url, "public")
  }
  
  # Call the API
  if(show_progress) {
    response <- GET(url, progress(), query = query)
  } else {
    response <- GET(url, query = query)
  }
  data <- fromJSON(content(response, as="text"))
  status <- response$status_code
  
  if(status == 200) {
     lapply(data, .json_to_ts)
  } else if(status == 403) {
     stop("Could not authenticate. Please check your API key!")
  } else if(status == 412) {
     stop(sprintf("The API responded with\n%s.\nAre you sure the requested series are ALL %s?",
                  data$message,
                  ifelse(is.null(api_key),
                         "public", "non-public")))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  }
}
