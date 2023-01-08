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