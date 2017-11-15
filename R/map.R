library(tmap)
library(tmaptools)

data("Europe")
proj <- get_projection(Europe)

Europe2 <- Europe
get_proj4(3035)
Europe2 <- set_projection(Europe2, projection = "+wgs84")


tm_shape(europe_background) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts0) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(europe_background) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts1) +
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(europe_background) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts2) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 1, lwd=0.5, legend.show=FALSE
             )

tm_shape(europe_background) + 
  tm_polygons(border.col = "white", col = "gray95") +
  tm_shape(nuts3) + 
  tm_polygons( col = "NUTS_ID", border.col="white"
             , border.alpha = 0.5, lwd=0.5, legend.show=FALSE
             )
