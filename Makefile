all : report/capital_bikeshare_analysis.md report/capital_bikeshare_analysis.html

result/cleaned_day.csv : src/load_csv.R data/day.csv
	Rscript src/load_csv.R data/day.csv result/cleaned_day.csv

result/summarised_data.csv report/img/accuracy.png report/img/dtree.png result/tree_summary.csv : src/summarise_data.py result/cleaned_day.csv
	python src/summarise_data.py result/cleaned_day.csv result/summarised_data.csv report/img/accuracy.png report/img/dtree.png result/tree_summary.csv

report/img/plot_atemp_crossplot.png  report/img/plot_rider_by_date.png  report/img/plot_ridership_histo.png  report/img/plot_weather_rentalship_heatmap.png : src/eda_plots.R result/cleaned_day.csv
	Rscript src/eda_plots.R result/cleaned_day.csv report/img/plot

report/img/important_features.png: src/important_features.R result/summarised_data.csv
	Rscript src/important_features.R result/summarised_data.csv report/img/important_features.png

report/capital_bikeshare_analysis.md report/capital_bikeshare_analysis.html: result/cleaned_day.csv result/summarised_data.csv report/img/accuracy.png report/img/dtree.png result/tree_summary.csv report/img/plot_atemp_crossplot.png  report/img/plot_rider_by_date.png  report/img/plot_ridership_histo.png  report/img/plot_weather_rentalship_heatmap.png report/img/important_features.png
	Rscript -e "rmarkdown::render('report/capital_bikeshare_analysis.Rmd')"

clean:
	rm -f report/img/*.png
	rm -f result/*.csv
	rm -f result/cleaned_day.csv
	rm -f report/capital_bikeshare_analysis.md
	rm -f report/*.html
