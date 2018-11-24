# important_features.R
#
# This script takes the output from scikit learn's featrures_importance and plots them
# to output a figure
#
# Usage: Rscript src/important_features.R result/summarised_data.csv img/important_features.png

# load argument for input data and output path
# args <- commandArgs(trailingOnly = TRUE)
# 
# input_file <- args[1]
# output_file <- args[2]


# load packages
suppressMessages(library(tidyverse))

main <- function(){
      
      # imp_feat <- read_csv(input_file)
      
      imp_feat <- read_csv("result/summarised_data.csv")
      
      (imp_feat_plot <- imp_feat %>% 
            select(-X1) %>% 
            ggplot(aes(x = fct_reorder(feature,gini_value), y = gini_value)) +
                  geom_col(colour = "Black",
                           fill = "dodgerblue3") +
                  theme(text = element_text(size = 15)) +
                  coord_flip() +
                  labs(y = "Gini Value (Feature Importance)",
                       x = "Features",
                       title = "Importance of Features in Bike Share Dataset")
      )
      
      #save the plots to the specified file
      # ggsave(output_file,
      #        plot = ridership_histo, device = "png", width = 9)
}

main()