for (f in list.files("src/2-generate/functions", full.names = TRUE)) source(f)

chor <- hcorp::bach_chorales_1[[1]][1:10]
seqs <- list()
plots <- list()

# Original chorale
plots$original <- draw(chor)

# Heuristic voicing
plots$heuristic <- chor %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  hrep::transform_symbols(hrep::pi_chord, "pi_chord") %>% 
  draw()

# Pitch-class chord revoicing (unnormalised)
seqs$pc_chord <- chor %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        dbl_min = 1, 
                        dbl_max = 4,
                        exp_cost = FALSE,
                        norm_cost = FALSE,
                        log_cost = FALSE))
plots$pc_chord <- draw(seqs$pc_chord)

# Pitch-class set revoicing
seqs$pc_set <- chor %>% 
  hrep::transform_symbols(hrep::pc_set, "pc_set") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        dbl_min = 1, 
                        dbl_max = 4,
                        exp_cost = FALSE,
                        norm_cost = FALSE,
                        log_cost = FALSE))
plots$pc_set <- draw(seqs$pc_set)

# Combined plot
cowplot::plot_grid(plotlist = plots,
                   ncol = 1,
                   labels = "AUTO",
                   label_size = 20,
                   label_y = 0.5) %>% 
  ggplot2::ggsave("output/example-chorale.pdf", plot = ., width = 9.5, height = 9)