library(magrittr)
library(tidyverse)
loadNamespace("voicer")

for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)

par <- get_par()
dat <- readRDS("output/pc-chord-features.rds") %>% dplyr::slice(1:10000)
moments <- get_moments(dat) %T>% write_csv("output/moments.csv")
mod <- voicer::model_features(dat) %T>% saveRDS("output/mod.rds")

if (FALSE) {
  pred_failure <- get_pred_failure(dat, mod_eval, par)
  pred_failure %>% select(- preview_seq) %>% write_csv("output/pred-failure.csv")
}
