library(magrittr)
library(tidyverse)
library(hrep)
library(voicer)

mod <- readRDS("output/mod.rds")
R.utils::mkdirs("output")

draw <- function(x, chords_per_line = 10, staff_width = 500, height = 0.9) {
  file <- tempfile(fileext = ".pdf")
  x %>% 
    abcR::html_from_pi_chord_seq(chords_per_line = chords_per_line, 
                                 staff_width = staff_width) %>% 
    abcR::pdf_from_abc_html(file)
  y <- magick::image_read_pdf(file)
  cowplot::ggdraw() + 
    cowplot::draw_image(y, height = height)
}
