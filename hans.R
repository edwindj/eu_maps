library(sf)
library(tmap)
library(dplyr)

eu <- st_read("data-raw/europe_nuts0_MT.hans.json") %>%
  st_set_crs(3035) # set to European projection

eu %>% 
  st_set_geometry(NULL) %>% 
  write.csv2("data-raw/countries_h.csv", row.names = FALSE, na = "")

bb <- st_bbox(eu)

bb
# bb <- st_bbox(
#   eu %>% st_transform(4326)
# )
# 
# eu_wgs <- eu %>% st_transform(4326)
# 
# eu_wgs %>%
#   st_intersection(st_as_sfc(bb), .)
# 
# st_intersection()
# 
# bb %>%
#   round(1)
# 
# eu_nuts0 <- st_read("data/europe_nuts0_MT.geojson")
# library(mapview)
# mapview::mapview(eu_nuts0)
# 
# 
# plot(eu)
# st_crs(eu)


ne <- st_read("data-raw/ne_admin/ne_10m_admin_0_countries_lakes.shp")

ne2 <-
  ne %>% 
  st_transform(3035)  %>% 
  st_intersection(st_as_sfc(bb))

plot(ne2, max.plot = 1)

View(ne2)
