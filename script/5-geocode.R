# SUMMARY ######################################################################
# This script cleans the data according to the findings of the data profiling

# SETUP ########################################################################
# > Packages ===================================================================
library(here)
library(httr)
library(jsonlite)

# > Scripts ====================================================================
#source(here("script/4-clean-data.R"))

# GEOCODE ######################################################################
# > Data =======================================================================
data_to_geocode <- 
  fhr_data %>% 
  # remove rows with no location data
  filter(!is.na(longitude)) %>% 
  select(fhrsid, longitude, latitude)

# How many records do we need to geocode
n_to_geocode <- nrow(data_to_geocode)

# Create an empty tibble to store results
data_geocoded <- tibble(
  fhrsid = 0,
  longitude = 0,
  latitude = 0,
  neighbourhood = "XXX",
  hamlet = "XXX",
  suburb = "XXX",
  village = "XXX",
  town = "XXX",
  city_district = "XXX",
  city = "XXX"
)

# > Geocoding ==================================================================
# Iterate through each record and geocode
for (i in seq_along(1:n_to_geocode)) {
  
  #cat("Defining url", "\n")
  url_root <- "https://eu1.locationiq.com/v1/reverse?key="
  token <- Sys.getenv("LOCATIONIQ_API_KEY")
  lat <- paste0("&lat=", data_to_geocode$latitude[i])
  lon <- paste0("&lon=", data_to_geocode$longitude[i])
  format <- "&format=json"
  options <- "&addressdetails=1"
  
  url <- paste0(
    url_root,
    token,
    lat,
    lon,
    format,
    options
  )
  
  #cat("Url:", url, "\n")
  #cat("...Done", "\n", "\n")
  
  #cat("Performing API call", "\n")
  res <- VERB(
    "GET",
    url
  )
  #cat("...Done", "\n", "\n")
  
  #cat("Extracting content", "\n")
  content <- content(res)
  #print(content$address)
  #cat("...Done", "\n", "\n")
  
  #cat("Creating new row for df", "\n")
  new_data <- tibble(
    fhrsid = data_to_geocode$fhrsid[i],
    longitude = data_to_geocode$longitude[i],
    latitude = data_to_geocode$latitude[i],
    neighbourhood = content$address$neighbourhood,
    hamlet = content$address$hamlet,
    suburb = content$address$suburb,
    village = content$address$village,
    town = content$address$town,
    city_district = content$address$city_district,
    city = content$address$city
  )
  #cat("...Done", "\n", "\n")
  
  #cat("Binding new data to df", "\n")
  data_geocoded <- data_geocoded %>% 
    bind_rows(new_data) %>% 
    filter(fhrsid != 0)
  #cat("...Done", "\n", "\n")
  
  # Build in a 1s delay to comply with free geocoding restrictions
  Sys.sleep(1)
  cat("Completed", i, "of", n_to_geocode, "\n")
}

# CLEAN RESULTS ################################################################
fhr_geo <- data_geocoded %>% 
  filter(fhrsid != 0) %>% 
  mutate(town = coalesce(town,
                         village,
                         hamlet,
                         suburb,
                         neighbourhood,
                         city_district,
                         city)) %>% 
  select(fhrsid,
         town)

# SAVE #########################################################################
saveRDS(fhr_geo,
        here("data/src/fhr_geo.rds"))
