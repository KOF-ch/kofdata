kofdata_get <- function(url, show_progress = FALSE, use_tempfile = FALSE, ...) {
  if(show_progress) {
    set_config(progress())
  }
  if(use_tempfile) {
    write_disk(tempfile())
  }
  on.exit(reset_config())
  
  GET(url, ...)
}