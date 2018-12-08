# Makefile
#
# By Mike Yuan and Evan Yathon, November 2018
#
# for automatically generating report and clean old output


TARGET = result/summarised_data.csv \
				 report/img/accuracy.png \
				 report/img/dtree.png \
				 result/tree_summary.csv

FIGURES = report/img/plot_atemp_crossplot.png  \
					report/img/plot_rider_by_date.png  \
					report/img/plot_ridership_histo.png  \
					report/img/plot_weather_rentalship_heatmap.png

SUMMARY = result/summarised_data.csv \
					report/img/accuracy.png \
					report/img/dtree.png \
					result/tree_summary.csv

FEATURES_IMPORTANCE = report/img/important_features.png

# run all to generate report from raw data
all : report/capital_bikeshare_analysis.md

# clean the data and save the cleaned data into result/ folder
result/cleaned_day.csv : src/load_csv.R data/day.csv
	Rscript $^ $@

# use cleaned data to anaylze the features and produce accuracy figure
$(SUMMARY) : src/summarise_data.py result/cleaned_day.csv
	python $^ $(TARGET)

# create plots for report
$(FIGURES) : src/eda_plots.R result/cleaned_day.csv
	Rscript $^ report/img/plot

# load the summarised_data.csv to create visualization
$(FEATURES_IMPORTANCE): src/important_features.R result/summarised_data.csv
	Rscript $^ $@

# generate report
report/capital_bikeshare_analysis.md: result/cleaned_day.csv $(TARGET) $(FIGURES) $(FEATURES_IMPORTANCE)
	Rscript -e "rmarkdown::render('report/capital_bikeshare_analysis.Rmd')"

# clean previous result and output
clean:
	rm -f report/img/*.png
	rm -f result/*.csv
	rm -f result/cleaned_day.csv
	rm -f report/capital_bikeshare_analysis.md
	rm -f report/*.html
