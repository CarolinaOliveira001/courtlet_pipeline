library(courtlet)
library(targets)
library(dplyr)
library(ggplot2)
library(tidyverse)
source("functions.R")

list(
  tar_target(court_data, get_data()),
  
  tar_target(
    clean_court_data,
    clean_whole_data(court_data)),
  
  tar_target(
    plot_vote_Roe,
    make_vote_plot(clean_court_data, "Roe v. Wade")
  ),
  
  tar_target(
    plot_vote_save,
    save_plot("home/courtcases/vote.png", plot_vote_Roe),
    format = "file"
  ),
  
  tar_target(
    save_file_Roe,
    save_file(clean_court_data, "Roe v. Wade", "home/courtcases/output.txt"),
    format = "file"
  )
  
)
