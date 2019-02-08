get_par <- function(downsample = 500000,
                    # top = 72L,
                    # middle = 60L,
                    # bottom = 48L,
                    features = c("hutch_78", "vl_dist", "melody_dist",
                                 "parallels", 
                                 "dist_from_middle",
                                 "dist_above_top",
                                 "dist_below_bottom"),
                    n_pred_failure = 10L,
                    preview_window_before = 4L,
                    preview_window_after = 5L) {
  formula <- glue("cbind(chosen, id) ~ {paste(features, collapse = '+')}") %>% 
    as.formula
  as.list(environment())
}
