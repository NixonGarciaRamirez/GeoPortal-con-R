ui <- fluidPage(
  titlePanel("Vizualizadno a Bogota"),
  leafletOutput("mymap")
)

server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(lng = -74.0721, lat = 4.7110, popup = "Bogotá, Colombia")
  })
}

shinyApp(ui = ui, server = server)
