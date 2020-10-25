## leaflet

install.packages('rjson')
install.packages('jsonlite')
install.packages('leaflet')
install.packages('RCurl')

library(dplyr)
library(ggplot2)
library(rjson)
library(jsonlite)
library(leaflet)
library(RCurl)



base_url <- "https://data.colorado.gov/resource/j5pc-4t32.json?"
full_url <- paste0(base_url, "station_status=Active",
                   "&county=BOULDER")
water_data <- getURL(URLencode(full_url))

# you can then pipe this
water_data_df <- fromJSON(water_data) %>%
  flatten(recursive = TRUE) # remove the nested data frame

# turn columns to numeric and remove NA values
water_data_df <- water_data_df %>%
  mutate_at(vars(amount, location.latitude, location.longitude), funs(as.numeric)) %>%
  filter(!is.na(location.latitude))



teste <- 
  c(23.2166771)


leaflet::addAwesomeMarkers(map,lng = 23.2166771, lat = 46.8787041)



map <- leaflet::leaflet() %>%
  leaflet::addProviderTiles(providers$OpenStreetMap)

map  # show the map

# Insert your latitude and longitude in the code below
# NOTE: Don't get them reversed otherwise you'll end up in the South Pole.

# Initialize and assign m as the leaflet object
leaflet() %>%
  # Now add tiles to it
  addTiles() %>%  
  # Setting the middle of where the map should be and the zoom level
  addMarkers(lat=-23.2166771, lng=-46.8808928, popup = "Francisco's house")



leaflet::leaflet() %>% 
  addTiles()





