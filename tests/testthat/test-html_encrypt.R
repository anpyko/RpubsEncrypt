library(testthat)

test_that("self_contained_encrypt() creates encrypted file", {
  temp_input <- tempfile(fileext = ".html")
  writeLines("<html><head></head><body><p>Test</p></body></html>", temp_input)
  
  temp_output <- self_contained_encrypt(temp_input, password = "test123", self_contained = TRUE)
  
  expect_true(file.exists(temp_output))
  expect_match(temp_output, "_encrypted.html$")
})

test_that("self_contained_encrypt() fails with missing file", {
  expect_error(self_contained_encrypt("missing.html", password = "test123"))
})

test_that("self_contained_encrypt() handles missing dependencies", {
  withr::with_envvar(c("R_LIBS_USER" = tempfile()), {
    expect_error(self_contained_encrypt("test.html", password = "test123"))
  })
})

