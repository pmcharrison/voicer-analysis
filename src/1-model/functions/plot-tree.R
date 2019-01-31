plot_tree <- function(x) {
  pdf("output/tree.pdf", width = 14, height = 6)
  plot(x, 
       ip_args = list(abbreviate = abbrev,
                      id = FALSE, 
                      bordercol = "white"),
       tp_args = list(fill = c("#0061ff", "white"),
                      id = FALSE, 
                      text = "none", 
                      ylabels = FALSE))
  dev.off()
}

abbrev <- function(x, ...) {
  gsub("__", "-", x) %>% gsub("_", " ", .)
}
