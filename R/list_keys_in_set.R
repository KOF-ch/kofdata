#' List All Keys in a Set
#'
#' List the keys of all time series in a set. To learn more about specific keys, use get_metadata.
#' @param setname The name of the set
#' @param api_key Your API key. This is only needed if accessing non-public sets
#' @return If a single set name is provided, a vector of time series keys.
#' If multiple set names are provided, a list of vectors of time series keys.
#' @import httr
#' @import jsonlite
#' @examples
#' list_keys_in_set("ds_kmi_mixed_freq")
#' @export
list_keys_in_set <- function(setname, api_key = NULL) {
  url <- "https://datenservice.kof.ethz.ch/api/v1/%s/collections/details/%s"

  keylists <- lapply(setname, function(set){
    response <- GET(sprintf(url, ifelse(is.null(api_key), "public", "main"), set))

    if(response$status_code == 200) {
      fromJSON(content(response, as = "text"))$keys
    } else if(response$status_code == 404){
      stop(sprintf("Could not find set %s!", setname))
    } else {
      stop(sprintf("An error occurred when calling the api:\nStatus: %d\nContent:%s", response$status_code, content(response, as = "text")))
    }
  })

  names(keylists) <- setname

  if(length(setname) > 1) {
    keylists
  } else {
    keylists[[1]]
  }
}
