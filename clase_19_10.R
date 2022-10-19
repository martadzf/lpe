options (max.print = 100000)
pacman::p_load(httr, tidyverse, leaflet, janitor, readr, sparklyr)
url <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
df <- httr::GET(url)

library(sparklyr)
library(dplyr)
library(tidyverse)
library(stringr)
library(janitor)
library(leaflet)
library(readr)
library(httr)

f_raw <- jsonlite::fromJSON(url)
df_source <- f_raw$ListaEESSPrecio %>% glimpse()

#Cambaimos config
dataset <- df_source %>% janitor::clean_names() %>% type_convert(locale = locale(decimal_mark = ","))

#Gasoleo A. Top 10 mas caras
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(10, precio_gasoleo_a) %>% 
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84,lat=~latitud, popup=~rotulo,label=~precio_gasoleo_a)
#Gasoleo A. Top 20 más baratas
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat =~latitud, popup =~rotulo, label =~precio_gasoleo_a)

#Gasoleo A. Top 20 más baratas Guadalajara
dataset %>%filter(provincia =='GUADALAJARA') %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84, lat =~latitud, popup =~rotulo, label =~precio_gasoleo_a)
