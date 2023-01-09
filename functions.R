get_data <- function(){
  courtlet::court_data
}

clean_whole_data <- function(data) {
  df <- data.frame(index = 1:length(data[[1]]))
  
  for (col in c(names(data))){
    clean_col <- courtlet::clean_text(data, col)
    colnames(clean_col) <- col
    df <- cbind(df, clean_col)
  }
  
  data <- df[,!(names(df) %in% c("index"))]
  rm(list = c("df", "clean_col", "col"))
  
  data
}

make_vote_plot <- function(data, court_case_name){
  data %>% 
    filter(name == court_case_name) %>% 
    select(name, majority_vote, minority_vote) %>% 
    pivot_longer(!name, names_to = "vote", values_to = "count") %>% 
    ggplot(aes(x = as.factor(vote), y = count, fill = vote)) +
    geom_bar(stat = 'identity', position = "dodge") +
    scale_x_discrete(labels = c("majority vote", "minority vote")) +
    scale_fill_hue(c = 40) +
    labs(title = paste("Vote count for", court_case_name)) +
    theme(plot.title = element_text(hjust = 0.5),
          axis.title.x = element_blank(),
          legend.position="none")
}

save_plot <- function(save_path, plot){
  ggsave(save_path, plot)
  save_path
}

save_file <- function(data, nameCase, path){
  small_data <- data %>% 
    dplyr::filter(name == nameCase)
  
  winner <- toString(small_data$first_party_winner)
  if (winner == "TRUE"){
    winner_name <- toString(small_data$first_party)
  } else {
    winner_name <- toString(small_data$second_party)
  }
  
  file.create(path)
  cat("Supreme court cases in USA\n\n",file=path, append=TRUE)
  cat("Parties involved: \n",file=path,append=TRUE)
  cat(paste(small_data$first_party, "v.", small_data$second_party),file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Question: \n",file=path,append=TRUE)
  cat(small_data$question,file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Facts: \n",file=path,append=TRUE)
  cat(small_data$facts,file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Conclusion: \n",file=path,append=TRUE)
  cat(small_data$conclusion,file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Winning party: \n",file=path,append=TRUE)
  cat(winner_name,file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Lawyers involved: \n",file=path,append=TRUE)
  cat(small_data$advocate_name,file=path,append=TRUE)
  
  cat("\n\n",file=path, append=TRUE)
  cat("Judges involved: \n",file=path,append=TRUE)
  cat(small_data$judges,file=path,append=TRUE)
}

