####***********************
#### NICUs ####
# Author: Joan Casey
# Date: 03 May 2023
# Updated: 03 May 2023
# Goal: Map and create county-level NICU metrics
####**********************

#Load packages, installing if needed
if (!requireNamespace("pacman", quietly = TRUE))
  install.packages("pacman")
pacman::p_load(
  here,
  usethis,
  dplyr,
  readr,
  tidyr,
  rlang,
  ggplot2,
  sf,
  tidygeocoder
)

#These data came from: https://neonatologysolutions.com/nicu-directory/
nicu <- read_csv("data/nicus/present-day/nicus_2023.csv")
glimpse(nicu) #1396 NICUs

#Need to geocode these nicus
nicu <- nicu %>% unite("full_address", addr:city_state_zip, sep= " ", remove=FALSE)

# geocode the addresses
test <- nicu[1,]
lat_longs <- test %>%
  geocode(full_address, method = 'osm', lat = latitude , long = longitude)

#County centroids -- https://www.census.gov/geographies/reference-files/time-series/geo/centers-population.2010.html#list-tab-1319302393

