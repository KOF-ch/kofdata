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
.Deprecated("list_available_collections")
}

