#' translate_legacy_keys
#' 
#' Gives ts_keys for the given legacy keys.
#' Since there is no one to one mapping from old to new keys, it is possible that multiple new keys are returned for an old key.
#' Note: Not all possible new keys are returned. The keys returned by this function should serve as a starting point to find the
#' specific new keys that are needed. For the key explorer to find the exact keys, see \code{\link{start_key_explorer}}.
#' @param legacy_keys A vector of legacy keys for which to find new keys
#' @param chunksize integer to set chunksize in order to avoid URLs that are too long. 
#' @return A list of vectors of new ts_keys
#' @import httr
#' @import jsonlite
#' @export
translate_legacy_keys <- function(legacy_keys, chunksize = 100){
  
  url <- "https://datenservice.kof.ethz.ch/api/v1/metadata/translatelegacykeys"
  
  
  chunk_list <- split(legacy_keys,ceiling(seq_along(legacy_keys)/chunksize))
  
  result <- lapply(chunk_list,function(x){
    l_keys <- paste(x, collapse=",")
    response <- GET(url, query = list(keys = l_keys))
    if(response$status_code != 200){
      stop(sprintf("web request not successful, http error %s returned",
                   as.character(response$status_code)))
    }
    result <- fromJSON(content(response, as="text"))
  })
  
  
  out <- unlist(result,recursive = F)
  names(out) <- gsub("[0-9]+\\.","",names(out))
  out
}



