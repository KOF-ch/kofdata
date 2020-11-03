#' List Available Set Names and Their Description
#'
#' Sets are pre-defined lists of time series. Sets are the convenient alternative to concatenating many series in an URL.
#' @param api_key Your API key. This is only needed if accessing non-public sets
#' @return A data frame with the names, descriptions and public availability of datasets. These sets can be downloaded via get_dataset.
#' @import httr
#' @import jsonlite
#' @examples
#' list_available_sets()
#' @export
list_available_sets <- function(api_key = NULL) {

  # Build request URL
  url <- sprintf("https://datenservice.kof.ethz.ch/api/v1/%s/collections/", ifelse(is.null(api_key), "public", "main"))
  query <- list(apikey = api_key)

  response <- GET(url, query = query)

  if(response$status_code == 200) {
    ret <- fromJSON(content(response, as = "text"))
    data.frame(
      set_name = names(ret),
      set_description = sapply(ret, '[[', "description"),
      is_public = sapply(ret, '[[', "is_public"),
      stringsAsFactors = FALSE
    )
  } else {
    stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
  }
}
