---
title: Control de Flujo
teaching: 45
exercises: 20
questions:
- "¿Cómo puedo hacer elecciones dependiendo de mis datos en R?"
- "¿Cómo puedo repetir operaciones en R?"
objectives:
- "Escribir declaraciones condicionales utilizando `if()` y `else()`."
- "Escribir y entender los bucles con `for()`."
keypoints:
- "Usar `if` y `else` para realizar elecciones."
- "Usar `for` para operaciones repetidas."
source: Rmd
---



A menudo, cuando estamos programando deseamos controlar el flujo de nuestras acciones. Esto se puede realizar
estableciendo acciones para que ocurran solo si se cumple una condición o un conjunto de condiciones.
Alternativamente, también podemos establecer que una acción ocurra un número determinado de veces.

Hay varias maneras de controlar el flujo en R.
Para declaraciones condicionales, los enfoques más comúnmente utilizados son los constructos:


~~~
# if
if (la condición es verdad) {
  realizar una acción
}

# if ... else
if (la condición es verdad) {
  realizar una acción
} else {  # es decir, si la condición es falsa,
  realizar una acción alternativa
}
~~~
{: .r}

Digamos, por ejemplo, que queremos que R imprima un mensaje si una variable `x` tiene un valor en particular:


~~~
# Muestrea un numero al azar de una distribución de Poisson
# con una media (lambda) de 8

x <- rpois(1, lambda=8)

if (x >= 10) {
  print("x es mayor o igual que 10")
}

x
~~~
{: .r}



~~~
[1] 8
~~~
{: .output}

Ten en cuenta que puedes no obtener el mismo resultado que tu vecino porque
se generaron diferentes números aleatorios de una misma distribución.

Vamos a establecer una semilla (seed) para que todos generemos el mismo número
'pseudo-aleatorio', y luego obtener más información:


~~~
set.seed(10)
x <- rpois(1, lambda=8)

if (x >= 10) {
  print("x es mayor o igual a 10")
} else if (x > 5) {
  print("x es mayor a 5")
} else {
  print("x es menor a 5")
}
~~~
{: .r}



~~~
[1] "x es mayor a 5"
~~~
{: .output}

