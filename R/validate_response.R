validate_response <- function(response) {
  if(status_code(response) != 200) {
    ctd <- content(response)
    if(is.list(ctd)) {
      # Customer specific API not found
      if(grepl("no API found", ctd$message)) {
        stop("Username not found! This service is only available to customers who ordered individual exports. If you ordered such a service, please make sure the username is spelled correctly.")
      }
      # Invalid api key provided
      else if(grepl("Invalid authentication", ctd$message)) {
        stop("Invalid API key!")
      }
    } else {
      stop("An unknown API error ocurred.")
    }
  }

  invisible(response)
}
