library(magrittr)
library(tidyverse)
loadNamespace("voicer")

for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)

dat <- readRDS("output/pc-chord-features.rds") # %>% dplyr::filter(id <= 5000)
moments <- get_moments(dat) %T>% write_csv("output/moments.csv")
mod <- voicer::model_features(dat, keep_model = FALSE)
mod$eval$by_chord <- NULL
saveRDS(mod, "output/mod.rds")

if (FALSE) {
  pred_failure <- get_pred_failure(dat, mod)
  pred_failure %>% select(- preview_seq) %>% write_csv("output/pred-failure.csv")
}
