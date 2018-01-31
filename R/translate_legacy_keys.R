#' translate_legacy_keys
#' 
#' Gives ts_keys for the given legacy keys.
#' Since there is no one to one mapping from old to new keys, it is possible that multiple new keys are returned for an old key.
#' Note: Not all possible new keys are returned. The keys returned by this function should serve as a starting point to find the
#' specific new keys that are needed. For the key explorer to find the exact keys, see \code{\link{start_key_explorer}}.
#' @param legacy_keys A vector of legacy keys for which to find new keys
#' @return A list of vectors of new ts_keys
#' @import httr
#' @import jsonlite
#' @export
translate_legacy_keys <- function(legacy_keys) {
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata/translatelegacykeys"
  
  legacy_keys <- paste(legacy_keys, collapse=",")
  
  response <- GET(url, query = list(keys = legacy_keys))
  fromJSON(content(response, as="text"))
}
