library(sf)
library(dplyr)

europe <- st_read("data/europe_map.geojson") %>% 
  st_set_crs(3035)

# fix two country codes...
country_code <- c( "FRA" = "FR"
                 , "NOR" = "NO"
                 )

i <- match(names(country_code), europe$ADM0_A3)
europe$statcode <- as.character(europe$statcode)
europe$statcode[i] = unname(country_code)

# remove three letter code
europe <-
  europe %>% 
  select(statcode, statnaam, statname)

scale_region <- function(sf, s=rep(1, nrow(sf))){
  crs <- st_crs(sf)
  center <- st_centroid(sf)
  geom <- sf$geometry - center$geometry
  for (r in seq_len(nrow(sf))){
    geom[r] <- geom[r] * s[r]
  }
  sf$geometry <- geom + center$geometry
  st_crs(sf) <- crs
  sf
}

# rescale Malta
s <- ifelse(europe$statcode == "MT", sqrt(5), 1)
europe_MT <- scale_region(europe, s)
#mapview::mapview(europe_MT)

st_write(europe_MT, "data/europe_MT.geojson", delete_dsn = TRUE, layer_options = "COORDINATE_PRECISION=0")
st_write(europe_MT, "data/europe_MT.shp", delete_dsn = TRUE)

europe_MT %>% 
  st_set_geometry(NULL) %>% 
  write.csv(file = "data-raw/countries2.csv", row.names =  FALSE, na = "")

