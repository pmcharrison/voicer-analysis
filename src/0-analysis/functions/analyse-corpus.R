analyse_seq <- function(x) {
  alt <- map(x, all_chord_revoicings)
  plyr::llply(seq_along(x), function(i) {
    analyse_chord_revoicings(voicings = alt[[i]],
                             chosen_voicing = x[[i]], 
                             prev_chord_voicing = if (i == 1) NULL else x[[i - 1]]) %>% 
      add_column(pos = i, .before = 1)
  }, .progress = "text") %>% 
    bind_rows()
}
R.utils::mkdirs("cache/analyse_seq")
analyse_seq <- memoise(analyse_seq, cache = cache_filesystem("cache/analyse_seq"))

all_chord_revoicings <- function(x) {
  all_voicings_pc_set(
    pc_set(x),
    min_octave = -2, 
    max_octave = 1, 
    dbl_change = TRUE, 
    dbl_min = 3, 
    dbl_max = 4
  )
}

analyse_corpus <- function(x) {
  map(seq_along(x), function(i) {
    flog.info("Processing sequence %i/%i...", i, length(x))
    analyse_seq(x[[i]]) %>% add_column(seq = i, .before = 1)
  }) %>% 
    bind_rows() %>% 
    add_column(id = NA, .before = 1) %>% 
    mutate(id = paste(seq, pos, sep = "-"),
           id = factor(id, levels = unique(id), ordered = TRUE),
           id = as.integer(id))
}

test_corpus_analysis <- function(df, corp) {
  stopifnot(all(diff(df$id) >= 0))
  df %>% filter(id == 1) %>% pull(chosen_voicing) %>% {.[[1]]} %>% expect_equal(corp[[1]][[1]])
  df %>% filter(id == 2) %>% pull(chosen_voicing) %>% {.[[1]]} %>% expect_equal(corp[[1]][[2]])
  df %>% filter(id == 2) %>% pull(prev_voicing) %>% {.[[1]]} %>% expect_equal(corp[[1]][[1]])
  df %>% filter(id == 2 & chosen) %>% pull(voicing) %>% {.[[1]]} %>% expect_equal(corp[[1]][[2]])
  df %>% filter(id == length(corp[[1]]) + 1) %>% pull(chosen_voicing) %>% {.[[1]]} %>%
    expect_equal(corp[[2]][[1]])
  df
}

analyse_chord_revoicings <- function(voicings, chosen_voicing, prev_chord_voicing) {
  map(voicings, analyse_chord_revoicing, chosen_voicing, prev_chord_voicing) %>% 
    bind_rows()
}

analyse_chord_revoicing <- function(voicing, chosen_voicing, prev_chord_voicing) {
  res_single <- map(F_SINGLE, ~ .(voicing))
  res_pair <- if (!is.null(prev_chord_voicing)) 
    map(F_PAIR, ~ .(prev_chord_voicing, voicing)) else
      rep(as.numeric(NA), times = length(F_PAIR)) %>% set_names(names(F_PAIR))
  c(res_single, 
    res_pair) %>% 
    as_tibble() %>% 
    # add_column(voicing = list(voicing), .before = 1) %>% 
    # add_column(prev_voicing = list(prev_chord_voicing), .before = 1) %>% 
    # add_column(chosen_voicing = list(chosen_voicing), .before = 1) %>% 
    add_column(chosen = identical(as.integer(voicing), as.integer(chosen_voicing)),
               .before = 1)
}
