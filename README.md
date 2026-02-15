# Análisis Exploratorio de Defunciones en Guatemala (2009-2022)

![UVG Logo](https://upload.wikimedia.org/wikipedia/commons/9/93/Uvg_logo.jpg)
**Universidad del Valle de Guatemala (UVG)**  
**Facultad de Ingeniería**  
**Departamento de Ciencias de la Computación**  
**Curso: Minería de Ciencias de Datos (CC3074)**  
**Semestre II 2025-2026**  
**Autor:** Pablo José Méndez Alvarado  
**Fecha:** 14 de febrero de 2026

## Descripción del Proyecto

Este repositorio contiene el código fuente y documentación del **Proyecto 1: Análisis Exploratorio** realizado como parte de la asignatura de Minería de Ciencias de Datos en la UVG. El objetivo principal es explorar y analizar los patrones de mortalidad en Guatemala utilizando datos oficiales de defunciones del **Instituto Nacional de Estadística (INE)**, cubriendo el período 2009-2022.

Se investigan tendencias temporales, diferencias por sexo, edad, área geográfica (urbana/rural) y agrupamiento departamental (clustering), con énfasis en validar supuestos iniciales y generar preguntas de investigación basadas en los datos.

**Datos fuente:** Bases de defunciones anuales en formato .sav (INE Guatemala) → [https://www.ine.gob.gt/ine/vitales/](https://www.ine.gob.gt/ine/vitales/)

**Enfoque principal:** Análisis descriptivo, visualización, pruebas de normalidad, tablas de frecuencia, series temporales y clustering (k-means con método del codo y silueta).

## Hallazgos Principales

- Mayor proporción de defunciones en **hombres** (≈56.5%) vs. mujeres (≈43.5%).
- Edad promedio de defunción: **hombres ≈49-50 años**, **mujeres ≈56 años**.
- Tendencia al aumento de defunciones entre 2009-2018, con pico notable en 2020-2021 (posible impacto COVID-19).
- Concentración en **adultos mayores** (>60 años ≈57%).
- Diferencias geográficas: mayor proporción en áreas **mayormente rurales** (≈56%) en 2019-2022.
- Clustering departamental identifica 3 grupos:  
  - **Cluster 1**: Departamentos pequeños con población envejecida.  
  - **Cluster 2**: Departamento metropolitano outlier (Guatemala).  
  - **Cluster 3**: Departamentos medianos con población relativamente más joven.

**Nota:** Los datos crudos (.sav) no se incluyen en el repositorio por restricciones de tamaño y políticas del INE. Descárgalos manualmente desde: https://www.ine.gob.gt/ine/vitales/ (archivos def2009.sav a def2022.sav).

## Requisitos

- **R** ≥ 4.0
- **RStudio** (recomendado)
- Paquetes utilizados (instálalos con `install.packages()` si es necesario):

```r
install.packages(c("haven", "dplyr", "ggplot2", "cluster"))

## Estructura del Repositorio
```
## Cómo ejecutar el proyecto
1. Clona este repositorio
```
git clone https://github.com/Paul-1511/project1.git
cd project-defunciones-gt
```
2. Descarga los archivos .sav del INE y colócalos en una carpeta data/ (o ajusta las rutas en el script).
3. Abre `project.R` en RStudio.
4. Ejecuta el script completo (o sección por sección). El análisis incluye:
- Unión de bases 2009-2022
- Limpieza (NA en Edadif=999)
- Estadísticas descriptivas y gráficos
- Clustering por departamento (2019-2022)
