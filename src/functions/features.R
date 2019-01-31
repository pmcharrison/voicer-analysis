seq_single_feature <- function(f, x, ...) {
  map_dbl(x, f, ...)
}

seq_pair_feature <- function(f, x, ...) {
  n <- length(x)
  if (n == 0) {
    numeric()
  } else if (n == 1) {
    as.numeric(NA) 
  } else {
    c(NA, map2_dbl(x[- n], x[- 1], f, ...))
  }
}

seq_features <- function(x) {
  c(map(F_SINGLE, seq_single_feature, x),
    map(F_PAIR, seq_pair_feature, x)) %>% 
    as_tibble()
}

F_SINGLE <- list(
  roughness = function(x) incon(x, model = "hutch_78_roughness"),
  mean_pitch = mean,
  max_pitch = max,
  min_pitch = min
)

F_PAIR <- list(
  vl_dist = function(a, b) min_vl_dist(a, b, elt_type = "pitch"),
  melody_dist = voicer::melody_dist,
  parallels = voicer::parallels
)
