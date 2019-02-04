fit_model <- function(x, par) {
  mod <- mclogit(par$formula, data = x)
}
