library(magrittr)
library(tidyverse)
library(mclogit)
library(glue)
for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)

par <- get_par()
dat <- readRDS("output/chord-features.rds") %>% preprocess(par)
moments <- get_moments(dat, par) %T>% write_csv("output/moments.csv")
mod <- fit_model(dat, par) %>% save_mod("output/mod.csv")
mod_eval <- eval_mod(mod, dat) %T>% {write_csv(.$summary, "output/mod-eval.csv")}

perm_int <- get_perm_int(dat, par, mod_eval, mod) %T>% 
  write_csv("output/perm-int.csv")

pred_failure <- get_pred_failure(dat, mod_eval, par)
pred_failure %>% select(- preview_seq) %>% write_csv("output/pred-failure.csv")
