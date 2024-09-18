# Definir la interfaz de usuario (UI)
ui <- fluidPage(
  # Título del GeoPortal
  titlePanel("GeoPortal con Google Maps"),
  
  # Diseño con panel lateral y panel principal
  sidebarLayout(
    # Panel lateral con un simple texto de ejemplo
    sidebarPanel(
      h3("Panel de Opciones")
    ),
    
    # Panel principal para mostrar el mapa
    mainPanel(
      leafletOutput("mapa")
    )
  )
)

# Definir el servidor (Server)
server <- function(input, output) {
  output$mapa <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%  # Capa de OpenStreetMap (default)
      addProviderTiles("Google", options = providerTileOptions(apikey = "TU_API_KEY")) %>%
      setView(lng = -74.0721, lat = 4.7110, zoom = 12)  # Centrado en Bogotá, Colombia
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)
