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
                        min_notes = 1, 
                        max_notes = 4,
                        exp_cost = FALSE,
                        norm_cost = FALSE,
                        log_cost = FALSE))
plots$pc_chord <- draw(seqs$pc_chord)

# Pitch-class chord revoicing (with melody prespecified)
seqs$pc_chord_fixed_melody <- chor %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        min_notes = 1, 
                        max_notes = 4,
                        exp_cost = FALSE,
                        norm_cost = FALSE,
                        log_cost = FALSE), 
        fix_melody = map_int(chor, max))
plots$pc_chord_fixed_melody <- draw(seqs$pc_chord_fixed_melody)

# Combined plot
cowplot::plot_grid(plotlist = plots,
                   ncol = 1,
                   labels = "AUTO",
                   label_size = 20,
                   label_y = 0.5) %>% 
  ggplot2::ggsave("output/example-chorale.pdf", plot = ., width = 9.5, height = 9)
