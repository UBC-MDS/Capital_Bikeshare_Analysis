# get the range for the category high, mid and low ridership in term of count

# Usage: Rscript src/get_range_for_rentalship.R

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

get_range_for_rentalship()