#' Helper to turn api-returned json (lists) into lists of ts objects
#' @importFrom xts xts
json_to_ts <- function(json_data) {
  xt <- xts(json_data$value, order.by = zoo::as.yearmon(json_data$date))
  if(frequency(xt) < Inf) {
    as.ts(xt, start = start(xt), end = end(xt))
  } else {
    xt
  }
}