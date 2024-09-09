# Instalasion de librerias

install.packages(c("shiny", "leaflet", "sf", "raster", "tmap", "mapview"))

ui <- fluidPage(
   titlePanel("Geoportal Básico en R"),
   leafletOutput("mymap")
)
