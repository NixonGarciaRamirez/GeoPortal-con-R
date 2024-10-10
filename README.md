# GeoPortal en Shiny con Capas de Shapefiles y Filtros Dinámicos


Este proyecto consiste en la creación de un GeoPortal interactivo utilizando la librería **Shiny** en **R**. El portal permite cargar múltiples archivos **shapefile** y visualizar capas sobre un mapa base, generando filtros dinámicos basados en los atributos de los archivos cargados.

#### Funcionalidades principales:
1. **Visualización de Capas:** Se pueden cargar varias capas de archivos shapefile (.shp) por defecto, las cuales se despliegan automáticamente sobre un mapa base interactivo.
   
2. **Filtros Dinámicos:** El sistema identifica automáticamente los campos de la tabla de atributos de cada shapefile. Basado en esta información, genera filtros dinámicos, como menús desplegables, que permiten al usuario seleccionar valores específicos para visualizar en el mapa. Por ejemplo, si el shapefile contiene un campo `ID`, el usuario puede seleccionar un valor del campo para filtrar la capa correspondiente.

3. **Control de Capas:** El usuario puede encender o apagar las capas de shapefiles según sea necesario, lo que permite comparar y visualizar distintas capas superpuestas sobre el mapa base.

4. **Mapa Base Interactivo:** Se utiliza la librería **leaflet** para integrar un mapa base que soporta distintas fuentes, como **OpenStreetMap**. Esto proporciona una visualización cartográfica fluida y fácil de manipular.

#### Tecnologías empleadas:
- **Shiny**: Framework para la creación de aplicaciones web interactivas en R.
- **Leaflet**: Biblioteca para la visualización de mapas interactivos.
- **sf**: Librería para manejar datos geoespaciales en R.
  
#### Usos potenciales:
Este GeoPortal está diseñado para aplicaciones en análisis geoespacial, especialmente útil en estudios ambientales, urbanísticos o de ordenamiento territorial, donde se requiere la visualización y filtrado de múltiples capas de datos geográficos. Permite una manipulación eficiente y dinámica de los shapefiles, mejorando la experiencia del usuario y optimizando la toma de decisiones basada en datos espaciales.

Este proyecto puede ser expandido para incluir otros formatos de datos espaciales, análisis adicionales, o ser integrado con bases de datos espaciales remotas. 
