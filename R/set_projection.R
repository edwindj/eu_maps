data("Europe", package="tmap")
library(tmaptools)

proj <- get_projection(Europe)
for (f in list.files("data",pattern = "*.shp", full.names = TRUE)){
  shp <- read_shape(f, current.projection = proj)
  write_shape(shp, f)
}
