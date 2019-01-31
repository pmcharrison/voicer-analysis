plot_tree <- function(x) {
  plot(x, ip_args = list(abbreviate = function(x, ...) {
    gsub("__", "-", x) %>% gsub("_", " ", .)
  }))
}
