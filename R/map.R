library(tmap)
library(tmaptools)

data("Europe")
proj <- get_projection(Europe)

country <- tmaptools::read_shape("data-raw/country.shp", current.projection = proj)
nuts0 <- tmaptools::read_shape("data-raw/nuts1.shp", current.projection = proj)
nuts1 <- tmaptools::read_shape("data-raw/nuts2.shp", current.projection = proj)
nuts2 <- tmaptools::read_shape("data-raw/nuts3.shp", current.projection = proj)
nuts3 <- tmaptools::read_shape("data-raw/nuts4.shp", current.projection = proj)

# tmaptools::write_shape(country, "data-raw/country.shp")
# tmaptools::write_shape(nuts0, "data-raw/nuts0.shp")
# tmaptools::write_shape(nuts1, "data-raw/nuts1.shp")
# tmaptools::write_shape(nuts2, "data-raw/nuts2.shp")
# tmaptools::write_shape(nuts3, "data-raw/nuts3.shp")

tm_shape(country) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts0) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(country) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts1) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(country) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts2) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(country) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts3) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 0.5, lwd=0.5, legend.show=FALSE
             )
