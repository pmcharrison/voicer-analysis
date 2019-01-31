describe_original <- function(x) {
  flog.info("Describing original corpus...")
  describe_corpus(x, corpus_type = "original")
}

describe_corpus <- function(x, corpus_type, revoice_corpus_id = as.integer(NA)) {
  flog.info("Computing features for corpus...")
  plyr::llply(seq_along(x), function(i) {
    seq_features(x[[i]]) %>% 
      add_column(piece_id = i, .before = 1)
  }, 
  .progress = "text") %>% 
    bind_rows() %>% 
    add_column(corpus_type = corpus_type, .before = 1) %>% 
    add_column(revoice_corpus_id = revoice_corpus_id, .before = 1)
}

R.utils::mkdirs("cache/describe_corpus")
describe_corpus <- memoise(describe_corpus, 
                           cache = cache_filesystem("cache/describe_corpus"))

