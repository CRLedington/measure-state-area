set data=c:\CRL-GIS\data\ne_10m_admin_1_states_provinces_lakes.shp
set states='Texas','Alaska','Kentucky'
set units=sq_mi
set factor=2.59e+6
set output=area.csv

rem Create projected Shapefile
ogr2ogr projected.shp -sql ^
 "select name from ne_10m_admin_1_states_provinces_lakes where name in (%states%)" ^
 -s_srs EPSG:4326 -t_srs EPSG:5070 ^
 %data%

rem Use ogr2ogr internal measurement feature
ogr2ogr output.csv -sql ^
 "select name, (ogr_geom_area/%factor%) as %units% from projected" ^
 projected.shp

rem Delete intermediate files
del projected.*