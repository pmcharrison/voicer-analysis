preprocess <- function(dat, par) {
  dat %>% 
    filter(pos > 1) %>% 
    slice(seq_len(par$downsample)) %>% 
    mutate(
      chosen = as.integer(chosen)
      # dist_from_middle = abs(mean_pitch - !!par$middle),
      # dist_above_top = pmax(0, max_pitch - !!par$top),
      # dist_below_bottom = pmax(0, !!par$bottom - min_pitch)
    )
}
