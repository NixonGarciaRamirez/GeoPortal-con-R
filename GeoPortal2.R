library(shiny)
library(shinyWidgets)
library(leaflet)
library(dplyr)
library(sf)
library(raster)

# Cargar el shapefile
shp_path <- "D:/NIXON/MI MUNDO PROPIO/08 SIG/SHAPES UTILES PARA ANALISIS/MAPAS DE UBICACION/VALLE DE ABURRA/Valle de aburra.shp"
shp_data <- st_read(shp_path)

# Obtener los nombres de los atributos del shapefile
attribute_names <- names(shp_data)

ui <- fluidPage(
  titlePanel("Mapa Base con Esri World Imagery"),
  sidebarLayout(
    sidebarPanel(
      h3("Filtros"),
      selectInput("attribute", "Selecciona un atributo:", choices = attribute_names, multiple = FALSE),
      uiOutput("value_ui"),
      actionButton("apply", "Aplicar Filtros"),
      br(), # Espacio adicional
      h3("Leyenda para el Atributo seleccionado Previamente"),
      uiOutput("legend_ui") # Usar renderUI correctamente para la leyenda
    ),
    mainPanel(
      leafletOutput("map"),
      h3("Información Adicional"),
      verbatimTextOutput("info")
    )
  )
)

server <- function(input, output, session) {
  
  # Observador para actualizar los valores cuando cambia el atributo seleccionado
  observeEvent(input$attribute, {
    updateSelectInput(session, "value", choices = unique(shp_data[[input$attribute]]))
  })
  
  # Renderizar la UI de los valores del atributo
  output$value_ui <- renderUI({
    selectInput("value", "Selecciona un valor:", choices = unique(shp_data[[input$attribute]]))
  })
  
  # Filtrar los datos según el atributo y valor seleccionados
  filtered_data <- reactive({
    req(input$attribute, input$value)
    shp_data[shp_data[[input$attribute]] == input$value, ]
  })
  
  # Crear una paleta de colores para la leyenda basada en el atributo seleccionado
  observeEvent(input$attribute, {
    unique_values <- unique(shp_data[[input$attribute]])
    pal <- colorFactor(palette = "Set1", domain = unique_values) # Paleta de colores
    
    # Crear la leyenda usando etiquetas de HTML
    legend_html <- paste(
      "<div style='line-height: 1.5;'>",
      paste0("<span style='background-color:", pal(unique_values), 
             ";width: 20px; height: 20px; display: inline-block; border: 1px solid black;'></span> ",
             unique_values, collapse = "<br/>"),
      "</div>"
    )
    
    # Insertar la leyenda en el UI
    output$legend_ui <- renderUI({
      HTML(legend_html)
    })
  })
  
  # Renderizar el mapa
  output$map <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      addProviderTiles(providers$Esri.WorldImagery) %>% 
      setView(lng = -75.45738, lat = 6.64972, zoom = 10) %>% 
      addPolygons(data = filtered_data(), color = "blue", weight = 2, opacity = 1.0, fillOpacity = 0.5)
  })
  
  # Mostrar la información adicional
  output$info <- renderPrint({
    paste("Atributo seleccionado:", input$attribute, "\nValor del atributo:", input$value)
  })
}

shinyApp(ui, server)



#Activacion de la app
shinyApp(ui, server)
