# Cognitive Decline Analysis

> Analysis of cognitive decline related indicators using CDC data (2015–2022)

------------------------------------------------------------------------

## Initial code description

`code/01_process_data.R`

-   processes the CDC cognitive decline dataset
-   generates the derived datasets `derived_data.rds` and `trend_data.rds` in the `output/` folder

`code/02_render_report.R`

-   renders `report.Rmd` into `report.html`

`report.Rmd`

-   reads data from the `output/` folder
-   generates a summary table and a trend figure
-   creates the final HTML report

`Makefile`

-   contains rules for building the report
-   `make report` will generate the required `.rds` files and render `report.html`

`output/`

-   stores processed `.rds` datasets used in the report
-   e.g., `derived_data.rds` and `trend_data.rds`

`report.html`

-   the final report generated from `report.Rmd`

------------------------------------------------------------------------

## How to generate the final report

1.  Make sure you have installed the required R packages: `dplyr`, `ggplot2`, `kableExtra`, and `here`.

2.  From the project root directory, execute:

``` bash
make
```

3.  This will:

    -   Run `code/01_process_data.R` to generate `.rds` files in the `output/` folder
    -   Run `code/02_render_report.R` to render `report.Rmd` and create `report.html`

4.  The final report is saved as `report.html` in the project root.

------------------------------------------------------------------------

## Code and data description

-   This table summarizes the average and standard deviation of cognitive decline indicators.

-   This figure shows trends of cognitive decline indicators across years 2015–2022.

### Table generation

-   The summary table is generated from the `output/derived_data.rds` dataset
-   Code responsible: the `# Summary Table` code chunk in `report.Rmd`

### Figure generation

-   The trend figure is generated from the `output/trend_data.rds` dataset

-   Code responsible: the `# Trend Over Time` code chunk in `report.Rmd`
