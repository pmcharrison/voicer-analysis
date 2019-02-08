library(tidyverse)
library(hcorp)
library(hrep)
library(voicer)

# for (f in list.files("src/0-analysis/functions", full.names = TRUE)) source(f)

get_corpus_features <- function(x, revoice_from) {
  voicer::get_corpus_features(x, 
                              revoice_from = revoice_from,
                              min_octave = -2,
                              max_octave = 1,
                              dbl_change = TRUE,
                              dbl_min = 3,
                              dbl_max = 4)
}

R.utils::mkdirs("output")

corpus <- hcorp::bach_chorales_1

pc_chord_features <- get_corpus_features(corpus, revoice_from = "pc_chord")
saveRDS(pc_chord_features, "output/pc-chord-features.rds")

pc_set_features <- get_corpus_features(corpus, revoice_from = "pc_set")
saveRDS(pc_set_features, "output/pc-set-features.rds")
