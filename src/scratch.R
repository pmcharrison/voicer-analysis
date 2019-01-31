if (FALSE) {
  devtools::install_github("pmcharrison/partykit")
}

library(tidyverse)
library(hcorp)
library(hrep)
library(incon)
library(minVL)
library(memoise)
library(voicer)
loadNamespace("plyr")
library(futile.logger)
library(partykit)

for (f in list.files("src/functions/", full.names = TRUE)) source(f)

if (FALSE) {
  # Run these lines manually to clear memoised function caches
  forget(describe_corpus)
  forget(randomly_revoice_corpus)
}

corp <- bach_chorales_1[1:3]

dat <- bind_rows(
  describe_original(corp),
  revoice_and_describe_corpus(corp, n = 3)
)

mod <- fit_tree(dat)

plot(mod, ip_args = list(abbreviate = function(x, ...) {
  gsub("__", "-", x) %>% gsub("_", " ", .)
}))
