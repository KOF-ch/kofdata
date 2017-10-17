#' get_time_series
#'
#' Download time series data from the KOF web API. 
#' To explore the available data and find the keys to series you are interested
#' in, run \code{\link{start_key_explorer()}}.
#' @param ts_keys A vector of timeseries keys
#' @param api_key Your API key. This is only needed if accessing non-public time series.
#' @param show_progress If set to true, shows a progress bar of the data being downloaded.
#' @import httr
#' @import jsonlite
#' @export
get_time_series <- function(ts_keys, api_key = NULL,
                            show_progress = TRUE) {
  
  # Build request URL
  keys <- paste(ts_keys, collapse=",")
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/%s/ts?keys=%s"
  
  if(!is.null(api_key)) {
    url <- paste0(sprintf(url, "main", keys), "&apikey=", api_key)
  } else {
    url <- sprintf(url, "public", keys)
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
         "412" = {
           stop(sprintf("The API responded with\n%s.\nAre you sure the requested series are ALL %s?",
                        data$message,
                        ifelse(is.null(api_key),
                               "public", "non-public")))
         }
  )
}
