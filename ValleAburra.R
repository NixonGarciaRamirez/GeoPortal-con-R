#Leemos y filtramos el municipio
mun <- st_read("D:/NIXON/MI MUNDO PROPIO/08 SIG/SHAPES UTILES PARA ANALISIS/MAPAS DE UBICACION/VALLE DE ABURRA/Valle de aburra.shp", quiet = T)
# Filtramos los datos para que solo salga un estado
mun_estado <- mun %>%
  filter(MPIO_CCDGO == "001")

#Grafcamos los primeros resultados
# Graficamos el mapa resultante
leaflet(mun_estado) %>%
  addTiles() %>%
  addPolygons()
