str_wrap_html <- function(string, width = 80, indent = 0, exdent = 0, whitespace_only = TRUE) {
  stringr:::check_number_decimal(width)
  if (width <= 0) {
    width <- 1
  }
  stringr:::check_number_whole(indent)
  stringr:::check_number_whole(exdent)
  stringr:::check_bool(whitespace_only)
  
  out <- stringi::stri_wrap(string, width = width, indent = indent, exdent = exdent,
                            whitespace_only = whitespace_only, simplify = FALSE)
  vapply(out, str_c, collapse = "<br>", character(1))
}
