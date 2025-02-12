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

To install the package from GitHub:
```r
# Install devtools if not installed
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")

# Install RpubsEncrypt from GitHub
devtools::install_github("anpyko/RpubsEncrypt")
```

## Usage

Use the `self_contained_encrypt` function to create and encrypt a self-contained HTML file:

```r
library(RpubsEncrypt)

# Encrypt and optionally make self-contained
self_contained_encrypt(
  input_file = "example.html", 
  password = "mypassword", 
  self_contained = TRUE,  # Set to TRUE if you want to embed all resources
  output_file = "example_encrypted.html" # Optional output file path
)
```

### Function Arguments
- `input_file`: Path to the input HTML file.
- `password`: Password for encryption.
- `self_contained`: Convert to self-contained HTML before encrypting (default: FALSE).
- `output_file`: Optional output file path.

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
