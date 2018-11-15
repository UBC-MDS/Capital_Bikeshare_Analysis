# Under project directory run the command Rscript src/load_csv.R
# load the csv file in /data
library(tidyverse)

main <-function(){
  day_df <- read.csv("data/day.csv")
  hour_df <- read.csv("data/hour.csv")
  # demonstrate able to read the csv file

  print(head(day_df))
  print(head(hour_df))
}

main()
