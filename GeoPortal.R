# Define la ruta de tu archivo shapefile (incluyendo todos los archivos asociados)
shapefile_path <- "D:/NIXON/MI MUNDO PROPIO/08 SIG/R CON GEE/GeoPortal/SHP/CORREDORES2.shp"

# Definir la interfaz de usuario
ui <- fluidPage(
  titlePanel("GeoPortal"),
  leafletOutput("mapa") # Salida del mapa
)

# Definir el servidor
server <- function(input, output, session) {
  
  # Cargar el shapefile directamente desde el código
  cargar_shapefile <- reactive({
    shape <- st_read(shapefile_path)  # Cargar shapefile desde la ruta
    return(shape)
  })
  
  # Crear el mapa base
  output$mapa <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -75.45738, lat =6.64972, zoom = 12)
  })
  
  # Añadir el shapefile al mapa
  observe({
    shape <- cargar_shapefile()
    req(shape)  # Asegurarse de que el shapefile está cargado
    
    leafletProxy("mapa") %>%
      clearShapes() %>%
      addPolylines(data = shape, color = "blue", weight = 2, fillOpacity = 0.5)
  })
}

# Ejecutar la aplicación
shinyApp(ui, server)

