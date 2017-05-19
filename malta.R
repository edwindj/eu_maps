library(sf)
nuts0 <- st_read("data/europe_nuts0.geojson")

scale_region <- function(sf, s=rep(1, nrow(sf))){
  center <- st_centroid(sf)
  geom <- sf$geometry - center$geometry
  for (r in seq_len(nrow(sf))){
    geom[r] <- geom[r] * s[r]
  }
  sf$geometry <- geom + center$geometry
  sf
}
