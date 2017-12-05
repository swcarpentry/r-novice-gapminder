---
title: Guardando datos
teaching: 10
exercises: 10
questions:
- "¿Cómo puedo guardar gráficas y datos creados en R"
objectives:
- "Ser capaz de guardar gráficas y datos desde R."
keypoints:
- "Guardar gráficas desde RStudio usando el botón de 'Export'."
- "Usar `write.table` para guardar datos tabulares."
source: Rmd
---


## Guardando gráficas

Ya has visto como guardar la más reciente gráfica que creaste en `ggplot2`
usando el comando `ggsave`. A manera de recuerdo:


~~~
ggsave("My_most_recent_plot.pdf")
~~~
{: .r}

Puedes guardar una gráfica desde Rstudio usando el botón de 'Export' en la
ventana de 'Plot'. Esto te dará la opción de guardarla como .pdf, .png, .jpg
u otros formatos de imágenes.

Algunas veces podrías querer guardar las gráficas sin primero desplegarlas
en la ventana de 'Plot'. Quizá quieras hace un documento pdf con varias
páginas: por ejemplo, cada una con una gráfica distinta. O quizá tu estás
iterando sobre distintos subconjuntos de un archivo, graficando los datos
de cada subconjunto y quieres guardar cada una de las gráficas, obviamente no
puedes detener la iteración en cada paso para dar clic en 'Export' para
cada una.

En este caso quieres usar un método más flexible. La función `pdf` crea un
nuevo dispositivo pdf. Puedes controlar el tamaño y la resolución usando
argumentos para esta función.


~~~
pdf("Life_Exp_vs_time.pdf", width=12, height=4)
ggplot(data=gapminder, aes(x=year, y=lifeExp, colour=country)) +
  geom_line() +
  theme(legend.position = "none")

# ¡Tienes que asegurarte de apagar el dispositivo pdf!

dev.off()
~~~
{: .r}

Abre este documento y echa un vistazo.

> ## Desafío 1
>
> Vuelve a escribir el comando 'pdf' para imprimir una segunda página en el
> pdf, mostrando una gráfica **facet** (sugerencia: usa `facet_grid`) de los
> mismos datos con un panel por continente.
> > ## Solution to challenge 1
> > ## Solución al desafío 1
> >
> >
> > ~~~
> > pdf("Life_Exp_vs_time.pdf", width = 12, height = 4)
> > > >
> > p <- ggplot(data = gapminder, aes(x = year, y = lifeExp, colour = country)) +
> >   geom_line() +
> >   theme(legend.position = "none")
> > > >
> > p + facet_grid(. ~continent)
> > > >
> > dev.off()
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


Los comandos `jpeg`, `png`, etc. son usados de manera similar para producir
documentos en los correspondientes formatos.

## Guardando datos

En algún momento, también querrás guardar datos desde R.

Podemos usar la función `write.table` para esto, esta es muy similar a la
función `read.table` que se presentó anteriormente.

Vamos a crear un **script** para limpiar datos, para este análisis, vamos a
enfocarnos solamente en los datos de **gapminder** para Australia:


~~~
aust_subset <- gapminder[gapminder$country == "Australia",]

write.table(aust_subset,
  file="cleaned-data/gapminder-aus.csv",
  sep=","
)
~~~
{: .r}

Ahora regresemos a la terminal para dar un vistazo a los datos para
asegurarnos que se vean bien:


~~~
head cleaned-data/gapminder-aus.csv
~~~
{: .r}




~~~
"country","year","pop","continent","lifeExp","gdpPercap"
"61","Australia",1952,8691212,"Oceania",69.12,10039.59564
"62","Australia",1957,9712569,"Oceania",70.33,10949.64959
"63","Australia",1962,10794968,"Oceania",70.93,12217.22686
"64","Australia",1967,11872264,"Oceania",71.1,14526.12465
"65","Australia",1972,13177000,"Oceania",71.93,16788.62948
"66","Australia",1977,14074100,"Oceania",73.49,18334.19751
"67","Australia",1982,15184200,"Oceania",74.74,19477.00928
"68","Australia",1987,16257249,"Oceania",76.32,21888.88903
"69","Australia",1992,17481977,"Oceania",77.56,23424.76683
~~~
{: .output}

Mmm, eso no era precisamente lo que queríamos. ¿De dónde vinieron todas
esas comillas?. También los números de línea no tienen ningún sentido.

Veamos el archivo de ayuda para investigar como podemos cambiar este
comportamiento.


~~~
?write.table
~~~
{: .r}

Por omisión los vectores **character** se ponen entre comillas cuando se
guarda en un archivo. También se guardan los nombres de los renglones y las
columnas.

Arreglemos esto:


~~~
write.table(
  gapminder[gapminder$country == "Australia",],
  file="cleaned-data/gapminder-aus.csv",
  sep=",", quote=FALSE, row.names=FALSE
)
~~~
{: .r}

Ahora echemos de nuevo un vistazo a los datos usando nuestras habilidades en
la terminal:


~~~
head cleaned-data/gapminder-aus.csv
~~~
{: .r}




~~~
country,year,pop,continent,lifeExp,gdpPercap
Australia,1952,8691212,Oceania,69.12,10039.59564
Australia,1957,9712569,Oceania,70.33,10949.64959
Australia,1962,10794968,Oceania,70.93,12217.22686
Australia,1967,11872264,Oceania,71.1,14526.12465
Australia,1972,13177000,Oceania,71.93,16788.62948
Australia,1977,14074100,Oceania,73.49,18334.19751
Australia,1982,15184200,Oceania,74.74,19477.00928
Australia,1987,16257249,Oceania,76.32,21888.88903
Australia,1992,17481977,Oceania,77.56,23424.76683
~~~
{: .output}

¡Esto se ve mejor!

> ## Desafío 2
>
> Escribe un **script** de limpieza de datos que filtre los datos de
> **gapminder** que fueron colectados desde 1990.
>
> Usa este **script** para guardar este nuevo subconjunto de datos en el
> directorio `cleaned-data`.
> > ## Solución al desafío 2
> >
> >
> > ~~~
> > write.table(
> >   gapminder[gapminder$year > 1990, ],
> >   file = "cleaned-data/gapminder-after1990.csv",
> >   sep = ",", quote = FALSE, row.names = FALSE
> > )
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


