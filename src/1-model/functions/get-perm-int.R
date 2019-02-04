get_perm_int <- function(dat, par, mod_eval, mod) {
  plyr::llply(par$features, feature_perm_int, dat, par, mod_eval, mod,
              .progress = "text") %>% 
    bind_rows()
}

feature_perm_int <- function(feature, dat, par, mod_eval, mod) {
  dat[[feature]] <- sample(dat[[feature]], size = nrow(dat), replace = FALSE)
  eval_mod(mod, dat) %>% 
    {.$summary} %>% 
    {mod_eval$summary - .} %>% 
    add_column(feature = feature, .before = 1) %>% 
    select(- num_options) %>% 
    as_tibble()
}
