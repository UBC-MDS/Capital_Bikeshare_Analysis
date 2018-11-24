# SRC folder

This directory contains all the script involves file-loading, data-cleaning, analysis and visualization tasks.

Every script should be run directly under the **project** folder.

To run R script
`Rscript src/<filename>.R ...`

To run Python file
`Python3 src/<filename>.py ...`

<sup>`...` are the possible arguments for the script. For specific argument, check the usage comment in each script file </sup>

The list of the scripts will be updated periodically

| file                     | description                  |
| ------------------------ | ---------------------------- |
| [load_csv.R](load_csv.R) | Load csv file in data folder |
| [eda_plots.R](eda_plots.R) | Create EDA plots for final report |
| [summarise_data.py](summarise_data.py) | Run decision tree and calculate feature importance on data output from [load_csv.R](load_csv.R) |
| [important_features.R](important_features.R) | Takes output important features csv from [summarise_data.py](summarise_data.py) and makes a summary chart |
