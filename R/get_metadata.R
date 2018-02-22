#' Get Localized Meta Information
#' 
#' Download metadata given a time series key.
#' @param ts_keys A vector of time series keys.
#' @param locale character ISO-2-digit language of requested metadata. Meta data
#' are for survey related typically available in English, German, French and Italian. 
#' Non survey data are not provided with meta information, yet. 
#' @param use_tempfile Store downloaded data to a temporary file and read from there.
#' This option can be used to work around security measures preventing reading directly into RStudio's memory.
#' @return A named list of lists containing metadata.
#' @import httr
#' @import jsonlite
#' @examples 
#' get_metadata("ch.kof.inu.run1.ng08.fx.q_ql_ass_bs.balance","en")
#' @export
get_metadata <- function(ts_keys, locale=c("en", "de", "fr", "it"), use_tempfile = FALSE) {
  
  locale <- match.arg(locale)
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata"
  
  query = list(locale = locale)
  
  meta_data <- lapply(ts_keys, function(key) {
    
    query$key = key
    
    response <- kofdata_get(url, use_tempfile = use_tempfile, query = query)
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
