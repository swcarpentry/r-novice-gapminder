---
title: Vectorización
teaching: 10
exercises: 15
questions:
- "¿Cómo puedo operar sobre todos los elementos de un vector a la vez?"
objectives:
- "Entender las operaciones vertorizadas en R."
keypoints:
- "Uso de operaciones vectorizadas en lugar de bucles."
source: Rmd
---



La mayoría de funciones en R están vectorizadas, lo que significa que la función
operará sobre todos los elementos de un vector sin necesidad de hacer un bucle a través
de cada elemento y actuar sobre cada uno a la vez. Esto hace la escritura de código más
concisa, fácil de leer y menos propenso a errores.



~~~
x <- 1:4
x * 2
~~~
{: .r}



~~~
[1] 2 4 6 8
~~~
{: .output}

La multiplicación se aplicó a cada elemento del vector.

También podemos sumar dos vectores juntos:


~~~
y <- 6:9
x + y
~~~
{: .r}



~~~
[1]  7  9 11 13
~~~
{: .output}

Cada elemento de `x` fue sumado a su correspondiente elemento de `y`:


~~~
x:  1  2  3  4
    +  +  +  +
y:  6  7  8  9
---------------
    7  9 11 13
~~~
{: .r}


> ## Desafío 1
>
> Probemos esto en la columna `pop` del **dataset** `gapminder`.
>
> Haz una nueva columna en el **data frame** `gapminder` que
> contiene población en unidades de millones de personas.
> Comprueba la cabeza y la cola del **data frame** para asegurar
> que funcionó.
>
> > ## Solución al desafío 1
> >
> > Intenta esto en la columna `pop` del **dataset** `gapminder`.
> >
> > Haz una nueva columna en el **data frame** `gapminder` que
> > contiene población en unidades de millones de personas.
> > Comprueba la cabeza y la cola del **data frame** para asegurar
> > que funcionó.
> >
> > 
> > ~~~
> > gapminder$pop_millions <- gapminder$pop / 1e6
> > head(gapminder)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >       country year      pop continent lifeExp gdpPercap pop_millions
> > 1 Afghanistan 1952  8425333      Asia  28.801  779.4453     8.425333
> > 2 Afghanistan 1957  9240934      Asia  30.332  820.8530     9.240934
> > 3 Afghanistan 1962 10267083      Asia  31.997  853.1007    10.267083
> > 4 Afghanistan 1967 11537966      Asia  34.020  836.1971    11.537966
> > 5 Afghanistan 1972 13079460      Asia  36.088  739.9811    13.079460
> > 6 Afghanistan 1977 14880372      Asia  38.438  786.1134    14.880372
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}


> ## Desafío 2
>
> En una sola gráfica, trazar la población, en 
> millones, contra año, para todos los países. No te preocupes en
>identificar cuál país es cuál.
>
> Repite el ejercicio, graficando sólo para China, India, e
>Indonesia. Nuevamente,  no te preocupes acerca de cuál es cuál.
>
> > ## Solución al desafío 2
> >
> > Refresca tus habilidades de trazado trazando la población en millones contra año.
> >
> > 
> > ~~~
> > ggplot(gapminder, aes(x = year, y = pop_millions)) +
> >  geom_point()
> > ~~~
> > {: .r}
> > 
> > <img src="../fig/rmd-09-ch2-sol-1.png" title="plot of chunk ch2-sol" alt="plot of chunk ch2-sol" style="display: block; margin: auto;" />
> > 
> > ~~~
> > countryset <- c("China","India","Indonesia")
> > ggplot(gapminder[gapminder$country %in% countryset,],
> >        aes(x = year, y = pop_millions)) +
> >   geom_point()
> > ~~~
> > {: .r}
> > 
> > <img src="../fig/rmd-09-ch2-sol-2.png" title="plot of chunk ch2-sol" alt="plot of chunk ch2-sol" style="display: block; margin: auto;" />
> {: .solution}
{: .challenge}


Operadores de Comparación, operadores lógicos y muchas funciones también son
vectorizados:


**Operadores de Comparación**


~~~
x > 2
~~~
{: .r}



~~~
[1] FALSE FALSE  TRUE  TRUE
~~~
{: .output}

**Operadores Lógicos**

~~~
a <- x > 3  # or, for clarity, a <- (x > 3)
a
~~~
{: .r}



~~~
[1] FALSE FALSE FALSE  TRUE
~~~
{: .output}

> ## Tip: algunas funciones útiles para vectores lógicos
>
> `any()` will return `TRUE` if *any* element of a vector is `TRUE`
> `all()` will return `TRUE` if *all* elements of a vector are `TRUE`
{: .callout}

La mayoría de las funciones también operan con los elementos de los vectores:

**Funciones**

~~~
x <- 1:4
log(x)
~~~
{: .r}



~~~
[1] 0.0000000 0.6931472 1.0986123 1.3862944
~~~
{: .output}

