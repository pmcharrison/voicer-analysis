if (FALSE) {
  devtools::install_github("pmcharrison/partykit")
}

library(tidyverse)
library(partykit)
library(futile.logger)

for (f in list.files("src/1-model/functions", full.names = TRUE)) source(f)


dat <- read_csv("output/chord-features.csv")
mod <- fit_tree(dat, max_depth = 3)
plot_tree(mod)




library(naivebayes)

tmp <- dat %>% 
  select(- c(revoice_corpus_id, piece_id)) %>% 
  na.omit() %>% 
  mutate(parallels = recode_factor(as.character(parallels),
                                   `0` = "No",
                                   `1` = "Yes"),
         corpus_type = recode_factor(corpus_type,
                                     revoiced = "Random",
                                     original = "Original"
         ))

n <- glm(corpus_type ~ ., family = binomial(), data = tmp)


m <- naive_bayes(corpus_type ~ ., data = tmp, usekernel = TRUE)
plot(m)

mean(predict(m) == tmp$corpus_type)

###################

library(mclogit)

data(Transport)
summary(mclogit(
  cbind(resp,suburb) ~ poly(distance, 2) + cost,
  data=Transport
))

# install.packages("clogitboost")
