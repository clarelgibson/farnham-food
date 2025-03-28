# SUMMARY ######################################################################
# This script reads data needed for Farnham Food project. Throughout this script
# "fhr" is used as an abbreviation for "Food Hygiene Rating"

# SETUP ########################################################################
# > Packages ===================================================================
library(xml2)
library(tibble)
library(tidyr)
library(dplyr)
library(here)
library(sf)

# READ DATA ####################################################################
fhr_path <- here("data/src/FHRS314en-GB.xml")
lad_path <- here("data/src/shape-lad/LAD_MAY_2023_UK_BFC_V2.shp")

# Read in the XML as an R list
fhr_xml <- as_list(read_xml(fhr_path))

# Read in geocoded FHR data
fhr_geo <- readRDS(here("data/src/fhr_geo.rds"))
