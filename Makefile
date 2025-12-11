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

# Build Docker image
docker-build:
	docker build -t data550fp-image .

# Generate report using Docker
docker-report:
	mkdir -p report
	docker run --rm -v "$(PWD):/project" zhangyy9/data550fp-image:latest Rscript code/02_render_report.R
