#' get_metadata
#' 
#' Download metadata relating to the specified keys.
#' @param ts_keys A vector of time series keys.
#' @param locale The language in which to return the metadata (if available)
#' @return A named list of lists containing metadata.
#' @import httr
#' @import jsonlite
#' @export
get_metadata <- function(ts_keys, locale=c("en", "de", "fr", "it")) {
  
  locale <- match.arg(locale)
  
  url_template <- "https://datenservice.kof.ethz.ch/api/v1/metadata?key=%s&locale=%s"
  
  meta_data <- lapply(ts_keys, function(key) {
    url <- sprintf(url_template, key, locale)
    
    response <- GET(url)
    data <- fromJSON(content(response, as="text"))
    data[data == "NA"] <- NA
    
    if(!is.null(data$info)) {
      NA
    } else {
      data
    }
  })
  
  names(meta_data) <- ts_keys
  
  meta_data
}