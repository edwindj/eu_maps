data("Europe", package="tmap")
library(tmaptools)

proj <- get_projection(Europe)

for (f in list.files("../data",pattern = "europe_.+.shp", full.names = TRUE)){
  shp <- read_shape(f, current.projection = proj)
  write_shape(shp, f)
}

world_eck4 <- read_shape("../data/world_eck4.shp", current.projection = get_proj4("eck4"))
write_shape(world_eck4,"../data/world_eck4.shp")

world_robin <- read_shape("../data/world_robinson.shp", current.projection = get_proj4("robin"))
write_shape(world_robin,"../data/world_robinson.shp")

world_longlat <- read_shape("../data/world_wgs84.shp", current.projection = get_proj4("longlat"))
write_shape(world_longlat,"../data/world_wgs84.shp")
