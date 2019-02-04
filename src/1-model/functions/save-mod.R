save_mod <- function(x, file) {
  df <- summary(x)$coefficients
  features <- rownames(df)
  df %>% as_tibble() %>% add_column(feature = features, .before = 1) %>% 
    rename(
      estimate = "Estimate",
      std_err = "Std. Error",
      z = "z value",
      p = "Pr(>|z|)"
    ) %>% 
    write_csv(file)
  x
}
