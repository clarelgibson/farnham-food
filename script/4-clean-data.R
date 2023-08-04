# SUMMARY ######################################################################
# This script cleans the data according to the findings of the data profiling

# SETUP ########################################################################
# > Packages ===================================================================
library(here)

# > Scripts ====================================================================
source(here("script/2-prep-data.R"))

# CLEAN DATA ###################################################################
# > FHR ========================================================================
fhr <- fhr_data %>% 
  # Remove records with missing location data
  filter(!is.na(longitude)) %>% 
  # clean rating value
  mutate(rating_value = as.numeric(rating_value)) %>% 
  # Remove records with missing rating values
  filter(!is.na(rating_value)) %>% 
  # recode rating key
  mutate(
    rating_key = case_when(
      grepl("0", rating_key) ~ "0 - urgent improvement is required",
      grepl("1", rating_key) ~ "1 - major improvement is required",
      grepl("2", rating_key) ~ "2 - some improvement is required",
      grepl("3", rating_key) ~ "3 - hygiene standards are generally satisfactory",
      grepl("4", rating_key) ~ "4 - hygiene standards are good",
      grepl("5", rating_key) ~ "5 - hygiene standards are very good",
      TRUE ~ rating_key
    )
  ) %>% 
  # append score to score columns
  rename(hygiene_score = hygiene,
         structural_score = structural,
         management_score = confidence_in_management) %>% 
  # correct location errors identified in profiling
  mutate(
    post_code = case_when(
      fhrsid == 187877 ~ "GU27 2BP",
      TRUE ~ post_code
    ),
    latitude = case_when(
      fhrsid == 187877 ~ round(51.0923509197681,7),
      fhrsid == 221501 ~ round(51.21564332626035,7),
      TRUE ~ latitude
    ),
    longitude = case_when(
      fhrsid == 187877 ~ round(-0.7060200868816853,7),
      fhrsid == 221501 ~ round(-0.8021015970813663,7),
      TRUE ~ longitude
    )
  )

# > FHR Plus SF ================================================================
fhr_as_sf <- st_as_sf(fhr,
                   coords = c("longitude", "latitude"),
                   crs = 27700)

fhr_sf <- st_join(
  fhr_as_sf,
  wd_src,
  join = st_intersects
)

# > FHR Waffle =================================================================
fhr_waffle <- fhr %>% 
  select(business_type,
         rating_value)