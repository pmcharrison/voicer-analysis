get_moments <- function(x) {
  tibble(feature = attr(x, "features"),
         mean = map_dbl(feature, ~ mean(x[[.]])),
         sd = map_dbl(feature, ~ sd(x[[.]])))
}
