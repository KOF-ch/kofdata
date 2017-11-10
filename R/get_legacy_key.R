#' Get a Former Time Series Identifier from KOF Database
#' 
#' Get legacy keys given new time series keys. Note that not all records need to have 
#' a legacy key because there are more new keys than old keys.
#' @param ts_keys A vector of time series keys
#' @return A named list of legacy keys
#' @examples 
#' get_legacy_key("ch.kof.inu.run1.ng08.fx.q_ql_ass_bs.balance")
#' @export
get_legacy_key <- function(ts_keys) {
  metadata <- get_metadata(ts_keys)
  lapply(
    lapply(metadata, '[', "legacy_key"),
    unlist,
    use.names = FALSE
  )
}
