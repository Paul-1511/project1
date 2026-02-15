################
#Autor: Pablo Méndez
################



#mandamos todos los datos crudos en el enviroment
library(haven)

data_2009 <- read_sav("def2009.sav")
data_2010 <- read_sav("def2010.sav")
data_2011 <- read_sav("def2011.sav")
data_2012 <- read_sav("def2012.sav")
data_2013 <- read_sav("def2013.sav")
data_2014 <- read_sav("def2014.sav")
data_2015 <- read_sav("def2015.sav")
data_2016 <- read_sav("def2016.sav")
data_2017 <- read_sav("def2017.sav")
data_2018 <- read_sav("def2018.sav")


#Creamos otra variable para añadir el año de cada archivo
library(dplyr)

data_2009$anio <- 2009
data_2010$anio <- 2010
data_2011$anio <- 2011
data_2012$anio <- 2012
data_2013$anio <- 2013
data_2014$anio <- 2014
data_2015$anio <- 2015
data_2016$anio <- 2016
data_2017$anio <- 2017
data_2018$anio <- 2018

#Unimos todos los datos utilizados, en esta caso del 2009 al 2019
datos <- bind_rows(data_2009, data_2010, data_2011, data_2012, data_2013, data_2014, data_2015, data_2016, data_2017, data_2018)

#vemos registros y variables
dim(datos)
#vemos qué variables son cuantitativas
str(datos)
#Se resumen las variables
summary(datos)

#para que el Edadif al 999 sea ignorado se limpia
datos$Edadif <- as.numeric(datos$Edadif)
datos$Edadif[datos$Edadif == 999] <- NA

#vemos estadísticas de edades
summary(datos$Edadif)
hist(datos$Edadif, breaks = 50)
boxplot(datos$Edadif)

shapiro.test(sample(datos$Edadif, 5000))

#Tomamos ahora las estadísticas de edades
datos$Sexo <- as.factor(datos$Sexo)
datos$Areag <- as.factor(datos$Areag)
datos$Getdif <- as.factor(datos$Getdif)
datos$Ecidif <- as.factor(datos$Ecidif)
#hacemos una tabla de datos de sexo
table(datos$Sexo)
prop.table(table(datos$Sexo))

#####Hacemos una tabla en el plot
library(ggplot2)
# Convertimos la tabla de frecuencia en un data frame
df_sexo <- as.data.frame(table(datos$Sexo))
names(df_sexo) <- c("Sexo", "Cantidad")

# Calculamos proporción en %
df_sexo$Porcentaje <- round(df_sexo$Cantidad / sum(df_sexo$Cantidad) * 100, 1)

# Graficar
ggplot(df_sexo, aes(x = Sexo, y = Cantidad, fill = Sexo)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(Cantidad, " (", Porcentaje, "%)")),
            vjust = -0.5, size = 5) +
  scale_x_discrete(labels = c("1" = "Hombres", "2" = "Mujeres")) +
  scale_fill_manual(values = c("lightblue", "pink")) +
  labs(title = "Distribución de Sexos",
       x = "Sexo",
       y = "Cantidad") +
  theme_minimal()
############

#Edad promedio por sexo
tapply(datos$Edadif, datos$Sexo, mean, na.rm=TRUE)
#grafica
library(dplyr)
library(ggplot2)

edad_sexo <- datos %>%
  group_by(Sexo) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))

ggplot(edad_sexo, aes(x = Sexo, y = edad_promedio)) +
  geom_col() +
  geom_text(aes(label = round(edad_promedio, 1)),
            vjust = -0.5) +
  labs(title = "Edad promedio por sexo",
       x = "Sexo",
       y = "Edad promedio")



#Defunciones por año
datos %>%
  group_by(anio) %>%
  summarise(total=n())
#grafica
def_anio <- datos %>%
  group_by(anio) %>%
  summarise(total = n())

ggplot(def_anio, aes(x = anio, y = total)) +
  geom_line() +
  geom_point() +
  labs(title = "Defunciones por año",
       x = "Año",
       y = "Total")


#Año + sexo
datos %>%
  group_by(anio, Sexo) %>%
  summarise(total=n())
#grafica
def_anio_sexo <- datos %>%
  group_by(anio, Sexo) %>%
  summarise(total = n())

ggplot(def_anio_sexo, aes(x = anio, y = total, color = Sexo)) +
  geom_line() +
  geom_point() +
  labs(title = "Defunciones por año y sexo",
       x = "Año",
       y = "Total")


#Edad promedio por año
datos %>%
  group_by(anio) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))
#grafica
edad_anio <- datos %>%
  group_by(anio) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))

ggplot(edad_anio, aes(x = anio, y = edad_promedio)) +
  geom_line() +
  geom_point() +
  labs(title = "Edad promedio por año",
       x = "Año",
       y = "Edad promedio")


#Edad promedio por año y sexo
datos %>%
  group_by(anio, Sexo) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))
#grafica
edad_anio_sexo <- datos %>%
  group_by(anio, Sexo) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))

ggplot(edad_anio_sexo, aes(x = anio, y = edad_promedio, color = Sexo)) +
  geom_line() +
  geom_point() +
  labs(title = "Edad promedio por año y sexo")


#Defunciones por area geografica
table(datos$Areag)
prop.table(table(datos$Areag))
#grafica
area_tab <- datos %>%
  count(Areag)

