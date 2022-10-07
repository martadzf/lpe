# ID SCRIPT ---------------------------------------------------------------


## LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO: MARTA DÍAZ, EXP 21936326
## HANDS ON 01



# SHORTCUTS ---------------------------------------------------------
## ctrl + l = clean console
## ctrl + shift + r = new section

# GIT COMMANDS ------------------------------------------------------------
# git status
# git init 
# git add
# git commit -m "message"
# git push -u origin main 
# git branch Emilia
# git merge
# git remote add origin https://github.com/martadzf/LPE21535220.git
# git clone https://github.com/martadzf/LPE21535220.git
# git pull
# git fetch



# TERMINAL COMANDS --------------------------------------------------------
# ls listar 
# cd meterte en sitios
# pwd para ver donde estas
# cd .. volver atras 
# mkdir crear directorio
# touch crear archivo
# nano
# less abrir archivos
# cat abrir archivo moviendo raton
# clear
# which

# LOADING LIBS ------------------------------------------------------------
install.packages(c("tidyverse", "httr"))
install.packages("httr")
install.packages("janitor")
install.packages("pacman")
install.packages("jsonlite")
library (tidyverse)
library(httr)
library(janitor)
library(pacman)
library(jsonlite)


# BASIC OPERATORS ---------------------------------------------------------
cristina <- 20
clase_lep <- c("marta", "emilia", "pablo")
url_ <- "https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
df <- GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
glimpse(df)
xml2::read_xml(df$content)

f_raw <- jsonlite::fromJSON(url_)
df_source <- f_raw$ListaEESSPrecio %>% glimpse()
janitor::clean_names(df_source) %>% glimpse()

#ver config
locale() 
#Cambaimos config
df1<-df_source %>% janitor::clean_names() %>% type_convert(locale = locale(decimal_mark = ","))


# CREATING A NEW VARIABLES ------------------------------------------------

##Clasificamos por gasolineras baratas y no baratas NUEVA COLUMNA
df_low <- df1 %>% mutate(lowcost =! rotulo %in% c("CEPSA", "REPSOL", "BP", "SHELL"))

##Precio medio del gasoleo en las CCAA
df_low %>% select(precio_gasoleo_a, idccaa, rotulo, lowcost) %>% drop_na() %>% group_by(idccaa, lowcost) %>% summarize(mean(precio_gasoleo_a)) %>% view()

##Columna nombre ccaa
df_low %>% mutate(ccaa = idccaa %in% c("01"=="ANDALUCIA","02"=="ARAGON", "03"=="ASTURIAS", "04"=="BALEARES", 
                                       "05"=="CANARIAS","06"=="CANTABRIA", "07"=="CASTILLA Y LEON", 
                                       "08"=="CASTILLA - LA MANCHA", "09"=="CATALUÑA", "10"=="COMUNIDAD VALENCIANA",
                                       "11"=="EXTREMADURA", "12"=="GALICIA", "13"=="MADRID", "14"=="MURCIA", "15"=="NAVARRA",
                                       "16"=="PAIS VASCO", "17"=="LA RIOJA","18"=="CEUTA","19"=="MELILLA"))

##Gasolinera más barata
  
# READING AND WRITING (FILES) ---------------------------------------------




