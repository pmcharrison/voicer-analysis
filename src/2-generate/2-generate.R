
# Pitch-class chord revoicing (normalised)
x1.5 <- hcorp::bach_chorales_1[[1]] %>%
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>%
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2,
                        max_octave = 1,
                        dbl_change = TRUE,
                        dbl_min = 1,
                        dbl_max = 4,
                        exp_cost = TRUE,
                        norm_cost = TRUE,
                        log_cost = TRUE))

x1.5 %>%
  abcR::html_from_pi_chord_seq(chords_per_line = 10,
                               staff_width = 500) %>%
  abcR::pdf_from_abc_html(pdf_path = "output/ex-probabilistic.pdf")


p2 <- draw(x2)



# Jazz example
x4 <- hcorp::jazz_1[[1]][1:10] %>% 
  hrep::decode() %>% 
  hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
  voice(opt = voice_opt(weights = mod,
                        min_octave = -2, 
                        max_octave = 1,
                        dbl_change = TRUE, 
                        dbl_min = 1, 
                        dbl_max = 4,
                        exponentiate = FALSE,
                        norm_cost = FALSE))
p4 <- draw(x4)

P <- cowplot::plot_grid(p1, p2, p3, p4,
                        ncol = 1,
                        labels = "AUTO",
                        label_size = 20,
                        label_y = 0.5)

ggplot2::ggsave("output/scores.pdf", plot = P, width = 9.5, height = 9)

# Generate full scores for all the chorales in the corpus (slow!)

R.utils::mkdirs("output/all-scores")

if (FALSE) {
  plyr::l_ply(hcorp::bach_chorales_1, function(x) {
    x%>% 
      hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
      voice(opt = voice_opt(weights = mod,
                            min_octave = -2, 
                            max_octave = 1,
                            dbl_change = TRUE, 
                            dbl_min = 1, 
                            dbl_max = 4,
                            verbose = FALSE,
                            exponentiate = FALSE,
                            norm_cost = FALSE)) %>% 
      abcR::html_from_pi_chord_seq(chords_per_line = 10, 
                                   staff_width = 500) %>% 
      abcR::pdf_from_abc_html(
        pdf_path = file.path("output/all-scores",
                             paste0(hrep::metadata(x)$description,
                                    ".pdf")))
  }, .progress = "text")
}
