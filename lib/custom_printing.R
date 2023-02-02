# Circular Image
print_circle_image <- function(.path, .bw = TRUE) {
  img_raw <- magick::image_read(.path)
  if (rlang::is_true(.bw)) {
    img_raw <- magick::image_quantize(img_raw, colorspace = "gray")
  }
  img_info <- magick::image_info(img_raw)
  img_min <- min(img_info$width, img_info$height)
  img_crop <- magick::image_crop(
    image = img_raw,
    geometry = glue::glue("{img_min}x{img_min}+0+0"),
    repage = TRUE
  )

  fig <- magick::image_draw(magick::image_blank(img_min, img_min))
  symbols(
    x = img_min / 2,
    y = img_min / 2,
    circles = (img_min / 2) - 3,
    bg = "#000000",
    inches = FALSE,
    add = TRUE
  )

  # create an image composite using both images
  img_crop_round <- magick::image_composite(image = img_crop, composite_image = fig, operator = "copyopacity")

  # set background as white
  img_fin <- magick::image_background(img_crop_round, "#F7F7F7")
  return(img_fin)
}

# Install all necessary icons:
install_icon <- function(icon) {
  funs <- rlang::as_function(icon)
  is_installed <- icons::icon_installed(funs)
  if (rlang::is_false(is_installed)) {
    glue::glue("download_{icon}") %>%
      rlang::as_function() %>%
      rlang::exec()
  } else {
    return(invisible(is_installed))
  }
}

# Print skill bars:
print_skill_bars <- function(data, out_of = 5,
                             bar_color = "#009FB7",
                             bar_background = "#d9d9d9",
                             glue_template = "default") {
  if (glue_template == "default") {
    glue_template <- "
<div
  class = 'skill-bar'
  style = \"background:linear-gradient(to right,
                                      {bar_color} {width_percent}%,
                                      {bar_background} {width_percent}% 100%);
  color:#FFFFFF\"
  font-weight: bold>{skill}</div>"
  }
  data %>%
    dplyr::mutate(width_percent = round(100 * as.numeric(level) / out_of)) %>%
    glue::glue_data(glue_template) %>%
    print()

  invisible(data)
}
