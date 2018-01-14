---
title: Manipulación de **Dataframes** con dplyr
teaching: 40
exercises: 15
questions:
- "Cómo manipular **dataframes** sin repetir lo mismo una y otra vez."
objectives:
- "Ser capaces de usar las seis principales acciones de manipulación de **dataframes** con **pipes** en `dplyr`."
- "Comprender cómo combinar `group_by()` y `summarize()` para obtener resúmenes de **datasets**."
- "Ser capaces de analizar un subconjunto de datos usando un filtrado lógico."
keypoints:
- "Usar el paquete `dplyr` para manipular **dataframes**."
- "Usar `select()` para seleccionar variables de un **dataframe**."
- "Usar `filter()` para seleccionar datos basándose en los valores."
- "Usar `group_by()` y `summarize()` para trabajar con subconjuntos de datos."
- "Usar `mutate()` para crear nuevas variables."
source: Rmd
---


La manipulación de **dataframes** significa distintas cosas para distintos investigadores. A veces podemos querer seleccionar ciertas observaciones (filas) o variables (columnas), otras deseamos agrupar los datos en función de una o más variables, o podemos querer calcular valores estadísticos del conjunto. Podemos hacer todo ello usando las habituales operaciones básicas de R:


~~~
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])
~~~
{: .r}



~~~
[1] 2193.755
~~~
{: .output}



~~~
mean(gapminder[gapminder$continent == "Americas", "gdpPercap"])
~~~
{: .r}



~~~
[1] 7136.11
~~~
{: .output}



~~~
mean(gapminder[gapminder$continent == "Asia", "gdpPercap"])
~~~
{: .r}



~~~
[1] 7902.15
~~~
{: .output}

Pero esto no es muy elegante porque hay demasiada repetición. Repetir cosas cuesta un tiempo, tanto en el momento de hacerlo como en el futuro, y aumenta la probabilidad de que se produzcan desagradables errores.

## El paquete `dplyr`

Afortunadamente, el paquete [`dplyr`](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) proporciona un conjunto de funciones extremadamente útiles para manipular **dataframes** y así reducir el número de repeticiones, la probabilidad de cometer errores y el número de caracteres que hay que escribir. Como valor extra, puedes encontrar que la gramática de `dplyr` es más fácil de entender.

Aquí vamos a revisar 6 de sus funciones más usadas, así como a usar **pipes** para combinarlas.

1. `select()`
2. `filter()`
3. `group_by()`
4. `summarize()`
5. `mutate()`

Si no has instalado antes este paquete, hazlo del siguiente modo:

~~~
install.packages('dplyr')
~~~
{: .r}


Ahora vamos a cargar el paquete:

~~~
library("dplyr")
~~~
{: .r}

## Usando select()

Si por ejemplo queremos continuar el trabajo con sólo unas pocas de las variables de nuestro **dataframe** podemos usar la función `select()`. Esto guardará sólo las variables que seleccionemos.

~~~
year_country_gdp <- select(gapminder,year,country,gdpPercap)
~~~
{: .r}

![](../fig/13-dplyr-fig1.png)

Si ahora investigamos `year_country_gdp` veremos que sólo contiene el año, el país y la renta per cápita. Arriba hemos usado la gramática 'normal', pero la fortaleza de `dplyr` consiste en combinar funciones usando **pipes**. Como la gramática de las **pipes** es distinta a todo lo que hemos visto antes en R, repitamos lo que hemos hecho arriba, pero esta vez usando **pipes**.

~~~
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)
~~~
{: .r}

Para ayudarte a entender por qué lo hemos escrito así, vamos a revisarlo por partes. Primero hemos llamado al **dataframe** "gapminder" y se lo hemos pasado al siguiente paso, que es la función `select()`, usando el símbolo de la **pipe** `%>%`. En este caso no especificamos qué objeto con datos vamos a usar en la función `select()` porque esta lo recibe de la **pipe** previa. **Dato curioso:** es muy posible que te hayas encontrado con **pipes** antes en la terminal. En R el símbolo de la **pipe** es `%>%`, mientras que en la terminal es `|`, pero el concepto es el mismo.

## Usando filter()

Si ahora quermos continuar con lo de arriba, pero sólo con los países europeos, podemos combinar `select` y `filter`.

~~~
year_country_gdp_euro <- gapminder %>%
    filter(continent=="Europe") %>%
    select(year,country,gdpPercap)
~~~
{: .r}

