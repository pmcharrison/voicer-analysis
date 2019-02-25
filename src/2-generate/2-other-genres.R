for (f in list.files("src/2-generate/functions", full.names = TRUE)) source(f)

seqs <- list()

seqs$jazz_heuristic <- hcorp::jazz_1[[1]][1:10] %>% hrep::decode() %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  hrep::transform_symbols(hrep::pi_chord, "pi_chord")

seqs$jazz_voiced <- seqs$jazz_heuristic %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        min_notes = 1, 
                        max_notes = 4))

seqs$popular_heuristic <- hcorp::popular_1[[2]][1:10] %>% 
  hrep::decode() %>% 
  hrep::transform_symbols(hrep::pi_chord, "pi_chord")

seqs$popular_voiced <- seqs$popular_heuristic %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        min_notes = 1, 
                        max_notes = 4))

plots <- purrr::map(seqs, draw, staff_width = 650)

cowplot::plot_grid(plotlist = plots,
                   ncol = 1,
                   labels = "AUTO",
                   label_size = 20,
                   label_y = 0.5) %>% 
  ggplot2::ggsave("output/other-genres.pdf", plot = ., width = 12, height = 9)
