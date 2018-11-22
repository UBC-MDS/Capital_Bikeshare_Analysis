# eda_plots.R
# Evan Yathon, November 2018
#
# This script reads in a cleaned dataset and creates exploratory visualizations.
# Visualizations are then saved to a specified output path
#
# Usage: Rscript src/eda_plots.R data/tidy_day.csv img/
# 

# load argument for input data and output path
# args <- commandArgs(trailingOnly = TRUE)
# 
# input_file <- args[1]
# output_path <- args[2]

# load libraries
suppressMessages(library(tidyverse))

main <- function(){
      
      tidy_day_df <- read_csv("data/tidy_day.csv")
      
      tidy_day_df <- tidy_day_df %>% 
            filter(rental_type == "both")
      
      #reorder factors in data so that it plots in logical order
      tidy_day_df <- tidy_day_df %>% 
            mutate(rentalship = fct_relevel(rentalship, c("Low","Mid","High")),
                   weathersit = as.factor(weathersit),
                   weathersit = fct_recode(weathersit, 
                                           clear = "1",
                                           misty = "2",
                                           light_rain = "3"))
      
      # show the ridership histogram and display the lines where the cutoffs were made
      ranges <- unname(quantile(tidy_day_df$rental_num,c(0.33,0.66)))
      
      tidy_day_df %>% 
            ggplot(aes(x = rental_num)) +
            geom_histogram(colour = "black", bins = 30, fill = "dodgerblue3") +
            geom_vline(xintercept = ranges, size = 1.5, lty = 2)
      
      # useful to see ridership during weather conditions
      tidy_day_df %>% 
      ggplot(aes(x = rentalship, y = weathersit)) +
            geom_bin2d() 
      
      # Another way to see ridership during weather conditions
      tidy_day_df %>% 
            ggplot(aes(x = as.factor(weathersit), y = rental_num)) +
            geom_boxplot() +
            geom_jitter()
      
      # calculate actual temperature
      tidy_day_df <- tidy_day_df %>% 
            mutate(actual_temp = temp*(39+8) - 8)
      
      # useful to see ridership with reponse to temperature
      # output suggests that converting temp back to original values not necessary
      ggplot(tidy_day_df, aes(x = temp, y = rental_num)) +
            geom_point()
      
      #check to see if actual temp effects the ridership
      ggplot(tidy_day_df, aes(x = actual_temp, y = rental_num)) +
            geom_point()
      
      # plot to see rentalship numbers by season
      tidy_day_df %>% 
            ggplot(aes(x = as.factor(season), y = rental_num)) +
                  geom_boxplot()
      

}

main()