Operaciones vectorizadas funcionan a nivel de elemento en matrices:


~~~
m <- matrix(1:12, nrow=3, ncol=4)
m * -1
~~~
{: .r}



~~~
     [,1] [,2] [,3] [,4]
[1,]   -1   -4   -7  -10
[2,]   -2   -5   -8  -11
[3,]   -3   -6   -9  -12
~~~
{: .output}


> ## Tip: multiplicación elemento vs. matriz
>
> Muy importante: el operador`*` te da una multiplicación de elemento
> Para haccer multiplicación de matriz, necesitamos usar el operador `%*%`:
>
> 
> ~~~
> m %*% matrix(1, nrow=4, ncol=1)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>      [,1]
> [1,]   22
> [2,]   26
> [3,]   30
> ~~~
> {: .output}
> 
> 
> 
> ~~~
> matrix(1:4, nrow=1) %*% matrix(1:4, ncol=1)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>      [,1]
> [1,]   30
> ~~~
> {: .output}
>
> Para más sobre álgebra de matrices, ver [Quick-R reference
> guide](http://www.statmethods.net/advstats/matrix.html)
{: .callout}


> ## Desafío 3
>
> Dada la siguiente matriz:
>
> 
> ~~~
> m <- matrix(1:12, nrow=3, ncol=4)
> m
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> ~~~
> {: .output}
>
> Escribe lo que crees que sucederá cuando ejecutes:
>
> 1. `m ^ -1`
> 2. `m * c(1, 0, -1)`
> 3. `m > c(0, 20)`
> 4. `m * c(1, 0, -1, 2)`
>
> ¿Obtuviste la salida que esperabas? Si no, pregunta a un ayudante!
>
> > ## Solución a desafío 3
> >
> > Dada la siguiente matriz:
> >
> > 
> > ~~~
> > m <- matrix(1:12, nrow=3, ncol=4)
> > m
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >      [,1] [,2] [,3] [,4]
> > [1,]    1    4    7   10
> > [2,]    2    5    8   11
> > [3,]    3    6    9   12
> > ~~~
> > {: .output}
> >
> >
> > Escribe lo que piensas que pasará cuando ejecutes:
> >
> > 1. `m ^ -1`
> >
> > 
> > ~~~
> >           [,1]      [,2]      [,3]       [,4]
> > [1,] 1.0000000 0.2500000 0.1428571 0.10000000
> > [2,] 0.5000000 0.2000000 0.1250000 0.09090909
> > [3,] 0.3333333 0.1666667 0.1111111 0.08333333
> > ~~~
> > {: .output}
> >
> > 2. `m * c(1, 0, -1)`
> >
> > 
> > ~~~
> >      [,1] [,2] [,3] [,4]
> > [1,]    1    4    7   10
> > [2,]    0    0    0    0
> > [3,]   -3   -6   -9  -12
> > ~~~
> > {: .output}
> >
> > 3. `m > c(0, 20)`
> >
> > 
> > ~~~
> >       [,1]  [,2]  [,3]  [,4]
> > [1,]  TRUE FALSE  TRUE FALSE
> > [2,] FALSE  TRUE FALSE  TRUE
> > [3,]  TRUE FALSE  TRUE FALSE
> > ~~~
> > {: .output}
> >
> {: .solution}
{: .challenge}


> ## Desafío 4
>
> Estamos interesados en encontrar la suma de la 
> siguiente secuencia de fracciones:
>
> 
> ~~~
>  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> ~~~
> {: .r}
>
> Esto sería tedioso de escribir, e imposible para valores altos de 
> n.  Usa vectorización para calcular x cuando n=100. ¿Cuál es la suma cuando
> n=10,000?
>
> > ##  Desafío 4
> >
> > Estamos interesados en encontrar la suma de la
> > siguiente secuencia de fracciones:
> >
> > 
> > ~~~
> >  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> > ~~~
> > {: .r}
> >
> > Esto sería tedioso de escribir, e imposible para
> > valores altos de n.
> > ¿Puedes usar vectorización para calcular x, cuando n=100?
> > ¿Qué tal cuando n=10,000?
> >
> > 
> > ~~~
> > sum(1/(1:100)^2)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.634984
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > sum(1/(1:1e04)^2)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.644834
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > n <- 10000
> > sum(1/(1:n)^2)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.644834
> > ~~~
> > {: .output}
> >
> > Podemos obtener el mismo resultado usando una función:
> > 
> > ~~~
> > inverse_sum_of_squares <- function(n) {
> >   sum(1/(1:n)^2)
> > }
> > inverse_sum_of_squares(100)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.634984
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > inverse_sum_of_squares(10000)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.644834
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > n <- 10000
> > inverse_sum_of_squares(n)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 1.644834
> > ~~~
> > {: .output}
> >
> {: .solution}
{: .challenge}
