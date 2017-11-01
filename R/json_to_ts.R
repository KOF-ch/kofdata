#' Helper to turn api-returned json (lists) into lists of ts objects
#' @importFrom xts xts
#' @import zoo
json_to_ts <- function(json_data) {
  xt <- na.trim(xts(json_data$value, order.by = as.yearmon(json_data$date)))
  if(frequency(xt) < Inf) {
    as.ts(xt, start = start(xt), end = end(xt))
  } else {
    xt
  }
}
