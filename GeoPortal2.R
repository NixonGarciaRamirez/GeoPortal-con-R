library(shiny)
library(leaflet)

# Cargar el shapefile
shp_path <- "D:/NIXON/MI MUNDO PROPIO/08 SIG/SHAPES UTILES PARA ANALISIS/MAPAS DE UBICACION/VALLE DE ABURRA/Valle de aburra.shp"
shp_data <- st_read(shp_path, quiet = T)

# Obtener los nombres de los atributos del shapefile
attribute_names <- names(shp_data)


#Interfaz grafica
ui <- fluidPage(
  titlePanel("Mapa Base con Esri World Imagery"),
  sidebarLayout(
    sidebarPanel(
      h3("Filtros"),
      selectInput("attribute", "Selecciona un atributo:", choices = attribute_names),
      uiOutput("value_ui"),
      actionButton("apply", "Aplicar Filtros")
    ),
    mainPanel(
      leafletOutput("map"),
      h3("Información Adicional"),
      verbatimTextOutput("info")
    )
  )
)

#Coneccion con los servidores 
server <- function(input, output, session) {
  
  
  observeEvent(input$attribute, {
    updateSelectInput(session, "value", choices = unique(shp_data[[input$attribute]]))
  })
  
  output$value_ui <- renderUI({
    selectInput("value", "Selecciona un valor:", choices = unique(shp_data[[input$attribute]]))
  })  
  #Filtro
  filtered_data <- reactive({
    req(input$attribute, input$value)
    shp_data %>% filter(!!sym(input$attribute) == input$value)
  })
  
  #Mapa
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addProviderTiles(providers$Esri.WorldImagery)%>%
      setView(lng = -75.45738, lat = 6.64972, zoom = 10) %>%
      addPolygons(data = shp_data, color = "blue", weight = 2, opacity = 1.0, fillOpacity = 0.5)
  })
  
  output$info <- renderPrint({
    paste("Atributo seleccionado:", input$attribute, "\nValor del atributo:", input$value)
  })
  
}

#Activacion de la app
shinyApp(ui, server)
