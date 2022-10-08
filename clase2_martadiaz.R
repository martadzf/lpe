## LENGUAJES DE PROGRAMACIÓN ESTADÍSTICA
## PROFESOR: CHRISTIAN SUCUZHANAY AREVALO
## ALUMNO: MARTA DÍAZ, EXP 21936326
## HANDS ON 02



# CARGA DE LIBRERÍAS ------------------------------------------------------
library (tidyverse)
library(httr)
library(janitor)
library(pacman)

# CARGA DE DATOS POD 1 -------------------------------------------------------------
police <- read_csv("police.csv")
glimpse(police)