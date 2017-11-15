
[ ! -e NUTS_2013_01M_SH.zip ] &&
  curl -O http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_01M_SH.zip &&
  unzip -o NUTS_2013_01M_SH.zip
  
[ ! -e CNTR_2014_03M_SH.zip ] &&
  curl -O http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/CNTR_2014_03M_SH.zip &&
  unzip -o CNTR_2014_03M_SH.zip

rm -r ../data
mkdir ../data


mapshaper -i NUTS_2013_01M_SH/data/NUTS_RG_01M_2013.shp \
 -join NUTS_2013_01M_SH/data/NUTS_AT_2013.csv encoding=win1252 keys=NUTS_ID,NUTS_ID fields=NUTS_ID,NUTS_NAME \
 -proj "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs" densify \
 -clip bbox=2500000,1400000,7350000,5750000 \
 -simplify 2.5% keep-shapes \
 -split STAT_LEVL_ \
 -filter-fields NUTS_ID,NUTS_NAME \
 -o ../data/europe_nuts.geojson
# -o ../data/europe_nuts.shp

mapshaper -i CNTR_2014_03M_SH/Data/CNTR_RG_03M_2014.shp \
 -clip bbox=-65,-25,80,70 \
 -proj "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs" densify \
 -clip bbox=2500000,1400000,7350000,5750000 \
 -simplify 2.5% keep-shapes \
 -o ../data/europe_background.geojson\

cd ../data
# nuts levels are numbered incorrectly so fix that!
rename s/nuts1/nuts0/ europe_nuts1.*
rename s/nuts2/nuts1/ europe_nuts2.*
rename s/nuts3/nuts2/ europe_nuts3.*
rename s/nuts4/nuts3/ europe_nuts4.*
cd ../data-raw

# save the projections
r ../R/set_projection.R

mapshaper -i ../data/europe_nuts?.geojson ../data/europe_background.geojson -o ../data format=topojson extension=topojson
mapshaper -i ../data/*.geojson -o ../data format=shapefile

mapshaper ../data/europe_nuts0.geojson -info

# rm -r NUTS_2013_01M_SH \
#       CNTR_2014_03M_SH
