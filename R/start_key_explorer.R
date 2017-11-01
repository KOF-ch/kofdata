#' start_key_explorer
#' 
#' Opens the key explorer page in your browser.
#' The key explorer is a web application designed to help you quickly find the identifying keys
#' for the time series you are interested in.
#' @export
start_key_explorer <- function() {
  browseURL("https://datenservice.kof.ethz.ch/static/keyexplorer/")
}