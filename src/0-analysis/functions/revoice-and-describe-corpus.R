revoice_and_describe_corpus <- function(x, n = 1) {
  withr::with_seed(1, {
    plyr::llply(seq_len(n), function(i) {
      flog.info("Revoicing and describing corpus, iteration = %i/%i...",
                i, n)
      x %>% 
        randomly_revoice_corpus(seed = i) %>% 
        describe_corpus(corpus_type = "revoiced",
                        revoice_corpus_id = i) 
    }) %>% bind_rows()
  })
}
