# eda_plots.R
# Evan Yathon, November 2018
#
# This script reads in a cleaned dataset and creates exploratory visualizations.
# Visualizations are then saved to a specified output path and prefix
#
# Usage: Rscript src/eda_plots.R data/tidy_day.csv img/prefix
# 

# load argument for input data and output path
# args <- commandArgs(trailingOnly = TRUE)
# 
# input_file <- args[1]
# output_path <- args[2]

# load libraries
suppressMessages(library(tidyverse))
library(lubridate)
library(pracma)

main <- function(){
      
      tidy_df <- read_csv("data/tidy_day.csv")
      # tidy_df = read_csv(input_file)
      
      tidy_df <- tidy_df %>% 
            filter(rental_type == "both")
      
      
      
      #reorder factors in data so that it plots in logical order
      tidy_df <- tidy_df %>% 
            mutate(dteday = ymd(dteday),
                  rentalship = fct_relevel(rentalship, c("Low","Mid","High")),
                   season = as.factor(season),
                   season = fct_recode(season,
                                       winter = "1",
                                       spring = "2",
                                       summer = "3",
                                       autumn = "4"),
                   weathersit = as.factor(weathersit),
                   weathersit = fct_recode(weathersit, 
                                           clear = "1",
                                           misty = "2",
                                           light_rain = "3"))
      
      # show the ridership histogram and display the lines where the cutoffs were made
      ranges <- unname(quantile(tidy_df$rental_num,c(0.33,0.66)))
      
      (ridership_histo <- tidy_df %>% 
            ggplot(aes(x = rental_num)) +
            geom_histogram(colour = "black", bins = 30, fill = "dodgerblue3") +
            geom_vline(xintercept = ranges, size = 1.5, lty = 2) +
            labs(x = "Daily Rental Numbers",
                 title = "Histogram of Daily Bike Rentals with Quantile Lines") +
            annotate("text",
                     x = 1250,
                     y = 45,
                     label = paste("Q33 = ",round(ranges[1],0),"\n Q66 = ",round(ranges[2],0))) +
            annotate("text",
                     x = 2500,
                     y = 10,
                     label = "Low",
                     colour = "white",
                     size = 7) +
            annotate("text",
                     x = 4500,
                     y = 10,
                     label = "Mid",
                     colour = "white",
                     size = 7) +
            annotate("text",
                     x = 6500,
                     y = 10,
                     label = "High",
                     colour = "white",
                     size = 7) +
            theme(text = element_text(size = 15)))
      
      
      # useful to see ridership during weather conditions
      weather_rentalship_heatmap <- tidy_df %>% 
      (ggplot(aes(x = rentalship, y = weathersit)) +
            geom_bin2d() +
            labs(x = "Rentalship Categories",
                 y = "Weather Situation",
                 title = "Heatmap of Ridership for Different Weather Conditions") +
            theme(text = element_text(size = 15)))
   
      
      # calculate actual temperature
      tidy_df <- tidy_df %>% 
            mutate(actual_atemp = temp*(50+16) - 16)
      
      # temperature effects on ridership
      (atemp_crossplot <- ggplot(tidy_df, aes(x = actual_atemp, y = rental_num)) +
            geom_point() +
            labs(x = "'Feels Like' Temperature (Celcius)",
                 y = "Daily Rental Numbers") +
            theme(text = element_text(size = 15)))
      
      # did ridership increase year over year?
      (rider_by_date <- tidy_df %>% 
                  ggplot(aes(x = dteday, y = rental_num , colour = season)) +
                  geom_path(aes(group = 1), size = 0.7)+
                  geom_path(aes(x = dteday, 
                                y = movavg(rental_num, 15, type = "s"), 
                                group = 1), 
                            colour = "black",
                            size = 1.1,
                            lty = 2) +
                  labs(x = "Date",
                       y = "Daily Rental Numbers",
                       title = "Daily Ridership Numbers For 2011 and 2012") +
                  theme(text = element_text(size = 15)) +
                  annotate("text",
                           x = ymd("2011-06-01"),
                           y = 7500,
                           label = "--- Moving Average",
                           colour = "black",
                           size = 6)
      ) 
      
      #saving the plots to the location specified
      # ggsave(paste(output_path,"_ridership_histo.png"), 
      #        plot = ridership_histo, device = "png")
      # ggsave(paste(output_path,"_weather_rentalship_heatmap.png"), 
      #        plot = weather_rentalship_heatmap, device = "png")
      # ggsave(paste(output_path,"_atom_crossplot.png"), 
      #        plot = atemp_crossplot, device = "png")
      # ggsave(paste(output_path,"_rider_by_date.png"), 
      #        plot = rider_by_date, device = "png")
      
}

main()