#' Get Localized Meta Information
#' 
#' Download metadata given a time series key.
#' @param ts_keys A vector of time series keys.
#' @param locale character ISO-2-digit language of requested metadata. Meta data
#' are for survey related typically available in English, German, French and Italian. 
#' Non survey data are not provided with meta information, yet. 
#' @return A named list of lists containing metadata.
#' @import httr
#' @import jsonlite
#' @examples 
#' get_metadata("ch.kof.inu.run1.ng08.fx.q_ql_ass_bs.balance","en")
#' @export
get_metadata <- function(ts_keys, locale=c("en", "de", "fr", "it")) {
  
  locale <- match.arg(locale)
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata"
  
  query_keys <- paste(ts_keys, collapse = ",")
  
  query <-  list(locale = locale, keys = query_keys)
  
  response <- GET(url, query = query)

  data <- fromJSON(content(response, as="text"))

  data[sapply(data, length) == 0] <- NA

  names(meta_data) <- ts_keys
  
  meta_data
}
