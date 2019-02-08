check_pred <- function(coef_file, dat, mod, par) {
  coef <- read_csv(coef_file, col_types = cols())
  df <- dat %>% filter(id <= 100)
  
  # Check the linear predictor
  df <- mutate(
    df,
    linear_pred = as.numeric(as.matrix(df[, par$features]) %*%
                               as.matrix(coef[, "estimate"])))
  expect_equal(df$linear_pred, 
               mod$linear.predictors[seq_along(df$linear_pred)])
  
  # Check predicted probabilities
  df$exp_linear_pred <- exp(df$linear_pred)
  partition <- df %>% 
    group_by(id) %>% 
    summarise(partition = sum(exp_linear_pred)) %>% 
    ungroup()
  df <- left_join(df, partition, by = "id")
  df$p <- df$exp_linear_pred / df$partition
  expect_equal(df$p, predict(mod, newdata = df, type = "response"))

  TRUE
}
