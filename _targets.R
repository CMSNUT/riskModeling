# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

tar_source()

# Run the R scripts in the R/ folder with your custom functions:
tar_option_set(packages = c("readr", "dplyr", "ggplot2"))


list(
  tar_target(file, "data/raw/data.csv", format = "file"),
  tar_target(data, get_data(file)),
  tar_target(model, fit_model(data)),
  tar_target(plot, plot_model(model, data)),
  tar_render(report,path = "reports/report.Rmd"
  )
)

