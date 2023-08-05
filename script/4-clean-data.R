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
  # add rating indicators
  mutate(
    rating_indicator_inc_zero = case_when(
      rating_value >= 3 ~ "Satisfactory",
      rating_value >= 1 ~ "Unsatisfactory",
      rating_value == 0 ~ "Rating 0"
    ),
    rating_indicator_binary = case_when(
      rating_value >= 3 ~ "Satisfactory",
      rating_value >= 0 ~ "Unsatisfactory"
    )
  ) %>% 
  # append score to score columns
  rename(hygiene_score = hygiene,
         structural_score = structural,
         management_score = confidence_in_management) %>% 
  # join town data from geocoded data
  left_join(select(fhr_geo,
                   fhrsid,
                   town)) %>% 
  # keep Farnham only
  filter(town == "Farnham")

# > FHR Waffle =================================================================
fhr_waffle <- fhr %>% 
  # select dimensions to measure on
  select(business_type,
         rating_indicator_binary) %>% 
  arrange(business_type,
          rating_indicator_binary) %>% 
  # add count by business type
  group_by(business_type) %>% 
  mutate(count_business_type = n()) %>% 
  ungroup() %>% 
  # add count of rating by business type
  group_by(business_type,
           rating_indicator_binary) %>% 
  mutate(count_rating = n(),
         pct_rating = count_rating / count_business_type) %>% 
  ungroup() %>% 
  distinct() %>% 
  # keep only the satisfactory rows
  filter(rating_indicator_binary == "Satisfactory") %>% 
  select(business_type,
         total_businesses = count_business_type,
         count_satisfactory = count_rating,
         pct_satisfactory = pct_rating)
  
