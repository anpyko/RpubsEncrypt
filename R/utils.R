# Helper functions for RpubsEncrypt

encode_file_to_base64 <- function(file, mime_type) {
  if (!file.exists(file)) return(NULL)
  paste0("data:", mime_type, ";base64,", base64enc::base64encode(file))
}

