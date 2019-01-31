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
  # Run these lines manually to clear memoised function caches
  forget(analyse_seq)
}

corp <- bach_chorales_1
# corp <- list(
#   bach_chorales_1[[1]][1:3],
#   bach_chorales_1[[2]][1:3]
# )

df <- analyse_corpus(corp)

R.utils::mkdirs("output")
write_csv(df, "output/chord-features.rds")

if (FALSE) {
  library(mclogit)
  m <- mclogit(
    cbind(chosen, id) ~ hutch_78 + mean_pitch + min_pitch + vl_dist + melody_dist + parallels,
    data = df %>% filter(pos > 1) %>%  mutate(chosen = as.integer(chosen))
  )
}
