avg_roughness <- function(x) {
  stopifnot(is(x, "vec"))
  mean(map_dbl(x, incon, model = "hutch_78_roughness"))
}
R.utils::mkdirs("cache/avg_roughness")
avg_roughness <- memoise(avg_roughness, cache = cache_filesystem("cache/avg_roughness"))

avg_vl_dist <- function(x) {
  stopifnot(is(x, "vec"))
  n <- length(x)
  if (n < 2) {
    as.numeric(NA)
  } else {
    mean(map2_dbl(x[- n], x[- 1], min_vl_dist, elt_type = "pitch"))
  }
}
R.utils::mkdirs("cache/avg_vl_dist")
avg_vl_dist <- memoise(avg_vl_dist, cache = cache_filesystem("cache/avg_vl_dist"))
