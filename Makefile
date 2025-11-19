report.html: report.Rmd code/02_render_report.R .processed_data
	Rscript code/02_render_report.R

# creates output/processed_data.rds
.processed_data: code/01_process_data.R
	Rscript code/01_process_data.R && touch .processed_data

install:
	Rscript -e "renv::restore()"

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html && rm -f .processed_data