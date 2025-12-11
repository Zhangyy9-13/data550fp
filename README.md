# Cognitive Decline Analysis

Analysis of cognitive decline related indicators using CDC data (2015–2022)

## Project Overview

This project analyzes cognitive decline indicators using CDC data spanning from 2015 to 2022. The analysis includes summary statistics and trend visualization of cognitive decline metrics.

## Docker Setup

### Building the Docker Image

To build the Docker image locally:

``` bash
docker build -t zhangyy9/data550fp-image:latest .
```

Or use the Makefile:

``` bash
make docker-build
```

### DockerHub Image

The pre-built Docker image is publicly available on DockerHub:

**🐳 <https://hub.docker.com/r/zhangyy9/data550fp-image>**

You can pull it directly:

``` bash
docker pull zhangyy9/data550fp-image:latest
```

### Generating the Report with Docker (Recommended)

To automatically generate the report using Docker:

``` bash
make docker-report
```

This command will: 1. Pull the latest Docker image from DockerHub (if not already available locally) 2. Create a `report/` directory in your project folder 3. Run the analysis inside a Docker container with all dependencies pre-installed 4. Generate the report and save it to the `report/` directory

**Note:** If you encounter renv-related errors, temporarily rename `.Rprofile`:

``` bash
mv .Rprofile .Rprofile.bak
make docker-report
mv .Rprofile.bak .Rprofile  # Restore after running
```

### System Compatibility

The Makefile automatically handles differences between operating systems: - **Mac/Linux**: Works out of the box - **Windows (Git Bash)**: Automatically adjusts file paths for proper volume mounting

## Local Development (Without Docker)

### Requirements

Make sure you have installed the required R packages: `dplyr`, `ggplot2`, `kableExtra`, and `here`.

### Generate Report Locally

From the project root directory, execute:

``` bash
make
```

This will: \* Run `code/01_process_data.R` to generate `.rds` files in the `output/` folder \* Run `code/02_render_report.R` to render `report.Rmd` and create `report.html` \* The final report is saved as `report.html` in the project root

## Project Structure

```         
.
├── Dockerfile                    # Docker image definition
├── Makefile                      # Automation commands
├── README.md                     # This file
├── report.Rmd                    # R Markdown report template
├── code/
│   ├── 01_process_data.R        # Data processing script
│   └── 02_render_report.R       # Report rendering script
├── output/                       # Processed datasets
│   ├── derived_data.rds         # Summary statistics
│   └── trend_data.rds           # Trend data
├── report/                       # Docker-generated reports
│   └── report.html              # Final report (from Docker)
└── renv/                         # R package management
    └── renv.lock
```

## Code Description

### `code/01_process_data.R`

-   Processes the CDC cognitive decline dataset
-   Generates the derived datasets `derived_data.rds` and `trend_data.rds` in the `output/` folder

### `code/02_render_report.R`

-   Renders `report.Rmd` into `report.html`

### `report.Rmd`

-   Reads data from the `output/` folder
-   Generates a summary table and a trend figure
-   Creates the final HTML report

## Output Description

### Summary Table

-   Summarizes the average and standard deviation of cognitive decline indicators
-   Generated from `output/derived_data.rds`
-   Code location: `# Summary Table` code chunk in `report.Rmd`

### Trend Figure

-   Shows trends of cognitive decline indicators across years 2015–2022
-   Generated from `output/trend_data.rds`
-   Code location: `# Trend Over Time` code chunk in `report.Rmd`

## Makefile Targets

-   `make` or `make report` - Generate report locally (without Docker)
-   `make docker-build` - Build the Docker image locally
-   `make docker-push` - Push the image to DockerHub
-   `make docker-report` - Generate report using Docker (recommended for reproducibility)
-   `make clean` - Remove generated reports
-   `make help` - Show available commands

## Author

Yuyao Zhang\
Emory University - DATA 550\
Fall 2025
