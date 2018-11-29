# Capital Bikeshare Ridership Prediction

<sup>Mike Yuan ([Mikeymice](https://github.com/Mikeymice)) and Evan Yathon ([EvanYathon](https://github.com/EvanYathon)) </sup>

Bike sharing systems are becoming one of popular transportation measures in the urban areas. The bike share systems usually provide customers with durable bikes and stations for rental and parking. The bikes can be unlocked from any station and returned to any station at any time.

We are interested in answering the question.

> **What are the top three predictors of rental bike ridership?**

To answer this question, we used data originally sourced from [Capital Bikeshare](https://www.capitalbikeshare.com) in metro DC. We performed supervised machine learning using decision tree classification.  Valid features such as temperature, weather and day of the week were included.  In order to simplify the potential ridership outcomes, the ridership were broken into different categories;  `Low`, `Medium` and `High` ridership categories.  To find the bounds of the categories, we used quantiles to evenly split the number of rentals per day in our data. Data cleaning and wrangling were performed.

To optimize the accuracy of the decision tree, we performed cross validation on the cleaned data to define the ideal maximum height for the tree.  The decision tree would be trained using this optimal height. By visualizing the tree and utilizing scikit-learn's `feature_importances` function, we determined which of the features are the strong predictors of daily bicycle ridership.

[Link to report.](report/capital_bikeshare_analysis.md)

## Data Attributes

This analysis was performed on the [Bike Sharing Dataset](https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset) provided by the UCI Machine Learning Repository

Both hour.csv and day.csv had the following fields, except hr which was not available in day.csv

| Variable   | Description                                                                                                                                                                                                                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| instant    | record index                                                                                                                                                                                                                                                                                                  |
| dteday     | date                                                                                                                                                                                                                                                                                                          |
| season     | season (1:springer, 2:summer, 3:fall, 4:winter)                                                                                                                                                                                                                                                               |
| yr         | year (0: 2011, 1:2012)                                                                                                                                                                                                                                                                                        |
| mnth       | month ( 1 to 12)                                                                                                                                                                                                                                                                                              |
| hr         | hour (0 to 23)                                                                                                                                                                                                                                                                                                |
| holiday    | weather day is holiday or not                                                                                                                                                                                                                                                                                 |
| weekday    | day of the week                                                                                                                                                                                                                                                                                               |
| workingday | if day is neither weekend nor holiday is 1, otherwise is 0.                                                                                                                                                                                                                                                   |
| weathersit | <ol>  <li>Clear, Few clouds, Partly cloudy, Partly cloudy</li><li>Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist</li> <li>Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds</li> <li>Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog</li></ol> |
| temp       | Normalized temperature in Celsius. The values are derived via <br> `(t-t_min)/(t_max-t_min), t_min=-8, t_max=+39 (only in hourly scale)`                                                                                                                                                                      |
| atemp      | Normalized feeling temperature in Celsius. The values are derived via <br> `(t-t_min)/(t_max-t_min), t_min=-16, t_max=+50 (only in hourly scale)`                                                                                                                                                             |
| hum        | Normalized humidity. The values are divided to 100 (max)                                                                                                                                                                                                                                                      |
| windspeed  | Normalized wind speed. The values are divided to 67 (max)                                                                                                                                                                                                                                                     |
| casual     | count of casual users                                                                                                                                                                                                                                                                                         |
| registered | count of registered users                                                                                                                                                                                                                                                                                     |
| cnt        | count of total rental bikes including both casual and registered                                                                                                                                                                                                                                              |

## Usage

1.  Clone this repo, and using the command line, navigate to the root of this project.
2.  Run the following command to produce the report

    ```sh
    make all
    ```

    or on your command shell

    ```sh
    bash run_all.sh
    ```

    Run the following command to clean previous result

    ```sh
    make clean
    ```


3.  The report will be generated under the  `report/` directory

## V2.0 Dependencies

-   ### R and R libraries
    -   `tidyverse`
    -   `lubridate`
    -   `ggplot2`
    -   `rmarkdown`
    -   `knitr`
    -   `pracma`
-   ### Python
    -   `pandas`
    -   `numpy`
    -   `sklearn`
    -   `graphviz`
    -   `pydotplus`
    -   `seaborn`
    -   `Ipython`
    -   `matplotlib`
    -   `tqdm`
