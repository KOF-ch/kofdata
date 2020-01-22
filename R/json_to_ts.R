#' @importFrom xts xts
#' @import zoo
#' @importFrom utils browseURL
#' @importFrom stats as.ts end frequency start
.json_to_ts <- function(json_data, date_format) {
  if (is.null(date_format)) {
    xt <- na.trim(xts(json_data$value, order.by = as.yearmon(json_data$date)))
  }
  else {
    xt <- na.trim(xts(json_data$value, order.by = as.Date(json_data$date)))
  }
  if(length(xt) == 0) return(NULL)
  if(frequency(xt) < Inf  & is.regular(xt, strict = TRUE)) {
    as.ts(xt, start = start(xt), end = end(xt))
  } else {
    xt
  }
}
