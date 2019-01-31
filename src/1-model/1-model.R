if (FALSE) {
  devtools::install_github("pmcharrison/partykit")
}

library(tidyverse)
library(partykit)
library(futile.logger)

for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)


dat <- read_csv("output/chord-features.csv")
mod <- fit_tree(dat)
plot_tree(mod)
