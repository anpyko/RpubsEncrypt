#' Create a Self-Contained HTML and Encrypt it
#'
#' @param input_file Path to the input HTML file.
#' @param password Password for encryption.
#' @param self_contained Convert to self-contained HTML before encrypting (default: FALSE).
#' @param output_file Optional output file path.
#'
#' @return Path to the encrypted HTML file.
#' @export
self_contained_encrypt <- function(input_file=NULL, password=NULL, self_contained = FALSE, output_file = NULL) {
  if (!requireNamespace("xml2", quietly = TRUE) || 
      !requireNamespace("base64enc", quietly = TRUE) ||
      !requireNamespace("htmltools", quietly = TRUE) || 
      !requireNamespace("pagecryptr", quietly = TRUE)) {
    stop("Required packages missing. Install them with install.packages().")
  }

   if (is.null(input_file)) {
    input_file <- system.file("extdata", "example.html", package = "RpubsEncrypt")
  }

  if (!file.exists(input_file)) stop("Error: Input file does not exist.")

  if (self_contained) {
    message("Converting to self-contained HTML...")
    html_doc <- xml2::read_html(input_file, encoding = "UTF-8")

    asset_types <- list(
      list(tag = "//link[@rel='stylesheet']", attr = "href", mime = "text/css"),
      list(tag = "//script[@src]", attr = "src", mime = "text/javascript"),
      list(tag = "//img[@src]", attr = "src", mime = "image/png")
    )

    for (asset in asset_types) {
      nodes <- xml2::xml_find_all(html_doc, asset$tag)
      sapply(nodes, function(node) {
        file_path <- xml2::xml_attr(node, asset$attr)
        encoded <- encode_file_to_base64(file_path, asset$mime)
        if (!is.null(encoded)) xml2::xml_set_attr(node, asset$attr, encoded)
      })
    }

    output_file <- ifelse(is.null(output_file), gsub("\\.html$", "_self_contained.html", input_file), output_file)
    xml2::write_html(html_doc, output_file)
    input_file <- output_file
  }

message("Encrypting the file...")
encrypted_file <- gsub("\\.html$", "_encrypted.html", input_file)
pagecryptr::pagecryptr(input_file, password, out_file = encrypted_file, encoding = "UTF-8")

if (!file.exists(encrypted_file)) stop("Error: Encrypted file not created!")

# Copy encrypted file to temporary directory
temp_file <- file.path(tempdir(), basename(encrypted_file))
file.copy(encrypted_file, temp_file, overwrite = TRUE)

viewer <- getOption("viewer")
if (!is.null(viewer)) {
  message("Opening in RStudio Viewer...")
  viewer(temp_file)
} else {
  browseURL(temp_file)
}

return(temp_file)
}