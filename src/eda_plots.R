# eda_plots.R
# Evan Yathon, November 2018
#
# This script reads in a cleaned dataset and creates exploratory visualizations
#



# load libraries
suppressMessages(library(tidyverse))
library(GGally)

main <- function(){
      
      tidy_day_df <- read_csv("data/tidy_day.csv")
      
      #reorder factors in data so that it plots in logical order
      tidy_day_df <- tidy_day_df %>% 
            mutate(rentalship = fct_relevel(rentalship, c("Low","Mid","High")),
                   rental_type = as_factor(rental_type))
      
      ggpairs(filter(tidy_day_df,rental_type == "both"), columns = c(8,9,10,11,12))
      
      # useful to see ridership during weather conditions
      tidy_day_df %>% 
            filter(rental_type == "both") %>% 
      ggplot( aes(x = rentalship, y = as.factor(weathersit))) +
            geom_bin2d() +
            facet_grid(rental_type ~ .)
      
      # only both rental types
      tidy_day_df %>% 
            filter(rental_type == "both") %>% 
      ggplot(aes(x = rentalship, y = as.factor(weathersit))) +
            geom_bin2d() +
            facet_grid(rental_type ~ .)
      
      # calculate actual temperature
      tidy_day_df <- tidy_day_df %>% 
            mutate(actual_temp = temp*(39+8) - 8)
      
      # useful to see ridership with reponse to temperature
      # output suggests that converting temp back to original values not necessary
      ggplot(tidy_day_df, aes(x = temp, y = rental_num)) +
            geom_point() +
            facet_grid(rental_type ~ .)
      
      #check to see if actual temp effects the ridership
      ggplot(tidy_day_df, aes(x = actual_temp, y = rental_num)) +
            geom_point() +
            facet_grid(rental_type ~ .)
      
      # plot to see rentalship numbers 
      tidy_day_df %>% 
            ggplot(aes(x = as.factor(season), y = rental_num)) +
                  geom_boxplot() +
                  facet_grid(rental_type ~ .)
      
      tidy_day_df %>% 
            filter(rental_type == "both") %>% 
      ggplot(aes(x = as.factor(weathersit), y = rental_num)) +
            geom_boxplot() +
            geom_jitter()
      

}

main()