library(tidyverse)
library(hcorp)
library(hrep)
library(incon)
library(minVL)
library(memoise)
library(voicer)
loadNamespace("plyr")
library(futile.logger)

for (f in list.files("src/functions/", full.names = TRUE)) source(f)

if (FALSE) {
  forget(describe_corpus)
  forget(randomly_revoice_corpus)
}

corp <- bach_chorales_1[1:3]

if (FALSE) {
  df <- bind_rows(
    describe_original(corp),
    revoice_and_describe_corpus(corp, n = 3)
  )
}



