# Definir la interfaz de usuario (UI)
ui <- fluidPage(
  # Título del GeoPortal
  titlePanel("GeoPortal con Mapas Base y Capas Shapefile/Raster para el proyecto de Corredores Biologicos"),
  
  # Diseño con panel lateral y panel principal
  sidebarLayout(
    sidebarPanel(
      h3("Opciones de Visualización"),
      
      # Selección del mapa base
      radioButtons("map_type", "Selecciona el tipo de mapa base:",
                   choices = c("OpenStreetMap" = "OSM",
                               "CartoDB Positron" = "CartoDB",
                               "Stamen Toner" = "StamenToner",
                               "Stamen Terrain" = "StamenTerrain",
                               "Esri World Imagery" = "Esri")),
      
      # Botón para cargar shapefile
      fileInput("shapefile", "Subir un Shapefile", 
                multiple = TRUE, 
                accept = c(".shp", ".dbf", ".shx", ".prj")),
      
      # Botón para cargar raster
      fileInput("rasterfile", "Subir un Raster (.tif)", 
                multiple = FALSE, 
                accept = c(".tif"))
    ),
    
    mainPanel(
      leafletOutput("mapa", height = "600px")
    )
  )
)

# Definir el servidor (Server)
server <- function(input, output, session) {
  
  # Función para cargar shapefile
  cargar_shapefile <- reactive({
    req(input$shapefile)
    
    # Obtener ruta de los archivos subidos
    shapefile_path <- input$shapefile$datapath
    shp_file <- shapefile_path[grep("\\.shp$", shapefile_path)]  # Solo archivo .shp
    
    # Cargar el shapefile usando sf
    shape <- st_read(shp_file)
    
    return(shape)
  })
  
  # Función para cargar raster
  cargar_raster <- reactive({
    req(input$rasterfile)
    
    # Obtener ruta del archivo raster
    raster_path <- input$rasterfile$datapath
    
    # Cargar el archivo raster usando la librería raster
    ras <- raster(raster_path)
    
    return(ras)
  })
  
  # Renderizar el mapa base en Leaflet
  output$mapa <- renderLeaflet({
    leaflet() %>%
      setView(lng = -74.0721, lat = 4.7110, zoom = 12)  # Centrado en Bogotá, Colombia
  })
  
  # Actualizar el mapa base dinámicamente
  observe({
    proxy <- leafletProxy("mapa")
    
    # Remover cualquier capa previa
    proxy %>% clearTiles()
    
    # Añadir la capa de mapa seleccionada
    if (input$map_type == "OSM") {
      proxy %>% addTiles()  # OpenStreetMap
    } else if (input$map_type == "CartoDB") {
      proxy %>% addProviderTiles(providers$CartoDB.Positron)
    } else if (input$map_type == "StamenToner") {
      proxy %>% addProviderTiles(providers$Stamen.Toner)
    } else if (input$map_type == "StamenTerrain") {
      proxy %>% addProviderTiles(providers$Stamen.Terrain)
    } else if (input$map_type == "Esri") {
      proxy %>% addProviderTiles(providers$Esri.WorldImagery)
    }
  })
  
  # Añadir shapefile al mapa
  observe({
    shape <- cargar_shapefile()
    req(shape)
    
    leafletProxy("mapa") %>%
      clearShapes() %>%  # Limpiar formas anteriores
      addPolygons(data = shape, color = "blue", weight = 2, fillOpacity = 0.5)
  })
  
  # Añadir raster al mapa
  observe({
    ras <- cargar_raster()
    req(ras)
    
    leafletProxy("mapa") %>%
      clearImages() %>%  # Limpiar imágenes anteriores
      addRasterImage(ras, opacity = 0.7)
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)
