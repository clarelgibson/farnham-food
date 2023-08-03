# SUMMARY ######################################################################
# This script knits the html document from the Rmarkdown document to a 
# specified folder so that it can be published via GitHub Pages.

# SETUP ########################################################################
# > Packages ===================================================================
library(rmarkdown)

# KNIT #########################################################################
render(
  here("script/3-data-profiling.Rmd"),
  output_file = here("docs/data-profiling.html")
)