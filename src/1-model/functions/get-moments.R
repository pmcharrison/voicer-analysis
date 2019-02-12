get_moments <- function(x) {
  df <- dplyr::filter(x, chosen)
  tibble(feature = attr(df, "features"),
         mean = map_dbl(feature, ~ mean(df[[.]], na.rm = TRUE)),
         sd = map_dbl(feature, ~ sd(df[[.]], na.rm = TRUE)))
}
