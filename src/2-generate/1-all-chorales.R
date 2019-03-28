for (f in list.files("src/2-generate/functions", full.names = TRUE)) source(f)

plyr::l_ply(hcorp::bach_chorales_1, function(x) {
  x%>% 
    hrep::transform_symbols(hrep::pc_chord, "pc_chord") %>% 
    voice(opt = voice_opt(weights = mod,
                          min_octave = -2, 
                          max_octave = 1,
                          dbl_change = TRUE, 
                          min_notes = 1, 
                          max_notes = 4,
                          verbose = FALSE,
                          exp_cost = FALSE,
                          norm_cost = FALSE, 
                          log_cost = FALSE)) %>% 
    abcR::html_from_pi_chord_seq(chords_per_line = 10, 
                                 staff_width = 500) %>% 
    abcR::pdf_from_abc_html(
      pdf_path = file.path("output/all-scores",
                           paste0(hrep::metadata(x)$description,
                                  ".pdf")))
}, .progress = "text")