ggplot(area_tab, aes(x = Areag, y = n)) +
  geom_col() +
  labs(title = "Defunciones por área geográfica",
       x = "Área",
       y = "Total")

#Defunciones por grupo de edad
datos$grupo_edad <- cut(datos$Edadif,
                        breaks = c(0, 14, 29, 44, 59, 74, 89, 120),
                        include.lowest = TRUE)

table(datos$grupo_edad)
#grafica
datos$grupo_edad <- cut(datos$Edadif,
                        breaks = c(0,14,29,44,59,74,89,120),
                        include.lowest = TRUE)

grupo_tab <- datos %>%
  count(grupo_edad)

ggplot(grupo_tab, aes(x = grupo_edad, y = n)) +
  geom_col() +
  labs(title = "Defunciones por grupo de edad",
       x = "Grupo de edad",
       y = "Total")

#Sitio de ocurrencia
table(datos$Ocur)
prop.table(table(datos$Ocur))
#grafica
ocur_tab <- datos %>%
  count(Ocur)

ggplot(ocur_tab, aes(x = Ocur, y = n)) +
  geom_col() +
  labs(title = "Sitio de ocurrencia",
       x = "Sitio",
       y = "Total")

#Mandamos más datos al enviroment ##########################################
library(haven)
library(dplyr)
library(ggplot2)

data_2019 <- read_sav("def2019.sav")
data_2020 <- read_sav("def2020.sav")
data_2021 <- read_sav("def2021.sav")
data_2022 <- read_sav("def2022.sav")

data_2019$anio <- 2019
data_2020$anio <- 2020
data_2021$anio <- 2021
data_2022$anio <- 2022

datos2 <- bind_rows(data_2019, data_2020, data_2021, data_2022)

#vemos registros y variables
dim(datos2)
#vemos qué variables son cuantitativas
str(datos2)
#Se resumen las variables
summary(datos2)

#¿Las defunciones aumentan con el tiempo?
def_anio2 <- datos2 %>%
  group_by(anio) %>%
  summarise(total = n())
print(def_anio2)
#grafica
ggplot(def_anio2, aes(x = anio, y = total)) +
  geom_line() +
  geom_point() +
  labs(title = "Defunciones por año (2019–2022)",
       x = "Año",
       y = "Total")

#¿Mayor mortalidad en hombres?
table(datos2$Sexo)
prop.table(table(datos2$Sexo))

edad_sexo2 <- datos2 %>%
  group_by(Sexo) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))
#grafica
ggplot(edad_sexo2, aes(x = Sexo, y = edad_promedio)) +
  geom_col() +
  geom_text(aes(label = round(edad_promedio,1)), vjust = -0.5)


#¿Edad promedio aumenta con el tiempo?
edad_anio2 <- datos2 %>%
  group_by(anio) %>%
  summarise(edad_promedio = mean(Edadif, na.rm = TRUE))
#grafica
ggplot(edad_anio2, aes(x = anio, y = edad_promedio)) +
  geom_line() +
  geom_point()

#¿Defunciones se concentran en adultos mayores?
datos2$grupo_edad <- cut(datos2$Edadif,
                         breaks = c(0,14,29,44,59,74,89,120),
                         include.lowest = TRUE)
table(datos2$grupo_edad)
prop.table(table(datos2$grupo_edad))
#grafica
grupo_tab2 <- datos2 %>%
  count(grupo_edad)

ggplot(grupo_tab2, aes(x = grupo_edad, y = n)) +
  geom_col()

#Diferencias geográficas

datos2 <- datos2 %>%
  mutate(Tipo_Area = case_when(
    Depocu == 1 ~ "Altamente Urbano",
    Depocu %in% c(3, 5, 9) ~ "Urbano-Mixto",
    Depocu %in% c(2, 4, 6, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22) ~ "Mayormente Rural",
    TRUE ~ "Otro"
  ))
table(datos2$Tipo_Area)
prop.table(table(datos2$Tipo_Area))

table(datos2$Tipo_Area)

prop.table(table(datos2$Tipo_Area))

#grafica
area_tab2 <- datos2 %>%
  count(Tipo_Area)

ggplot(area_tab2, aes(x = Tipo_Area, y = n, fill = Tipo_Area)) +
  geom_col() +
  labs(title = "Defunciones según tipo de área (2019–2022)",
       x = "Tipo de Área",
       y = "Total de Defunciones") +
  theme_minimal()

#########Creación de base de resumen por departamento ##########
dep_cluster2 <- datos2 %>%
  group_by(Depocu) %>%
  summarise(
    total_def = n(),
    edad_prom = mean(Edadif, na.rm = TRUE),
    prop_hombres = mean(Sexo == "1")
  )
dep_cluster2

#escalamos datos
dep_scaled2 <- scale(dep_cluster2[, -1])

#método del codo
wss <- numeric(10)

for (k in 1:10) {
  wss[k] <- sum(kmeans(dep_scaled2, centers = k)$withinss)
}

plot(1:10, wss, type="b",
     xlab="Número de clusters",
     ylab="WSS")

#silueta
library(cluster)

modelo2 <- kmeans(dep_scaled2, centers = 3)

sil2 <- silhouette(modelo2$cluster, dist(dep_scaled2))

plot(sil2)

#Agregar cluster a tabla
dep_cluster2$cluster <- modelo2$cluster

#ver qué hay dentro de cada cluster
aggregate(. ~ cluster, dep_cluster2, mean)

