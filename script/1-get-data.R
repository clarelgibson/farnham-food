# SUMMARY ######################################################################
# This script reads data needed for Farnham Food project. Throughout this script
# "fhr" is used as an abbreviation for "Food Hygiene Rating"

# SETUP ########################################################################
# > Packages ===================================================================
library(xml2)
library(tibble)
library(tidyr)
library(dplyr)

# READ DATA ####################################################################
fhr_path <- here("data/src/FHRS314en-GB.xml")

# Read in the XML as an R list
fhr_xml <- as_list(read_xml(fhr_path))
