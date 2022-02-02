#' Download Pre-Defined collection
#'
#' Download a predefined collection of time series.
#' @inheritParams param_defs
#' @param collection_name The name of the collection you wish to download. For a list of available collections, go to ["list_available_collections"]
#' @param show_progress If collection to true, shows a progress bar of the data being downloaded.
#' @examples
#' get_collection("ds_kmi_mixed_freq",show_progress = TRUE)
#' @import httr
#' @import jsonlite
#' @export
get_collection <- function(collection_name, api_key = NULL, show_progress = FALSE) {
  # Build request URL
  url <- "https://datenservice.kof.ethz.ch/api/v1/%s/collections/%s"
  
  query = list(
    df = "Y-m-d"
  )
  
  if(!is.null(api_key)) {
    url <- sprintf(url, "main", collection_name)
    query$apikey = api_key
  } else {
    url <- sprintf(url, "public", collection_name)
  }
  
  # Call the API
  if(show_progress) {
    response <- GET(url, progress(), query = query)
  } else {
    response <- GET(url, query = query)
  }
  
  data <- fromJSON(content(response, as = "text"))
  status <- response$status_code
  
  if(status == 200) {
    lapply(data, .json_to_ts)
  } else if(status == 403) {
    stop("Could not authenticate. Please check your API key!")
  } else if(status == 404) {
    stop(sprintf("The API responded with\n%s.\nAre you sure the requested collection exists and is %s?",
                 data$error,
                 ifelse(is.null(api_key), "public", "non-public")))
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  }
}
