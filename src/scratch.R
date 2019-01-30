library(tidyverse)
library(hcorp)
library(hrep)
library(incon)
library(minVL)
library(memoise)
library(voicer)
loadNamespace("plyr")

# For each piece of original Bach, 
# what percentile does it fall in with respect to all possible voicings?

for (f in list.files("src/functions/", full.names = TRUE)) source(f)

random_voicing_distribution <- function(seq, n = 10) {
  
}

randomly_revoice_seq <- function(seq) {
  map(seq, randomly_revoice_chord)
  
  map(seq, pc_set) %>% 
    map(all_voicings_pc_set,
        min_octave = -2, max_octave = 1, 
        dbl_change = TRUE, dbl_min = 3, dbl_max = 4) %>% 
    sample(1)
}

randomly_revoice_chord <- function(x) {
  stopifnot(length(x) == 4)
  all <- all_voicings_pc_set(
    pc_set(x),
    min_octave = -2, max_octave = 1, 
    dbl_change = TRUE, dbl_min = 3, dbl_max = 4
  )
  sample(all)[[1]]
}

describe_dataset(bach_chorales_1[1:5])

avg_roughness(x)
