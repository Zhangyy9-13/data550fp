FROM rocker/r-ver:4.3.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pkg-config \
    libxml2-dev \
    libfontconfig1-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /project

# Install all required R packages
RUN R -e "install.packages(c(\
    'rmarkdown', 'knitr', 'tinytex', \
    'here', 'dplyr', 'ggplot2', \
    'kableExtra', 'scales', \
    'bslib', 'htmltools', 'jquerylib', 'sass', \
    'cli', 'glue', 'rlang', 'lifecycle', \
    'tibble', 'tidyselect', 'pillar', 'vctrs', \
    'R6', 'magrittr', 'stringr', 'stringi', \
    'xml2', 'yaml', 'jsonlite', \
    'RColorBrewer', 'viridisLite', \
    'base64enc', 'digest', 'evaluate', \
    'fastmap', 'fontawesome', 'fs', \
    'highr', 'mime', 'rappdirs', 'rprojroot', \
    'withr', 'xfun', 'labeling', 'farver', \
    'gtable', 'isoband', 'pkgconfig', \
    'cachem', 'memoise', 'cpp11', 'generics', \
    'utf8', 'rstudioapi', 'svglite', 'systemfonts', 'textshaping', 'S7' \
    ), repos = 'https://cloud.r-project.org')"

# Copy project files
COPY . /project

# Disable renv by renaming .Rprofile
RUN if [ -f .Rprofile ]; then mv .Rprofile .Rprofile.bak; fi

# Set environment variables to disable renv
ENV RENV_CONFIG_AUTO_SNAPSHOT=FALSE
ENV RENV_CONFIG_AUTO_RESTORE=FALSE

# Verify critical packages
RUN R -e "library(here); library(rmarkdown); library(knitr); library(dplyr); library(ggplot2); library(kableExtra); cat('All packages loaded successfully!\n')"

CMD ["R"]