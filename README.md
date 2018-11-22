# Capital Bikeshare Ridership Prediction

<sup>Mike Yuan ([Mikeymice](https://github.com/Mikeymice)) and Evan Yathon ([EvanYathon](https://github.com/EvanYathon)) </sup>

## Introduction

Bike sharing systems are becoming one of popular transportation measures in the urban areas. The bike share systems usually provide customers with durable bikes and stations for rental and parking. The bikes can be unlocked from any station and returned to any station at any time.

We are interested in answering the question.

> **What are the top predictors of rental bike ridership?**

To answer this question, we used data originally sourced from [Capital Bikeshare](https://www.capitalbikeshare.com) in metro DC. We intend to perform supervised machine learning using decision tree classification.  Valid features such as temperature, weather and day of the week will be included.  In order to simplify the potential ridership outcomes, the ridership will be broken into different categories; an example could be low, medium and high ridership.  To find the bounds of the categories some initial exploratory data analysis will be performed to investigate the number of riders.  Our initial idea is a histogram of ridership and using quantiles to evenly split the data into thirds.

Splitting the dataset randomly into two sets will create both a training and test dataset.  The decision tree will be trained using the training dataset, and then predict the outcome of the test dataset.  Because the actual ridership outcomes are known for the test dataset, the predicted outcomes can be compared to the actual outcomes and a percentage of correctly identified outcomes will be generated.  Using a visualization of the tree and/or scikit-learn's `feature_importances_` function will determine which of the features are the top three strongest predictors of bicycle ridership.

## Data Attributes

This analysis is performed on the [Bike Sharing Dataset](https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset) provided by the UCI Machine Learning Repository

Both hour.csv and day.csv have the following fields, except hr which is not available in day.csv

-   instant: record index
-   dteday : date
-   season : season (1:springer, 2:summer, 3:fall, 4:winter)
-   yr : year (0: 2011, 1:2012)
-   mnth : month ( 1 to 12)
-   hr : hour (0 to 23)
-   holiday : weather day is holiday or not (extracted from [Web Link])
-   weekday : day of the week
-   workingday : if day is neither weekend nor holiday is 1, otherwise is 0.
-   weathersit :
    \--   1: Clear, Few clouds, Partly cloudy, Partly cloudy
    \--   2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
    \--   3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
    \--   4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog
-   temp : Normalized temperature in Celsius. The values are derived via (t-t_min)/(t_max-t_min), t_min=-8, t_max=+39 (only in hourly scale)
-   atemp: Normalized feeling temperature in Celsius. The values are derived via (t-t_min)/(t_max-t_min), t_min=-16, t_max=+50 (only in hourly scale)
-   hum: Normalized humidity. The values are divided to 100 (max)
-   windspeed: Normalized wind speed. The values are divided to 67 (max)
-   casual: count of casual users
-   registered: count of registered users
-   cnt: count of total rental bikes including both casual and registered

## Usage

1.  Clone this repo, and using the command line, navigate to the root of this project.
2.  Run the following commands:

    ```sh
    Rscript src/load_csv.R data/day.csv data/cleaned_day.csv
    python3 src/summarise_data.py data/cleaned_day.csv result/summarised_data.csv img/accuracy.png img/dtree.png

    # add more script below REMOVE THIS LINE afterward!!!!!
    ```

    or on your command shell

    ```sh
    bash run_all.sh
    ```

## Dependencies

-   ### R and R libraries
    -   `tidyverse`
    -   `lubridate`
    -   `ggplot2`
    -   `rmarkdown`
    -   `knitr`
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
