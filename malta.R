library(sf)
nuts0 <- st_read("data/europe_nuts0.geojson")

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
s <- ifelse(nuts0$NUTS_ID == "MT", sqrt(5), 1)

nuts0_MT <- scale_region(nuts0, s)
mapview::mapview(nuts0_MT)

st_write(nuts0_MT, "data/europe_nuts0_MT.geojson", delete_dsn = TRUE)

