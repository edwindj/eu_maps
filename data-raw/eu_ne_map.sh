[ ! -e data-raw/ne_10m_admin_0_countries_lakes.zip ] &&
  curl -O http://naciscdn.org/naturalearth/10m/cultural/ne_10m_admin_0_countries_lakes.zip &&
  unzip -o data-raw/ne_10m_admin_0_countries_lakes.zip -d data-raw/ne_admin

rm -rf ../data
mkdir -p ./data

mapshaper -i data-raw/ne_admin/ne_10m_admin_0_countries_lakes.shp \
  -clip bbox=-170,-85,170,85 \
  -simplify 10% keep-shapes \
  -proj "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs" densify \
  -clip bbox=2500000,1400000,7350000,5750000 \
  -filter-fields ADMIN,ADM0_A3,ISO_A2 \
  -rename-fields statcode=ISO_A2,statname=ADMIN \
  -join data-raw/countries.csv keys=statcode,statcode \
  -o precision=1 data/europe_map.geojson

Rscript malta.R
mapshaper-gui data/europe_map.geojson &

#  -simplify 10% keep-shapes \