> ## Reto 1
>
> Escribe un único comando (que puede ocupar varias líneas e incluir **pipes**)
> que produzca un **dataframe** que tenga los valores africanos correspondientes
> a `lifeExp`, `country` y `year`, pero no de los otros continentes.
> ¿Cuántas filas tiene dicho **dataframe** y por qué?
>
> > ## Solución al Reto 1
> >
> >~~~
> >year_country_lifeExp_Africa <- gapminder %>%
> >                            filter(continent=="Africa") %>%
> >                            select(year,country,lifeExp)
> >~~~
> >{: .r}
> {: .solution}
{: .challenge}

Al igual que la vez anterior, primero le pasamos el **dataframe** "gapminder" a la función `filter()` y luego le pasamos la versión de dicho **dataframe** así filtrada a la función `select()`. **Nota:** El orden de las operaciones es muy importante en este caso. Si usamos primero `select()`, la función `filter()` no habría podido encontrar la variable "continent" porque la habríamos eliminado en el paso previo.

## Usando group_by() y summarize()

Se suponía que teníamos que reducir las repeticiones causantes de errores de lo que se puede hacer con el R básico, pero hasta ahora no lo hemos conseguido porque tendríamos que repetir lo escrito arriba para cada continente. En lugar de `filter()`, que solamente deja pasar las observaciones que se ajustan a tu criterio (`continent = Europe` en lo escrito arriba), podemos usar `group_by()`, que esencialmente usará cada uno de los criterios únicos que podrías haber usado con `filter()`.

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



~~~
str(gapminder %>% group_by(continent))
~~~
{: .r}



~~~
Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
 - attr(*, "vars")= chr "continent"
 - attr(*, "drop")= logi TRUE
 - attr(*, "indices")=List of 5
  ..$ : int  24 25 26 27 28 29 30 31 32 33 ...
  ..$ : int  48 49 50 51 52 53 54 55 56 57 ...
  ..$ : int  0 1 2 3 4 5 6 7 8 9 ...
  ..$ : int  12 13 14 15 16 17 18 19 20 21 ...
  ..$ : int  60 61 62 63 64 65 66 67 68 69 ...
 - attr(*, "group_sizes")= int  624 300 396 360 24
 - attr(*, "biggest_group_size")= int 624
 - attr(*, "labels")='data.frame':	5 obs. of  1 variable:
  ..$ continent: Factor w/ 5 levels "Africa","Americas",..: 1 2 3 4 5
  ..- attr(*, "vars")= chr "continent"
  ..- attr(*, "drop")= logi TRUE
~~~
{: .output}

Se puede observar que la estructura del **dataframe** obtenido por `group_by()` (`grouped_df`) no es la misma que la del **dataframe** original `gapminder`(`data.fram`). Se puede pensar en un `grouped_df` como en una `list` donde cada item in la `list` es un `data.frame` que contiene únicamente las filas que corresponden a un valor particular de `continent` (en el el ejemplo mostrado).

![](../fig/13-dplyr-fig2.png)

## Usando summarize()

Lo visto arriba no es demasiado remarcable, pero `group_by()` es mucho más excitante si se usa en conjunción con `summarize()`. Esto nos permitirá crear nuevas variables usando funciones que se aplican a cada uno de los **dataframes** específicos para cada continente. Es decir, usando la función `group_by()` dividimos nuestro **dataframe** original en varias partes, a las que luego podemos aplicar funciones (por ejemplo, `mean()` o `sd()`) independientemente con `summarize()`.

~~~
gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap = mean(gdpPercap))
~~~
{: .r}

![](../fig/13-dplyr-fig3.png)


~~~
continent mean_gdpPercap
     <fctr>          <dbl>
1    Africa       2193.755
2  Americas       7136.110
3      Asia       7902.150
4    Europe      14469.476
5   Oceania      18621.609
~~~
{: .r}

Esto nos ha permitido calcular la renta per cápita media para cada continente, pero puede ser todavía mucho mejor.

