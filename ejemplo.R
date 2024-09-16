# Este ejemplo lo que hara es que escribas una palabra, y que despues la puedas volver a vizualizar de nuevo


# Definir la interfaz de usuario (UI)
ui <- fluidPage(
  # Título del GeoPortal
  titlePanel("GeoPortal"),
  
  # Diseño con panel lateral y panel principal
  sidebarLayout(
    # Panel lateral con un simple texto de ejemplo
    sidebarPanel(
      h3("Panel de Opciones"),
      # Aquí podrías añadir inputs adicionales, como sliders, selectores, etc.
      textInput("texto", "Escribe algo:", "Texto de ejemplo")
    ),
    
    # Panel principal para mostrar la salida
    mainPanel(
      h3("Visualización de Resultados"),
      textOutput("salidaTexto")
    )
  )
)

# Definir el servidor (Server)
server <- function(input, output) {
  # Mostrar el texto ingresado por el usuario
  output$salidaTexto <- renderText({
    paste("Has escrito:", input$texto)
  })
}

# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)
