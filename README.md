# voicer-analysis

This repository provides source code for the analyses reported 
in Harrison & Pearce (2019), 
"A Computational Model for the Analysis and Generation of Chord Voicings".

## Directories

`cache` - temporary files produced during analysis scripts.

`output` - output files produced by analysis scripts.

`src` - source code.

## Instructions

This project is written for the programming language R,
which you must install first. 
We recommend additionally installing and using R Studio.
You should then open `voicer-analysis.Rproj` in R Studio
to set your working directory appropriately.

To install required packages, run `src/install.R`.
You will need an internet connection.

The different steps of the analysis pathway are provided in
the folders `src/0-analysis`, `src/1-model`, and `src/2-generate`.
These must be run in order, as each step uses results from the previous step.

`src/0-analysis/0-analysis.R` 
computes chord feautures for the Bach chorale dataset.

`src/1-model/1-model.R` 
fits a statistical model to the Bach chorale dataset.

`src/2-generate/0-example-chorale.R` 
generates voicings for an example Bach chorale extract.

`src/2-generate/1-all-chorales.R` 
generates voicings for all Bach chorales in the dataset.

`src/2-generate/2-other-genres.R` 
generates voicings for example extracts from other musical genres.