> ## Reto 2
>
>
> Calcula la esperanza de vida media por país. ¿Qué país tiene la esperanza de vida media mayor
> y cuál la menor?
>
> > ## Solución al Reto 2
> >
> >~~~
> >lifeExp_bycountry <- gapminder %>%
> >    group_by(country) %>%
> >    summarize(mean_lifeExp=mean(lifeExp))
> >lifeExp_bycountry %>%
> >    filter(mean_lifeExp == min(mean_lifeExp) | mean_lifeExp == max(mean_lifeExp))
> >~~~
> >{: .r}
> >
> >
> >
> >~~~
> ># A tibble: 2 x 2
> >       country mean_lifeExp
> >        <fctr>        <dbl>
> >1      Iceland     76.51142
> >2 Sierra Leone     36.76917
> >~~~
> >{: .output}
> Otro modo de hacer esto es usando la función `arrange()` del paquete `dplyr`,
> que distribuye las filas de un **dataframe** en función del orden de una
> o más variables del **dataframe**. Tiene una sintaxis similar a otras funciones
> del paquete `dplyr`. Se puede usar `desc()` dentro de `arrange()` para 
> ordenar de modo descendente.
> >
> >~~~
> >lifeExp_bycountry %>%
> >    arrange(mean_lifeExp) %>%
> >    head(1)
> >~~~
> >{: .r}
> >
> >
> >
> >~~~
> ># A tibble: 1 x 2
> >       country mean_lifeExp
> >        <fctr>        <dbl>
> >1 Sierra Leone     36.76917
> >~~~
> >{: .output}
> >
> >
> >
> >~~~
> >lifeExp_bycountry %>%
> >    arrange(desc(mean_lifeExp)) %>%
> >    head(1)
> >~~~
> >{: .r}
> >
> >
> >
> >~~~
> ># A tibble: 1 x 2
> >  country mean_lifeExp
> >   <fctr>        <dbl>
> >1 Iceland     76.51142
> >~~~
> >{: .output}
> {: .solution}
{: .challenge}

La función `group_by()` nos permite agrupar en función de varias variables. Vamos a agrupar por `year` y `continent`.



~~~
gdp_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
~~~
{: .r}

Esto ya es bastante potente, pero puede ser incluso mejor. Puedes definir más de una variable en `summarize()`.


~~~
gdp_pop_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop))
~~~
{: .r}

## count() y n()

Una operación muy habitual es contar el número de observaciones que hay en cada grupo. El paquete `dplyr` tiene dos funciones relacionadas muy útiles para ello.

Por ejemplo, si queremos comprobar el número de países que hay en el conjunto de datos para el año 2002 podemos usar la función `count()`. Dicha función toma el nombre de una o más columnas que contienen los grupos en los que estamos interesados y puede opcionalmente ordenar los resultados en modo descendente si añadimos `sort = TRUE`.

~~~
gapminder %>%
    filter(year == 2002) %>%
    count(continent, sort = TRUE)
~~~
{: .r}



~~~
# A tibble: 5 x 2
  continent     n
     <fctr> <int>
1    Africa    52
2      Asia    33
3    Europe    30
4  Americas    25
5   Oceania     2
~~~
{: .output}

Si necesitamos usar en nuestros cálculos el número de observaciones obtenidas, la función `n()` es muy útil. Por ejemplo, si queremos obtener el error estándar de la esperanza de vida por continente:

~~~
gapminder %>%
    group_by(continent) %>%
    summarize(se_pop = sd(lifeExp)/sqrt(n()))
~~~
{: .r}



~~~
# A tibble: 5 x 2
  continent    se_pop
     <fctr>     <dbl>
1    Africa 0.3663016
2  Americas 0.5395389
3      Asia 0.5962151
4    Europe 0.2863536
5   Oceania 0.7747759
~~~
{: .output}

También se pueden encadenar juntas varias operaciones de resumen, como en el caso siguiente, en el calculamos el `minimum`, `maximum`, `mean` y `se` de la esperanza de vida por país para cada continente:

~~~
gapminder %>%
    group_by(continent) %>%
    summarize(
      mean_le = mean(lifeExp),
      min_le = min(lifeExp),
      max_le = max(lifeExp),
      se_le = sd(lifeExp)/sqrt(n()))
~~~
{: .r}



~~~
# A tibble: 5 x 5
  continent  mean_le min_le max_le     se_le
     <fctr>    <dbl>  <dbl>  <dbl>     <dbl>
1    Africa 48.86533 23.599 76.442 0.3663016
2  Americas 64.65874 37.579 80.653 0.5395389
3      Asia 60.06490 28.801 82.603 0.5962151
4    Europe 71.90369 43.585 81.757 0.2863536
5   Oceania 74.32621 69.120 81.235 0.7747759
~~~
{: .output}

## Usando mutate()

También se pueden crear nuevas variables antes (o incluso después) de resumir la información usando `mutate()`.


~~~
gdp_pop_bycontinents_byyear <- gapminder %>%
    mutate(gdp_billion=gdpPercap*pop/10^9) %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop),
              mean_gdp_billion=mean(gdp_billion),
              sd_gdp_billion=sd(gdp_billion))
~~~
{: .r}

## Conectando mutate con filtrado lógico: ifelse

La creación de nuevas variables se puede conectar con una condición lógica. Una simple combinación de `mutate` y `ifelse` facilita el filtrado solo allí donde se necesita: en el momento de crear algo nuevo. Esta combinación es fácil de leer y es un modo rápido y potente de descartar ciertos datos (incluso sin cambiar la dimensión conjunta del **dataframe**) o para actualizar valores dependiendo de la condición utilizada.


