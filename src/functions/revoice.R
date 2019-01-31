R.utils::mkdirs("cache/randomly_revoice_corpus")
randomly_revoice_corpus <- function(corpus, seed) {
  flog.info("Randomly revoicing corpus...")
  withr::with_seed(seed, {
    plyr::llply(corpus, randomly_revoice_seq, .progress = "text")
  })
}
randomly_revoice_corpus <- memoise(
  randomly_revoice_corpus, 
  cache = cache_filesystem("cache/randomly_revoice_corpus"))

randomly_revoice_seq <- function(seq) {
  map(seq, randomly_revoice_chord)
}

randomly_revoice_chord <- function(x) {
  all <- all_voicings_pc_set(
    pc_set(x),
    min_octave = -2, max_octave = 1, 
    dbl_change = TRUE, dbl_min = 3, dbl_max = 4
  )
  sample(all)[[1]]
}
