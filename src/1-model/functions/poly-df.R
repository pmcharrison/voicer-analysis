poly_df <- function(df, cols, degree) {
  map(cols, function(col) {
    poly(df[[col]], degree = 2) %>% 
      as.data.frame %>% 
      set_names(paste(col, "poly", seq_len(degree), sep = "_")) %>% 
      as_tibble
  }) %>% bind_cols() %>% bind_cols(select(df, - cols),
                                   .)
  
}