~~~
## manteniendo todos los datos pero "filtrando" según una determinada condición
# calcular renta per cápita sólo para gente con una esperanza de vida por encima de 25
gdp_pop_bycontinents_byyear_above25 <- gapminder %>%
    mutate(gdp_billion = ifelse(lifeExp > 25, gdpPercap * pop / 10^9, NA)) %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop),
              mean_gdp_billion = mean(gdp_billion),
              sd_gdp_billion = sd(gdp_billion))

## actualizando sólo si se cumple una determinada condición
# para esperanzas de vida por encima de 40 años, el GDP que se espera en el futuro es escalado
gdp_future_bycontinents_byyear_high_lifeExp <- gapminder %>%
    mutate(gdp_futureExpectation = ifelse(lifeExp > 40, gdpPercap * 1.5, gdpPercap)) %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              mean_gdpPercap_expected = mean(gdp_futureExpectation))
~~~
{: .r}

## Combinando `dplyr` y `ggplot2`

En la función de creación de gráficas vimos cómo hacer una figura con múltiples paneles añadiendo una capa de paneles separados (**facet panels**). Aquí está el código que usamos (con algunos comentarios extra):


~~~
# Obtener la primera letra de cada país
starts.with <- substr(gapminder$country, start = 1, stop = 1)
# Filter countries that start with "A" or "Z"
az.countries <- gapminder[starts.with %in% c("A", "Z"), ]
# Construir la gráfica
ggplot(data = az.countries, aes(x = year, y = lifeExp, color = continent)) +
  geom_line() + facet_wrap( ~ country)
~~~
{: .r}

<img src="../fig/rmd-13-unnamed-chunk-21-1.png" title="plot of chunk unnamed-chunk-21" alt="plot of chunk unnamed-chunk-21" style="display: block; margin: auto;" />

Este código construye el gráfica correcta, pero también crea algunas variables `starts.with` y `az.countries`) que podemos no querer usar para nada más. Del mismo modo que usamos `%>%` para pasar datos con **pipes** a lo largo de una cadena de funciones `dplyr`, podemos usarlo para pasarle datos a `ggplot()`. Como `%>%` sustituye al primer argumento de una función, no necesitamos especifica el argumento `data=` de la función `ggplot()`. Combinando funciones de los paquetes `dplyr` y `ggplot` podemos hacer la misma figura sin crear ninguna nueva variable y sin modificar los datos.


~~~
gapminder %>%
   # Get the start letter of each country
   mutate(startsWith = substr(country, start = 1, stop = 1)) %>%
   # Filter countries that start with "A" or "Z"
   filter(startsWith %in% c("A", "Z")) %>%
   # Make the plot
   ggplot(aes(x = year, y = lifeExp, color = continent)) +
   geom_line() +
   facet_wrap( ~ country)
~~~
{: .r}

<img src="../fig/rmd-13-unnamed-chunk-22-1.png" title="plot of chunk unnamed-chunk-22" alt="plot of chunk unnamed-chunk-22" style="display: block; margin: auto;" />

Las funciones del paquete `dplyr` también nos ayudan a simplificar las cosas, por ejemplo, combinando los primeros dos pasos:


~~~
gapminder %>%
    # Filter countries that start with "A" or "Z"
	filter(substr(country, start = 1, stop = 1) %in% c("A", "Z")) %>%
	# Make the plot
	ggplot(aes(x = year, y = lifeExp, color = continent)) +
	geom_line() +
	facet_wrap( ~ country)
~~~
{: .r}

<img src="../fig/rmd-13-unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />

> ## Reto Avanzado
>
> Calcula la esperanza de vida media en 2002 de dos países seleccionados al azar 
> para cada continente. Luego distribuye los nombres de los continentes en orden inverso.
> **Pista**: Usa las funciones `arrange()` y `sample_n()` del paquete `dplyr`, tienen 
> una sintaxis similar a las demás funciones del paquete `dplyr`.
>
> > ## Solución al Reto Avanzado
> >
> >~~~
> >lifeExp_2countries_bycontinents <- gapminder %>%
> >    filter(year==2002) %>%
> >    group_by(continent) %>%
> >    sample_n(2) %>%
> >    summarize(mean_lifeExp=mean(lifeExp)) %>%
> >    arrange(desc(mean_lifeExp))
> >~~~
> >{: .r}
> {: .solution}
{: .challenge}

## Más información

* [R for Data Science](http://r4ds.had.co.nz/)
* [Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
* [Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
* [Data wrangling with R and RStudio](https://www.rstudio.com/resources/webinars/data-wrangling-with-r-and-rstudio/)
