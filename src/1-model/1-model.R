library(tidyverse)
library(mclogit)
library(glue)
for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)

# Unstandardised regression weights - relate to the actual scales of the features
# Permutation feature importance (cross-entropy metric)

par <- get_par()
dat <- readRDS("output/chord-features.rds") %>% preprocess(par)
moments <- get_moments(dat, par)
mod <- fit_model(dat, par) %>% save_mod("output/mod.csv")
mod_eval <- eval_mod(mod, dat)

# xval <- fit_xval_models(dat, par)
