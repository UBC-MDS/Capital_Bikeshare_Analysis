# Under project directory run the command Rscript src/load_csv.R
# load the csv file in /data
library(tidyverse)
library(ggplot2)


# iniate global variable for data frame
# Usage: Rscript src/load_csv.R

main <-function(){

  cat("\n===> loading day.csv\n")
  day_df <- read.csv("data/day.csv")
  cat("done\n")

  cat("\n===> loading hour.csv\n")
  hour_df <- read.csv("data/hour.csv")
  cat("done\n")

  # demonstrate able to read the csv file
  cat("\n===> printint head of the day_df\n")
  print(head(day_df))

  cat("\n===> print head of the hour_df\n")
  print(head(hour_df))

}

main()
