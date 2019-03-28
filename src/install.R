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

webshot::install_phantomjs()

install.packages("pdftools")
# This may fail and return some instructions on installing poppler-cpp.
# Follow these instructions and try to install pdftools again.

