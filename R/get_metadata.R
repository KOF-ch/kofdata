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
#' get_metadata("kofbarometer","en")
#' @export
get_metadata <- function(ts_keys, locale=c("en", "de", "fr", "it")) {

  locale <- match.arg(locale)

  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata"

  query = list(locale = locale)

  meta_data <- lapply(ts_keys, function(key) {

    query$key = key

    response <- GET(url, query = query)
    data <- fromJSON(content(response, as="text"))
    data[data == "NA"] <- NA

    if(!is.null(data$info)) {
      NA
    } else {
      data[[key]]
    }
  })

  # Set empty lists to NA
  meta_data[sapply(meta_data, length) == 0] <- NA

  names(meta_data) <- ts_keys

  meta_data
}
