---
title: "Explorando Data Frames"
teaching: 20
exercises: 10
questions:
- "�c�mo puedo manipular un *dataframe*?"
objectives:
- "Poder agregar y quitar filas y columnas."
- "Poder quitar filas con valores `NA`."
- "Poder anexar dos *dataframe*."
- "Poder articular qu� es un `factor` y c�mo convertir entre `factor` y `character`."
- "Poder entender las propiedades b�sicas de un *dataframe*, incluyendo tama�o, clase o tipo de columnas, nombres y primeras filas."
keypoints:
- "Usar `cbind()` para agregar una nueva columna a un *dataframe*."
- "Usar `rbind()` para agregar una nueva fila a un *dataframe*."
- "Quitar filas de un *dataframe*."
- "Usar `na.omit()` para remover filas de un *dataframe* con valores `NA`."
- "Usar `levels()` y `as.character()` para explorar y manipular columnas de clase *factor*"
- "Usar `str()`, `nrow()`, `ncol()`, `dim()`, `colnames()`, `rownames()`, `head()` y `typeof()` para entender la estructura de un *dataframe*"
- "Leer un archivo csv usando `read.csv()`"
- "Entender el uso de `length()` en un *dataframe*"
source: Rmd
---
  
  A esta altura, tu has visto todo - en la �ltima lecci�n, recorrimos las estructuras b�sicas de R. Todo lo que hagas va a ser una manipulaci�n de esas herramientas. Pero la mayor�a del tiempo, la estrella del show va a ser el *dataframe* - la tabla que creamos al cargar informaci�n de un archivo csv. En �sta lecci�n, vamos a aprender un par de cosas sobre c�mo trabajar con la clase *dataframe*.
  

## Agregando columnas y filas a un dataframe

Aprendimos que las columnas en un *dataframe* son vectores. Por lo tanto, sabemos que nuestros datos son consistentes en el tipo dentro de la columna. Si queremos agregar una nueva columna, podemos empezar por crear un nuevo vector:


~~~
  age <- c(2,3,5,12)
cats

~~~
{: .r}




We can then add this as a column via:
  
  
  ~~~
  cats <- cbind(cats, age)
~~~
{: .r}



~~~
  Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4
~~~
{: .error}

�Por qu� no funcion�? Claro, R quiere ver un elemento en nuestra nueva columna para cada fila de la tabla:

~~~
cats
~~~
{: .r}



~~~
coat weight likes_string
1 calico    2.1            1
2  black    5.0            0
3  tabby    3.2            1
~~~
{: .output}



~~~
age <- c(4,5,8)
cats <- cbind(cats, age)
cats
~~~
{: .r}



~~~
coat weight likes_string age
1 calico    2.1            1   4
2  black    5.0            0   5
3  tabby    3.2            1   8
~~~
{: .output}

Ahora, qu� tal si agregamos filas, en este caso, la �ltima vez vimos que las filas de un *dataframe* est�n compuestas por listas:

~~~
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
~~~
{: .r}



~~~
Warning in `[<-.factor`(`*tmp*`, ri, value = "tortoiseshell"): invalid
factor level, NA generated
~~~
{: .error}

## Factors

Los objetos de la clase *factor* son otra cosa con la que debemos tomar cuidado. Cuando R crea un *factor*, �nicamente permite aquello que originalmente estaba all� cuando cargamos los datos. En este caso fue
'black', 'calico' y 'tabby'. Cualquier cosa nueva que no entre en esas categor�as es rechazado (y se convierte en NA).

La advertencia (*warning*) nos est� diciendo que agregamos'tortoiseshell' a nuestro factor
*coat*, pero 3.3 (de tipo *numeric*), TRUE (de tipo *logical*), y 9 (de tipo *numeric*) se a�adieron exitosamente a *weight*, *likes_string*, y *age*, respectivamente, dado que esos valores no son de tipo *factor*. Para a�adir un elemento 'tortoiseshell' al *dataframe* en la columna *coat*, debemos agregar expl�citamente a 'tortoiseshell' como un nivel (*level*) en el factor:
  
  
  ~~~
  levels(cats$coat)
~~~
{: .r}



~~~
  [1] "black"  "calico" "tabby" 
~~~
{: .output}



~~~
  levels(cats$coat) <- c(levels(cats$coat), 'tortoiseshell')
