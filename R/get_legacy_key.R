#' get_legacy_key
#' 
#' Get legacy keys for the provided new ts_keys
#' @param ts_keys A vector of time series keys
#' @return A named list of legacy keys
#' @export
get_legacy_key <- function(ts_keys) {
  metadata <- get_metadata(ts_keys)
  lapply(
    lapply(metadata, '[', "legacy_key"),
    unlist,
    use.names = FALSE
  )
}