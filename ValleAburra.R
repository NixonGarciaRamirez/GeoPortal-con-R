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

opciones <- c("Medellin" = "001",
              "Barbosa" = "079",
              "Bello" = "088",
              "Caldas" = "129",
              "Copacabana" = "212",
              "Envigado" = "266",
              "Girardora" = "308",
              "Itagui" = "360",
              "La Estrella" = "380",
              "Sabaneta" = "631"
)


# UI: Generamos la interfaz de usuario 
ui <- fluidPage(
  selectInput(inputId = "selESTADO", label = "Seleccione el Municipio",
              choices = opciones), 
  textOutput("data"), 
  leafletOutput("leaflet")
)


# Funcion Server (el funcionamiento del programa)
server <- function(input, output){
  output$data <- renderText({
    print(paste0("Número de estado: ",input$selESTADO ))
  })
  
  # Rendereamos el texto
  output$leaflet <- renderLeaflet({
    mun_estado <- mun %>%
      filter(CVE_ENT == input$selESTADO)
    
    # Graficamos el mapa resultante
    leaflet(mun_estado) %>%
      addTiles() %>%
      addPolygons()
  })
  
}
