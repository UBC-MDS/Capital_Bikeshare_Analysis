# load_csv.R
#
# This script load the .csv filename that is provided as arugment output
# the clean/tidy version of data in csv with direcotry/filename provided in
# arugments
#
# Usage: Under project directory run the command Rscript src/load_csv.R


#%% bload library
suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))
library(ggplot2)


# iniate global variable for data frame
# Usage: Rscript src/load_csv.R

#%% load arugment for input and output
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]
output_file <- args[2]

# input_file <- "data/day.csv"
# output_file <- "data/tidy_day_csv"
file_name <- basename(input_file)



#%% main function to read csv and clean data
main <-function(){

  #%%
  cat(sprintf("===> loading %s\n",input_file))
  data <- read.csv(input_file)
  cat("done\n")


  #%% for testing purpose
  # cat(sprintf("\n===> printint head of the data frame from %s\n", input_file))
  # print(head(data))

  #%% getting low_range and high_range for the rentalship
  ranges <- unname(quantile(data$cnt,c(0.33,0.66)))
  low_range <- ranges[[1]]
  high_range <- ranges[[2]]

  cat(sprintf("===> cleaning %s\n",input_file))
  #%% gather the rental type
  tidy_day_df <- data %>%
    rename(both = cnt) %>%
    gather("rental_type","rental_num", casual, registered, both )

  #%% adding rentalship label as factor
  tidy_day_df <- tidy_day_df %>%
    mutate(rentalship = as.factor(case_when(rental_num <= low_range ~ "Low",
                                            rental_num >= high_range ~ "High",
                                            TRUE ~ "Mid")))

  #%% added day of month and year
  tidy_day_df <- tidy_day_df %>%
    mutate(day_in_month = day(dteday)) %>%
    mutate(year = year(dteday))
  #%%

  # remove instant?
  tidy_day_df$instant <- NULL
  cat("done")

  #%% for testing purpose
  # cat(sprintf("\n===> printint head of the TIDY data frame from %s\n", input_file))
  # print(head(tidy_day_df))

  cat(sprintf("\n===> saving tidy data to %s\n", output_file))
  write.csv(tidy_day_df, file = output_file)
  cat("done\n")

}


main()
