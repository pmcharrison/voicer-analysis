# Not sure we need this code

describe_original_bach <- function() {
  describe_dataset(bach_chorales_1)
}

describe_dataset <- function(x) {
  plyr::llply(seq_along(x), 
              function(i) tibble(piece_id = i,
                                 label = metadata(x[[i]])$description,
                                 roughness = avg_roughness(x[[i]]),
                                 vl_dist = avg_vl_dist(x[[i]])),
              .progress = "text") %>% 
    bind_rows()
}
