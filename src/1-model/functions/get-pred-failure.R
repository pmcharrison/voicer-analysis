get_pred_failure <- function(dat, mod,
                             n_pred_failure = 10L,
                             preview_window_before = 4L,
                             preview_window_after = 5L) {
  res <- mod$eval$by_chord %>% 
    arrange(probability) %>% 
    slice(seq_len(n_pred_failure)) %>% 
    left_join(dat %>% filter(chosen == 1), by = "id") %>% 
    mutate(
      seq_length = map_int(seq, ~ length(hcorp::bach_chorales_1[[.]])),
      preview_begin = pmax(1L, pos - preview_window_before),
      preview_end = pmin(seq_length, pos + preview_window_after),
      preview_target = pos - preview_begin + 1L,
      preview_seq = pmap(list(seq, preview_begin, preview_end), 
                         ~ hcorp::bach_chorales_1[[..1]][..2:..3])
    )
  unlink("output/pred-failure", recursive = TRUE)
  pmap(res %>% 
         select(seq, pos, preview_begin, preview_end,
                preview_target, preview_seq) %>% 
         mutate(i = seq_len(n())),
       save_preview, n_pred_failure)
  res
}

save_preview <- function(seq, pos, preview_begin, preview_end,
                         preview_target, preview_seq, i, n_pred_failure) {
  message("Saving prediction failure ", i, " out of ", n_pred_failure, "...")
  dir <- "output/pred-failure"
  R.utils::mkdirs(dir)
  file <- "ex-{i}_seq-{seq}_begin-{preview_begin}_end-{preview_end}.pdf" %>% 
    glue() %>% file.path(dir, .)
  annotate <- rep(".", times = length(preview_seq))
  annotate[preview_target] <- "!"
  preview_seq %>% 
    abcR::html_from_pi_chord_seq(annotate = annotate) %>% 
    abcR::pdf_from_abc_html(file)
}
