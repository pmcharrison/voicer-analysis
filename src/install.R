# Run this script once to install all required packages

install.packages(c(
  "tidyverse",
  "R.utils",
  "devtools",
  "cowplot",
  "magick",
  "plyr"
))

devtools::install_github(paste(
  "pmcharrison", 
  c(
    "hcorp",
    "hrep",
    "voicer",
    "abcR"
  ),
  sep = "/"))
