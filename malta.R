library(sf)
nuts0 <- st_read("data/europe_nuts0.shp")

scale_region <- function(sf, s=rep(1, nrow(sf))){
  center <- st_centroid(sf)
  geom <- sf$geometry - center$geometry
  for (r in seq_len(nrow(sf))){
    geom[r] <- geom[r] * s[r]
  }
  sf$geometry <- geom + center$geometry
  sf
}

for(sc in c(1,2,3,4,5)){
  s <- ifelse(nuts0$NUTS_ID == "MT", sc, 1)
  m <- 
    nuts0 %>% 
    scale_region(s) %>% 
    tm_shape() + tm_fill(col="#00a1cd") + tm_borders(col="white") + tm_layout(paste0("Malta x ", sc)) 
  print(m)
}


library(raster)
r <- raster("~/Downloads/HDENS_CLST_2011/HDENS_CLST_2011.tif")
plot(r)

#tm_shape(nuts0) + tm_fill("gray90") + tm_shape(r) + tm_raster()
