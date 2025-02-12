# Encrypted HTML Viewer with `pagecryptr`

## Overview

This script encrypts an HTML file using the `pagecryptr` R package, incorporating all CSS, images, and content into a **single self-contained file**. The encrypted file is then displayed in the RStudio Viewer or a web browser. By default, the encrypted file is saved in the same directory as the original file. After viewing, the encrypted file can be uploaded to RPubs using standard RStudio tools.

## Features

- **Encrypts an HTML file** while embedding all necessary assets (CSS, images, JavaScript).
- **Generates a self-contained HTML file** with all resources embedded.
- **Saves the encrypted file in the same folder** as the original by default.
- **Automatically opens the encrypted file** in the RStudio Viewer (if available) or a web browser.
- **Option to upload the encrypted file to RPubs** using RStudio's built-in tools.

## Installation

Ensure you have the `pagecryptr` package installed. If not, install it using:

```r
install.packages("pagecryptr")
```

## Usage

Use the script below to encrypt an HTML file and open it:

```r
encrypt_and_view <- function(input_file, password) {
  message("Encrypting the file...")
  
  # Define output file name
  encrypted_file <- gsub("\\.html$", "_encrypted.html", input_file)
  
  # Encrypt the HTML file
  pagecryptr::pagecryptr(input_file, password, out_file = encrypted_file, encoding = "UTF-8")
  
  # Check if the encrypted file was created
  if (!file.exists(encrypted_file)) stop("Error: Encrypted file not created!")
  
  # Copy encrypted file to a temporary directory
  temp_file <- file.path(tempdir(), basename(encrypted_file))
  file.copy(encrypted_file, temp_file, overwrite = TRUE)
  
  # Open in RStudio Viewer or browser
  viewer <- getOption("viewer")
  if (!is.null(viewer)) {
    message("Opening in RStudio Viewer...")
    viewer(temp_file)
  } else {
    browseURL(temp_file)
  }
  
  return(temp_file)
}

# Example usage
encrypt_and_view("example.html", "mypassword")
```

## Uploading to RPubs

Once the encrypted file is created, you can **upload it to RPubs** using RStudio:

1. Open the encrypted file in RStudio's Viewer.
2. Click **Publish** in the Viewer.
3. Choose **RPubs** as the publishing destination.
4. Follow the instructions to complete the upload.

This allows secure sharing of encrypted HTML content.

## Notes

- The encrypted file remains self-contained, meaning no external dependencies are required to view it.
- The encryption adds a password layer, ensuring only authorized viewers can access the content.
- The temporary file approach ensures a clean workflow without modifying the original directory.

---

This script is ideal for **secure HTML sharing** and **publishing encrypted reports** with embedded CSS, images, and scripts.
