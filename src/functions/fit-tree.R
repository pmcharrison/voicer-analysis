fit_tree <- function(x) {
  df <- x %>% 
    select(- c(revoice_corpus_id, piece_id)) %>% 
    na.omit() %>% 
    mutate(parallels = recode_factor(as.character(parallels),
                                     `0` = "No",
                                     `1` = "Yes"),
           corpus_type = recode_factor(corpus_type,
                                       revoiced = "Random",
                                       original = "Original"
           )) %>% 
    rename(`Spectral_interference` = "hutch_78",
           `Voice__leading_distance` = "vl_dist",
           `Mean_pitch` = "mean_pitch",
           `Max._pitch` = "max_pitch",
           `Min._pitch` = "min_pitch",
           `Melody_distance` = "melody_dist",
           `Parallels` = "parallels"
    )
  ctree(corpus_type ~ ., data = df)
}
