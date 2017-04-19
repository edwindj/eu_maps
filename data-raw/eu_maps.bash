#curl -O http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_01M_SH.zip
#curl -O http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/CNTR_2014_03M_SH.zip

# unzip NUTS_2013_01M_SH.zip
# unzip CNTR_2014_03M_SH.zip

mapshaper -i NUTS_2013_01M_SH/data/NUTS_RG_01M_2013.shp \
 -proj "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs" densify \
 -clip bbox=2500000,1400000,7350000,5750000 \
 -simplify 10% \
 -split STAT_LEVL_ \
 -o nuts.shp


mapshaper -i CNTR_2014_03M_SH/Data/CNTR_RG_03M_2014.shp \
 -clip bbox=-65,-25,80,70 \
 -proj "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs" densify \
 -clip bbox=2500000,1400000,7350000,5750000 \
 -simplify 10% \
 -o country.shp

mapshaper -i nuts?.shp country.shp -o format=geojson

mapshaper-gui nuts?.shp
# rm -r NUTS_2013_01M_SH \
#       CNTR_2014_03M_SH