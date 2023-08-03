# SUMMARY ######################################################################
# This script processes data needed for Farnham Food project. Throughout this 
# script "fhr" is used as an abbreviation for "Food Hygiene Rating"

# SETUP ########################################################################
# > Scripts ====================================================================
source(here("script/1-get-data.R"))

# > Packages ===================================================================
library(janitor)
library(readr)

# PARSE DATA ###################################################################
# Convert to tibble by highest required xml tag
fhr_df <- as_tibble(fhr_xml) %>% 
  unnest_longer(FHRSEstablishment)

# > Metadata ===================================================================
# Store metadata in a separate df
fhr_meta <- fhr_df %>% 
  # extract the top 3 rows which contain the metadata
  head(3) %>% 
  # unnest the values to single element list
  unnest(FHRSEstablishment) %>% 
  # unnest a 2nd time to extract just the values
  unnest(FHRSEstablishment) %>% 
  # transpose the df
  pivot_wider(
    names_from = FHRSEstablishment_id,
    values_from = FHRSEstablishment
  ) %>% 
  # fix the data types
  type_convert()

# > FHR Data ===================================================================
fhr_data <- fhr_df %>% 
  # filter to exclude the metadata
  filter(FHRSEstablishment_id == "EstablishmentDetail") %>% 
  # unnest all levels with children
  unnest_wider(FHRSEstablishment) %>% 
  unnest_wider(Scores) %>% 
  unnest_wider(Geocode) %>% 
  # unnest twice to extract values from list
  unnest(cols = names(.)) %>% 
  unnest(cols = names(.)) %>% 
  # fix the types and headers
  type_convert() %>% 
  clean_names()