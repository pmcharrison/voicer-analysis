eval_mod <- function(mod, dat) {
  pred <- predict(mod, newdata = dat, type = "response")
  eval_pred(dat, pred)
}

eval_pred <- function(dat, pred) {
  dat %>% 
    select(id, seq, pos, chosen) %>% 
    mutate(chosen = as.logical(chosen),
           pred = pred) %>% 
    split_by_chord() %>% 
    map(eval_chord_pred) %>% 
    bind_rows() %>% 
    summarise_chord_preds()
}

split_by_chord <- function(x) {
  split(x, x$id) %>% set_names(NULL)
}

eval_chord_pred <- function(x) {
  id <- unique(x$id)
  stopifnot(length(id) == 1L)
  tibble(
    id = id,
    probability = x %>% filter(chosen) %>% pull(pred),
    info_content = - log2(probability),
    num_options = nrow(x),
    abs_rank = rank(- x$pred)[x$chosen],
    pct_rank = (abs_rank - 0.5) / num_options
  ) %T>% {stopifnot(nrow(.) == 1L)}
}

summarise_chord_preds <- function(x) {
  list(
    by_chord = x,
    summary = x %>% select(- id) %>% summarise_all(mean)
  )
}