> ## Tip: números pseudo-aleatorios
>
> En el caso anterior, la función `rpois()` genera un número aleaotorio de una
> distribución de Poisson con una media (ej. lambda) de 8. La función `set.seed()`
> garantiza que todas las computadoras generarán el mismo número 'pseudo-aleatorio'
>  ([más información sobre los números pseudo-aleatorios](http://en.wikibooks.org/wiki/R_Programming/Random_Number_Generation)).
> Entonces si nosotros escribimos `set.seed(10)`, vemos que `x` toma el valor de 8. Deberias obtener el mismo número 
> exacto.
{: .callout}

**Importante:** cuando R evalua las condiciones dentro de `if()` , esta buscando
elementos logicos, ej., `TRUE` o `FALSE`. Esto puede ser un dolor de cabeza para
los principiantes. Por ejemplo:


~~~
x  <-  4 == 3
if (x) {
  "4 igual a 3"
}
~~~
{: .r}

Como podemos ver, el mensaje no se mostro porque el resultado del vector x es `FALSE`


~~~
x <- 4 == 3
x
~~~
{: .r}



~~~
[1] FALSE
~~~
{: .output}

> ## Reto 1
>
> Usa una declaración `if()` para mostrar un mensaje adecuado
> reportando si hay algún registro de 2002 en
> el dataset de `gapminder`.
> Ahora haz lo mismo para el año 2012.
>
> > ## Solución al Reto 1
> > Primero veremos una solución al Reto 1 que no usa la funcion `any()`.
> > Primero obtenemos un vector lógico que desscribe que el elemento `gapminder$year` es igual a `2002`:
> > 
> > ~~~
> > gapminder[(gapminder$year == 2002),]
> > ~~~
> > {: .r}
> > Luego, contamos el número de filas del data.frame `gapminder` que corresponde al año 2002:
> > 
> > ~~~
> > rows2002_number <- nrow(gapminder[(gapminder$year == 2002),])
> > ~~~
> > {: .r}
> > La presencia de cualquier registro para el año 2002 es equivalente a que el valos de `rows2002_number` sea uno o más:
> > 
> > ~~~
> > rows2002_number >= 1
> > ~~~
> > {: .r}
> > Putting all together, we obtain:
> > 
> > ~~~
> > if(nrow(gapminder[(gapminder$year == 2002),]) >= 1){
> >    print("Se encontraron registro(s) para el año 2002.")
> > }
> > ~~~
> > {: .r}
> >
> > Todo esto se puede hacer más rapido con `any()`. La condición lógica se puede expresar como:
> > 
> > ~~~
> > if(any(gapminder$year == 2002)){
> >    print("Se encontraron registro(s) para el año 2002.")
> > }
> > ~~~
> > {: .r}
> >
> {: .solution}
{: .challenge}


¿Alguien recibió un mensaje de advertencia como este?


~~~
Warning in if (gapminder$year == 2012) {: the condition has length > 1 and
only the first element will be used
~~~
{: .error}

Si tu condición se evalúa como un vector con más de un elemento lógico,
la función `if()` todavía se ejecutará, pero solo evaluará la condición en el primer 
elemento. Aquí debes asegurarte de que tu condición sea de longitud 1.

> ## Tip: `any()` y `all()`
>
> La función `any()` devolverá TRUE si al menos un
> valor TRUE se encuentra dentro del vector,  en caso contrario devolverá `FALSE`.
> Esto se puede usar de manera similar al operador `%in%`.
> La función `all()`, como el nombre sugiere, devolvera `TRUE`  si todos los valores en
> el vector son `TRUE`.
{: .callout}

## Operaciones repetidas

Si quieres iterar
sobre un conjunto de valores, cuando el orden de iteración es importante, y realizar 
la misma operación en cada uno, un bucle `for()` hará el trabajo.
Vimos los bucles `for()` en las lecciones anteriores de terminal. Esta es la
operación de bucle más flexible, pero también la más dificil de usar
correctamente. Evita usar bucles `for()` a menos que el orden de la iteración sea importante:
ej. Cuando el calculo de cada interación dependa del resultado de la interación previa.

La estructura básica de un bucle `for()` es:


~~~
for(iterador en conjunto de valores){
  haz alguna acción
}
~~~
{: .r}

Por ejemplo:


~~~
for(i in 1:10){
  print(i)
}
~~~
{: .r}



~~~
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
[1] 10
~~~
{: .output}

El rango `1:10`  crea un vector sobre la marcha; puedes iterar 
sobre cualquier otro vector también.

Podemos usar un bucle `for()`  anidado con otro bucle `for()` para iterar sobre dos cosas
a la vez.


~~~
for(i in 1:5){
  for(j in c('a', 'b', 'c', 'd', 'e')){
    print(paste(i,j))
  }
}
~~~
{: .r}



~~~
[1] "1 a"
[1] "1 b"
[1] "1 c"
[1] "1 d"
[1] "1 e"
[1] "2 a"
[1] "2 b"
[1] "2 c"
[1] "2 d"
[1] "2 e"
[1] "3 a"
[1] "3 b"
[1] "3 c"
[1] "3 d"
[1] "3 e"
[1] "4 a"
[1] "4 b"
[1] "4 c"
[1] "4 d"
[1] "4 e"
[1] "5 a"
[1] "5 b"
[1] "5 c"
[1] "5 d"
[1] "5 e"
~~~
{: .output}

En lugar de mostrar los resultados, podriamos escribir lor resultados en un nuevo objeto.


~~~
output_vector <- c()
for(i in 1:5){
  for(j in c('a', 'b', 'c', 'd', 'e')){
    temp_output <- paste(i, j)
    output_vector <- c(output_vector, temp_output)
  }
}
output_vector
~~~
{: .r}



~~~
 [1] "1 a" "1 b" "1 c" "1 d" "1 e" "2 a" "2 b" "2 c" "2 d" "2 e" "3 a"
[12] "3 b" "3 c" "3 d" "3 e" "4 a" "4 b" "4 c" "4 d" "4 e" "5 a" "5 b"
[23] "5 c" "5 d" "5 e"
~~~
{: .output}

Este enfoque puede ser útil, pero 'aumentar tus resultados' (construcción de
un objeto de manera incremental) es computacionalmente ineficiente, así que evitaló
cuando estes iterando sobre varios valores.

> ## Tip: no crezcas tus resultados
>
> Una de las grandes cosas que ocaciona tropiezo en usuarios novatos y 
> experimentados de R, es la construcción de building a results object
> (vector, list, matrix, data frame) as your for loop progresses.
> Computers are very bad at handling this, so your calculations
> can very quickly slow to a crawl. It's much better to define
> an empty results object before hand of the appropriate dimensions.
> So if you know the end result will be stored in a matrix likoe above,
> create an empty matrix with 5 row and 5 columns, then at each iteration
> store the results in the appropriate location.
{: .callout}

A better way is to define your (empty) output object before filling in the values.
For this example, it looks more involved, but is still more efficient.


~~~
output_matrix <- matrix(nrow=5, ncol=5)
j_vector <- c('a', 'b', 'c', 'd', 'e')
for(i in 1:5){
  for(j in 1:5){
    temp_j_value <- j_vector[j]
    temp_output <- paste(i, temp_j_value)
    output_matrix[i, j] <- temp_output
  }
}
output_vector2 <- as.vector(output_matrix)
output_vector2
~~~
{: .r}



~~~
 [1] "1 a" "2 a" "3 a" "4 a" "5 a" "1 b" "2 b" "3 b" "4 b" "5 b" "1 c"
[12] "2 c" "3 c" "4 c" "5 c" "1 d" "2 d" "3 d" "4 d" "5 d" "1 e" "2 e"
[23] "3 e" "4 e" "5 e"
~~~
{: .output}

> ## Tip: While loops
>
>
> Sometimes you will find yourself needing to repeat an operation until a certain
> condition is met. You can do this with a `while()` loop.
>
> 
> ~~~
> while(this condition is true){
>   do a thing
> }
> ~~~
> {: .r}
>
> As an example, here's a while loop
> that generates random numbers from a uniform distribution (the `runif()` function)
> between 0 and 1 until it gets one that's less than 0.1.
>
> ~~~
> z <- 1
> while(z > 0.1){
>   z <- runif(1)
>   print(z)
> }
> ~~~
> {: .r}
>
> `while()` loops will not always be appropriate. You have to be particularly careful
> that you don't end up in an infinite loop because your condition is never met.
{: .callout}


> ## Challenge 2
>
> Compare the objects output_vector and
> output_vector2. Are they the same? If not, why not?
> How would you change the last block of code to make output_vector2
> the same as output_vector?
>
> > ## Solution to Challenge 2
> > We can check whether the two vectors are identical using the `all()` function:
> > 
> > ~~~
> > all(output_vector == output_vector2)
> > ~~~
> > {: .r}
> > However, all the elements of `output_vector` can be found in `output_vector2`:
> > 
> > ~~~
> > all(output_vector %in% output_vector2)
> > ~~~
> > {: .r}
> > and vice versa:
> > 
> > ~~~
> > all(output_vector2 %in% output_vector)
> > ~~~
> > {: .r}
> > therefore, the element in `output_vector` and `output_vector2` are just sorted in a different order.
> > This is because `as.vector()` outputs the elements of an input matrix going over its column.
> > Taking a look at `output_matrix`, we can notice that we want its elements by rows.
> > The solution is to transpose the `output_matrix`. We can do it either by calling the transpose function
> > `t()` or by inputing the elements in the right order.
> > The first solution requires to change the original
> > 
> > ~~~
> > output_vector2 <- as.vector(output_matrix)
> > ~~~
> > {: .r}
> > into
> > 
> > ~~~
> > output_vector2 <- as.vector(t(output_matrix))
> > ~~~
> > {: .r}
> > The second solution requires to change
> > 
> > ~~~
> > output_matrix[i, j] <- temp_output
> > ~~~
> > {: .r}
> > into
> > 
> > ~~~
> > output_matrix[j, i] <- temp_output
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 3
>
> Write a script that loops through the `gapminder` data by continent and prints out
> whether the mean life expectancy is smaller or larger than 50
> years.
>
> > ## Solution to Challenge 3
> >
> > **Step 1**:  We want to make sure we can extract all the unique values of the continent vector
> > 
> > ~~~
> > gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> > unique(gapminder$continent)
> > ~~~
> > {: .r}
> >
> > **Step 2**: We also need to loop over each of these continents and calculate the average life expectancy for each `subset` of data.
> > We can do that as follows:
> >
> > 1. Loop over each of the unique values of 'continent'
> > 2. For each value of continent, create a temporary variable storing the life exepectancy for that subset,
> > 3. Return the calculated life expectancy to the user by printing the output:
> >
> > 
> > ~~~
> > for( iContinent in unique(gapminder$continent) ){
> >    tmp <- mean(subset(gapminder, continent==iContinent)$lifeExp)
> >    cat("Average Life Expectancy in", iContinent, "is", tmp, "\n")
> >    rm(tmp)
> > }
> > ~~~
> > {: .r}
> >
> > **Step 3**: The exercise only wants the output printed if the average life expectancy is less than 50 or greater than 50. So we need to add an `if` condition before printing.
> > So we need to add an `if` condition before printing, which evaluates whether the calculated average life expectancy is above or below a threshold, and print an output conditional on the result.
> > We need to amend (3) from above:
> >
> > 3a. If the calculated life expectancy is less than some threshold (50 years), return the continent and a statement that life expectancy is less than threshold, otherwise return the continent and   a statement that life expectancy is greater than threshold,:
> >
> > 
> > ~~~
> > thresholdValue <- 50
> > > >
> > for( iContinent in unique(gapminder$continent) ){
> >    tmp <- mean(subset(gapminder, continent==iContinent)$lifeExp)
> >    
> >    if(tmp < thresholdValue){
> >        cat("Average Life Expectancy in", iContinent, "is less than", thresholdValue, "\n")
> >    }
> >    else{
> >        cat("Average Life Expectancy in", iContinent, "is greater than", thresholdValue, "\n")
> >         } # end if else condition
> >    rm(tmp)
> >    } # end for loop
> > > >
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 4
>
> Modify the script from Challenge 4 to loop over each
> country. This time print out whether the life expectancy is
> smaller than 50, between 50 and 70, or greater than 70.
>
> > ## Solution to Challenge 4
> >  We modify our solution to Challenge 3 by now adding two thresholds, `lowerThreshold` and `upperThreshold` and extending our if-else statements:
> >
> > 
> > ~~~
> >  lowerThreshold <- 50
> >  upperThreshold <- 70
> >  
> > for( iCountry in unique(gapminder$country) ){
> >     tmp <- mean(subset(gapminder, country==iCountry)$lifeExp)
> >     
> >     if(tmp < lowerThreshold){
> >         cat("Average Life Expectancy in", iCountry, "is less than", lowerThreshold, "\n")
> >     }
> >     else if(tmp > lowerThreshold && tmp < upperThreshold){
> >         cat("Average Life Expectancy in", iCountry, "is between", lowerThreshold, "and", upperThreshold, "\n")
> >     }
> >     else{
> >         cat("Average Life Expectancy in", iCountry, "is greater than", upperThreshold, "\n")
> >     }
> >     rm(tmp)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 5 - Advanced
>
> Write a script that loops over each country in the `gapminder` dataset,
> tests whether the country starts with a 'B', and graphs life expectancy
> against time as a line graph if the mean life expectancy is under 50 years.
>
> > Solution for Challenge 5
> >
> > We will use the `grep` command that was introduced in the Unix Shell lesson to find countries that start with "B."
> > Lets understand how to do this first.
> > Following from the Unix shell section we may be tempted to try the following
> > 
> > ~~~
> > grep("^B", unique(gapminder$country))
> > ~~~
> > {: .r}
> >
> > But when we evaluate this command it returns the indices of the factor variable `country` that start with "B."
> > To get the values, we must add the `value=TRUE` option to the `grep` command:
> >
> > 
> > ~~~
> > grep("^B", unique(gapminder$country), value=TRUE)
> > ~~~
> > {: .r}
> >
> > We will now store these countries in a variable called candidateCountries, and then loop over each entry in the variable.
> > Inside the loop, we evaluate the average life expectancy for each country, and if the average life expectancy is less than 50 we use base-plot to plot the evolution of average life expectancy:
> >
> > 
> > ~~~
> > thresholdValue <- 50
> > candidateCountries <- grep("^B", unique(gapminder$country), value=TRUE)
> > > >
> > for( iCountry in candidateCountries){
> >     tmp <- mean(subset(gapminder, country==iCountry)$lifeExp)
> >     
> >     if(tmp < thresholdValue){
> >         cat("Average Life Expectancy in", iCountry, "is less than", thresholdValue, "plotting life expectancy graph... \n")
> >         
> >         with(subset(gapminder, country==iCountry),
> >                 plot(year,lifeExp,
> >                      type="o",
> >                      main = paste("Life Expectancy in", iCountry, "over time"),
> >                      ylab = "Life Expectancy",
> >                      xlab = "Year"
> >                    ) # end plot
> >               ) # end with
> >     } # end for loop
> >     rm(tmp)
> >  }```
> > > {: .solution}
> > {: .challenge}
> > ~~~
> > {: .r}
