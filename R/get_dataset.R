#' Download Pre-Defined Dataset
#'
#' Download a predefined set of time series.
#' @param set_name The name of the set you wish to download. For a list of available sets, go to [TODO]
#' @param api_key Your API key. This is only needed if accessing non-public time series. Defaults to NULL (public data).
#' @param show_progress If set to true, shows a progress bar of the data being downloaded.
#' @examples
#' get_dataset("ds_kmi_mixed_freq",show_progress = TRUE)
#' @import httr
#' @import jsonlite
#' @export
get_dataset <- function(set_name, api_key = NULL, show_progress = FALSE) {
    # Build request URL
    url <- "https://datenservice.kof.ethz.ch/api/v1/%s/sets/%s"

    query = list(
      df = "Y-m-d"
    )

    if(!is.null(api_key)) {
      url <- sprintf(url, "main", set_name)
      query$apikey = api_key
    } else {
      url <- sprintf(url, "public", set_name)
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
       stop(sprintf("The API responded with\n%s.\nAre you sure the requested set exists and is %s?",
                    data$message,
                    ifelse(is.null(api_key), "public", "non-public")))
    } else {
      stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
    }
}
