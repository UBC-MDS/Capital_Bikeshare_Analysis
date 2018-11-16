# Under project directory run the command Rscript src/load_csv.R
# load the csv file in /data
library(tidyverse)
library(ggplot2)


# iniate global variable for data frame

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

# get the range for the category high, mid and low ridership in term of count
get_range_for_rentalship <- function()
{


  low_range <- quantile(day_df$cnt,0.33)
  high_range <- quantile(day_df$cnt,0.66)

  day_df %>%
  ggplot(aes(x = cnt)) +
  geom_density() +
  geom_vline(xintercept=low_range, color='red') +
  geom_vline(xintercept=high_range,color='blue')


  nrow(day_df %>% filter(cnt < low_range))
  nrow(day_df %>% filter(cnt > high_range))
  nrow(day_df %>% filter(cnt > low_range & cnt < high_range))

  day_df %>%
  ggplot(aes(x = casual)) +
  geom_histogram()

  quantile(day_df$cnt,0.66)
}

main()
