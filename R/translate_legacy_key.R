#' Get a Current Time Series Identifier Given Legacy Keys
#' 
#' Get new keys given old time series keys. Some legacy keys match more than one new key as more data is stored. This functions tries to return a single new key per old key. It always returns run 1, Noga08, mixed frequency keys.
#' @param legacy_keys A vector of KOF legacy keys
#' @param show_progress logical show progress bar bey shown? Defaults to TRUE.
#' @return A named list of time series keys
#' @examples 
#' translate_legacy_key("chimt_d_f7_s01")
#' @export
translate_legacy_key <- function(legacy_keys,
                                 show_progress = T) {
  
  keys <- paste(legacy_keys, collapse=",")
  
  query <- list(keys = keys)
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata/translatelegacykeys"
  
  # Call the API
  if(show_progress) {
    response <- GET(url, progress(), query = query)
  } else {
    response <- GET(url, query = query)
  }
  
  data <- fromJSON(content(response, as="text"))
  
  data
}
