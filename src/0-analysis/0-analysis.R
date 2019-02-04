library(magrittr)
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
  # Run this manually to clear memoised function cache
  forget(analyse_seq)
}

df <- analyse_corpus(hcorp::bach_chorales_1)

R.utils::mkdirs("output")
saveRDS(df, "output/chord-features.rds")
