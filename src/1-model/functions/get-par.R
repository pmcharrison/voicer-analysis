get_par <- function(downsample = 500000,
                    # top = 72L,
                    # middle = 60L,
                    # bottom = 48L,
                    features = c("any_parallels",
                                 "change_num_notes",
                                 "diff_num_notes",
                                 "dist_above_top",
                                 "dist_below_bottom",
                                 "dist_from_middle",
                                 "exposed_outer_octaves",
                                 "hutch_78",
                                 "melody_dist",
                                 "outer_parallels",
                                 "part_overlap",
                                 "vl_dist"),
                    n_pred_failure = 10L,
                    preview_window_before = 4L,
                    preview_window_after = 5L) {
  formula <- glue("cbind(chosen, id) ~ {paste(features, collapse = '+')}") %>% 
    as.formula
  as.list(environment())
}