cats <- rbind(cats, list("tortoiseshell", 3.3, TRUE, 9))
~~~
{: .r}

De manera alternativa, podemos cambiar la columna a tipo *character*. En este caso, perdemos las categor�as, que bien pueden ser �tiles, pero a partir de ahora podemos incorporar cualquier palabra a la columna, sin enriedos con los niveles del factor. 
  
  
  ~~~
  str(cats)
~~~
{: .r}



~~~
  'data.frame':	5 obs. of  4 variables:
  $ coat        : Factor w/ 4 levels "black","calico",..: 2 1 3 NA 4
$ weight      : num  2.1 5 3.2 3.3 3.3
$ likes_string: int  1 0 1 1 1
$ age         : num  4 5 8 9 9
~~~
{: .output}



~~~
  cats$coat <- as.character(cats$coat)
str(cats)
~~~
{: .r}



~~~
  'data.frame':	5 obs. of  4 variables:
  $ coat        : chr  "calico" "black" "tabby" NA ...
$ weight      : num  2.1 5 3.2 3.3 3.3
$ likes_string: int  1 0 1 1 1
$ age         : num  4 5 8 9 9
~~~
{: .output}

> ## Desaf�o 1
  > Imaginemos que, como los perros, 1 a�o humano es equivalente a 7 a�os en los gatos (La compa��a Purina usa [un algoritmo m�s sofisticado](https://www.proplan.com/cats/cat-age-calculator)). 
> 1. Crea un vector llamado `human.age` multiplicando `cats$age` por 7.
> 2. Convierte `human.age` a *factor*.
> 3. Convierte `human.age` de nuevo a un vector num�rico usando la funci�n `as.numeric()`. Ahora, divide por 7 para regresar a las edades originales. Explica lo sucedido. 
>
> > ## Soluci�n al Desaf�o 1
> > 1. `human.age <- cats$age * 7`
> > 2. `human.age <- factor(human.age)`. `as.factor(human.age)` funciona igual de bien.
> > 3. `as.numeric(human.age)` produce `1 2 3 4 4` porque los factores se guardan como objetos de tipo *integer* (aqu�, 1:4), cada uno de los cuales tiene asociado una etiqueta o *label* (aqu�, 28, 35, 56, y 63). Convertir un objeto de tipo *factor* a *numeric* nos da los enteros, no los *labels*. Si queremos los n�meros originales, debemos convertir `human.age` al tipo *character* y luego a *numeric* (�c�mo funciona esto?). Esto aparece en la vida real cuando accidentalmente incluimos un *character* en alg�n sitio, como en la columna de un archivo .csv, que se supon�a que �nicamente contendr�a n�meros y olvidamos incluir  `stringsAsFactors=FALSE` al leer la tabla.
> {: .solution}
{: .challenge}

## Quitando filas

Ahora sabemos c�mo agregar filas y columnas a nuestro *dataframe* en R pero en nuestro primer intento para agregar un gato llamado 'tortoiseshell' agregamos una fila basura.
  
  
  ~~~
  cats
~~~
{: .r}



~~~
  coat weight likes_string age
1        calico    2.1            1   4
2         black    5.0            0   5
3         tabby    3.2            1   8
4          <NA>    3.3            1   9
5 tortoiseshell    3.3            1   9
~~~
{: .output}

Podemos pedir el *dataframe* sin la fila err�nea: 
  
  ~~~
  cats[-4,]
~~~
{: .r}



~~~
  coat weight likes_string age
1        calico    2.1            1   4
2         black    5.0            0   5
3         tabby    3.2            1   8
5 tortoiseshell    3.3            1   9
~~~
{: .output}

Notar que la coma sin nada detr�s indica que queremos remover la cuarta fila entera. Podr�amos remover ambas filas en un llamado usando ambos n�meros dentro de un vector: `cats[c(-4,-5),]`

Alternativamente, podemos eliminar filas que contengan valores `NA`:
  
  
  ~~~
  na.omit(cats)
~~~
{: .r}



~~~
  coat weight likes_string age
1        calico    2.1            1   4
2         black    5.0            0   5
3         tabby    3.2            1   8
5 tortoiseshell    3.3            1   9
~~~
{: .output}

Volvamos a asignar el *output* a `cats`, as� nuestros cambios son permanentes:


~~~
cats <- na.omit(cats)
~~~
{: .r}

## A�adiendo a un dataframe

La clave que hay que recordar al a�adir datos a un *dataframe* es que *las columnas son vectores o factores, mientras que las filas son listas.* Podemos pegar dos *dataframes* juntos usando `rbind`:


~~~
cats <- rbind(cats, cats)
cats
~~~
{: .r}



~~~
coat weight likes_string age
1         calico    2.1            1   4
2          black    5.0            0   5
3          tabby    3.2            1   8
5  tortoiseshell    3.3            1   9
11        calico    2.1            1   4
21         black    5.0            0   5
31         tabby    3.2            1   8
51 tortoiseshell    3.3            1   9
~~~
{: .output}

Pero ahora los nombres de las filas son complicados. Podemos removerlos y R los nombrar� nuevamente, de manera secuencial:

~~~
rownames(cats) <- NULL
cats
~~~
{: .r}



~~~
coat weight likes_string age
1        calico    2.1            1   4
2         black    5.0            0   5
3         tabby    3.2            1   8
4 tortoiseshell    3.3            1   9
5        calico    2.1            1   4
6         black    5.0            0   5
7         tabby    3.2            1   8
8 tortoiseshell    3.3            1   9
~~~
{: .output}

> ## Desaf�o 2
>
> Puedes crear un nuevo dataframe desde R con la siguiente sintaxis:
> 
> ~~~
> df <- data.frame(id = c('a', 'b', 'c'),
>                  x = 1:3,
>                  y = c(TRUE, TRUE, FALSE),
>                  stringsAsFactors = FALSE)
> ~~~
> {: .r}
> Crear un dataframe que contenga la siguiente informaci�n personal:
>
> - Nombre
> - Apellido
> - N�mero favorito
>
> Luego usa `rbind` para agregar una entrada para la gente sentada alrededor tuyo.
> Finalmente, usa `cbind` para agregar una columna con espacio para que cada persona conteste a la siguiente pregunta: "�Es hora de un recreo?"
>
  > > ## Soluci�n al Desaf�o 2
  > > 
  > > ~~~
  > > df <- data.frame(nombre = c('Grace'),
                       > >                  apellido = c('Hopper'),
                       > >                  numero = c(0),
                       > >                  stringsAsFactors = FALSE)
> > df <- rbind(df, list('Marie', 'Curie', 238) )
> > df <- cbind(df, recreo = c(TRUE,TRUE))
> > ~~~
  > > {: .r}
> {: .solution}
{: .challenge}

## Ejemplo realista

Hasta ahora, hemos visto las manipulaciones b�sicas que pueden hacerse en un *dataframe*. Ahora, vamos a extender esas habilidades. 


~~~
gapminder <- read.csv("data/gapminder-FiveYearData.csv")
~~~
{: .r}

> ## Tips
>
> * Otro tipo de archivo que puedes encontrar es el separado por tabuladores (.tsv). Para especificar este separador, usa `"\\t"` o `read.delim()`.
>
> * Los archivos pueden descargarse de Internet a una carpeta local usando `download.file`.
> La funci�n `read.csv` puede ser ejecutada para leer el archivo descargado, por ejemplo: > 
> ~~~
> download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
> gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> ~~~
> {: .r}
>
> *De manera alternativa, puedes leer los archivos directamente en R, usando una direcci�n web y `read.csv`. Es importante notar que, si se hace esto �ltimo, no habr� una copia local del archivo csv. Por ejemplo,
> 
> ~~~
> gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
> ~~~
> {: .r}
>
> * Puedes leer directamente planillas de Excel sin necesidad de convertirlas a texto plano usando el paquete [readxl](https://cran.r-project.org/web/packages/readxl/index.html).
{: .callout}

Vamos a investigar gapminder un poco; lo primero que hay que hacer siempre es ver c�mo se ve el dataset usando `str`:
  
  
  ~~~
  str(gapminder)
~~~
{: .r}



~~~
  'data.frame':	1704 obs. of  6 variables:
  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
$ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
$ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
$ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
$ lifeExp  : num  28.8 30.3 32 34 36.1 ...
$ gdpPercap: num  779 821 853 836 740 ...
~~~
{: .output}

Tambi�n podemos examinar columnas individuales del dataframe con la funci�n `typeof`:
  
  
  ~~~
  typeof(gapminder$year)
~~~
{: .r}



~~~
  [1] "integer"
~~~
{: .output}



~~~
  typeof(gapminder$country)
~~~
{: .r}



~~~
  [1] "integer"
~~~
{: .output}



~~~
  str(gapminder$country)
~~~
{: .r}



~~~
  Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
~~~
{: .output}


Tambi�n podemos interrogar al dataframe por informaci�n sobre sus dimensiones;
recordando que `str(gapminder)` dijo que hab�a 1704 observaciones de 6 variables en gapminder, �Qu� pisnsas que el siguiente c�digo producir� y por qu�?

~~~
  length(gapminder)
~~~
{: .r}



~~~
  [1] 6
~~~
{: .output}

Un intento certero hubiera sido decir que el largo (`length`) de un *dataframe* es el n�mero de filas (1704), pero no es el caso; recuerda, un *dataframe es una lista de vectores y factors*. 

  ~~~
  typeof(gapminder)
~~~
{: .r}



~~~
  [1] "list"
~~~
{: .output}

Cuando `length` devuelve 6, es porque gapminder est� construida por una lista de 6 columnas. Para conseguir el n�mero de filas, intenta:

~~~
nrow(gapminder)
~~~
{: .r}


~~~
[1] 1704
~~~
{: .output}



~~~
ncol(gapminder)
~~~
{: .r}



~~~
[1] 6
~~~
{: .output}

O, ambos de una vez:


~~~
dim(gapminder)
~~~
{: .r}



~~~
[1] 1704    6
~~~
{: .output}


Probablemente queremos saber los nombres de las columnas. Para hacerlo, podemos pedir: 
  
  ~~~
  colnames(gapminder)
~~~
{: .r}



~~~
  [1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"
~~~
{: .output}

A esta altura, es importante preguntarnos si la estructura de R est� en sinton�a con nuestra intuici�n y nuestras expectativas, �tienen sentido los tipos de datos reportados para cada columna? Si no lo tienen, necesitamos resolver cualquier problema antes de que se conviertan en sorpresas ingratas luego. Podemos hacerlo usando lo que aprendimos sobre c�mo R interpreta los datos y la importancia de la estricta consistencia con la que registramos los datos.

Una vez que estamos contentos con el tipo de datos y que la estructura parece razonable, es tiempo de empezar a investigar nuestros datos. Mira las siguientes l�neas:
  
  
  ~~~
  head(gapminder)
~~~
{: .r}



~~~
  country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~
{: .output}

Para hacer el an�lisis reproducible, deber�amos poner el c�digo en un *script*, as� podremos volver luego a �l. 

> ## Desaf�p 3
  >
  > Ve a Archivo -> nuevo -> R script, and escribe un script de R 
> para cargar el dataset gapminder. Ponlo en el directorio `scripts/`
> y agr�galo al control de versiones.
>
  > Ejecuta el script usando la funci�n `source`, usando el path como su argumento
> o apretando el bot�n de "source" en Rstudio.
>
  > > ## Soluci�n al Desaf�o 3
  > > Los contenidos de `script/load-gapminder.R`:
  > > 
  > > ~~~
  > > download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
> > gapminder <- read.csv(file = "data/gapminder-FiveYearData.csv")
> > ~~~
  > > {: .r}
> > Para ejecutar el script y cargar los archivos en la variable `gapminder`:
  > > 
  > > ~~~
  > > source(file = "scripts/load-gapminder.R")
> > ~~~
  > > {: .r}
> {: .solution}
{: .challenge}

> ## Desaf�o 4
  >
  > Leer el output de `str(gapminder)` de nuevo;
> esta vez, usar lo que has aprendido de factores, listas y vectores, las funciones como `colnames` y `dim`
> para explicar qu� significa el output de `str`.
> Si hay partes que no puedes entender, disc�telo con tus compa�eros. 
  >
  > > ## Solution to Desaf�o 4
  > >
  > > El objeto `gapminder` es un dataframe con columnas
> > - `country` y `continent` como *factors*.
> > - `year` como *integer vector*.
> > - `pop`, `lifeExp`, and `gdpPercap` como *numeric vectors*.
> >
  > {: .solution}
{: .challenge}