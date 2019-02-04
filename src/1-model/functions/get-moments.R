get_moments <- function(x, par) {
  tibble(feature = par$features,
         mean = map_dbl(feature, ~ mean(x[[.]])),
         sd = map_dbl(feature, ~ sd(x[[.]])))
}
