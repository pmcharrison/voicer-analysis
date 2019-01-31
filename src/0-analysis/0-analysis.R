library(tidyverse)
library(hcorp)
library(hrep)
library(incon)
library(minVL)
library(memoise)
library(voicer)
loadNamespace("plyr")
library(futile.logger)

for (f in list.files("src/0-analysis/functions", full.names = TRUE)) source(f)

if (FALSE) {
  # Run these lines manually to clear memoised function caches
  forget(describe_corpus)
  forget(randomly_revoice_corpus)
}

corp <- bach_chorales_1[1:3]

dat <- bind_rows(
  describe_original(corp),
  revoice_and_describe_corpus(corp, n = 1)
)

R.utils::mkdirs("output")
write_csv(dat, "output/chord-features.csv")
