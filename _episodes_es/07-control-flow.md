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
Para declaraciones condicionales, los enfoques más comúnmente utilizados son los **constructs**:


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

> ## Desafío 1
>
> Usa una declaración `if()` para mostrar un mensaje adecuado
> reportando si hay algún registro de 2002 en
> el **dataset** de **`gapminder`**.
> Ahora haz lo mismo para el año 2012.
>
> > ## Solución al Desafío 1
> > Primero veremos una solución al Desafío 1 que no usa la funcion `any()`.
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
> > La presencia de cualquier registro para el año 2002 es equivalente a la petición de que `rows2002_number` sea uno o más:
> > 
> > ~~~
> > rows2002_number >= 1
> > ~~~
> > {: .r}
> > Poniendo esto junto, nosotros obtenemos:
> > 
> > ~~~
> > if(nrow(gapminder[(gapminder$year == 2002),]) >= 1){
> >    print("Se encontraron registro(s) para el año 2002.")
> > }
> > ~~~
> > {: .r}
> >
> > Todo esto se puede hacer más rápido con `any()`. La condición lógica se puede expresar como:
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
i.e. Cuando el cálculo de cada interación dependa del resultado de la interación previa.

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

Este enfoque puede ser útil, pero "aumentará o crecerá tus resultados" (construir el objeto resultante de forma incremental) es computacionalmente ineficiente, así que evítalo cuando estés iterando a través de muchos valores.

> ## Tip: no crezcas tus resultados
>
> Una de las cosas más importantes que hace tropezar tanto a los principiantes como 
> a los usuarios experimentados de R es la construcción de un objeto de resultados
> (vector, lista, matriz, data frame) a medida que progresas en el bucle for.
> Las computadoras son muy malas para manejar esto, por lo que tus cálculos 
> pueden alentarse muy rápidamente. Es mucho mejor definir un objeto de 
> resultados vacío de primera mano con las dimensiones apropiadas.
> Entonces, si sabe que el resultado final se almacenará en una matriz como la 
> anterior, cree una matriz vacía con 5 filas y 5 columnas, luego en cada iteración
> almacene los resultados en la ubicación adecuada.
{: .callout}

Una mejor manera es definir el objeto de salida (vacio) antes de completar los valores.
Para este ejemplo, parece más complicado, pero es aún más eficiente.


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

> ## Tip: Bucles While
>
>
> Algunas veces tendras la necesidad de repetir una operación hasta que
> cierta condición se cumpla. Puedes hacer esto con un bucle `while()`.
>
> 
> ~~~
> while(mientras esta condición es verdad){
>   haz algo
> }
> ~~~
> {: .r}
>
> Como ejemplo, aquí hay un bucle while
> que genera números aleatorios a partir de una distribución uniforme (la función `runif()` )
> entre 0 y 1  hasta que obtiene uno que es menor a 0.1.
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
> Los bucle `while()` no siempre seran apropiados. Tienes que ser particularmente cuidadoso
> de no terminar en un bucle infinito porque tu condición nunca se cumple.
{: .callout}


> ## Desafío 2
>
> Compara los objetos output_vector y
> output_vector2. ¿Son lo mismo? Si no, ¿por qué no?
> ¿Cómo cambiarías el último bloque de código para hacer output_vector2
> igual a output_vector?
>
> > ## Solución al Desafío 2
> > Podemos verificar si dos vectores son idénticos usando la función `all()` :
> > 
> > ~~~
> > all(output_vector == output_vector2)
> > ~~~
> > {: .r}
> > Sin embargo, todos los elementos de `output_vector` se pueden encontrar en `output_vector2`:
> > 
> > ~~~
> > all(output_vector %in% output_vector2)
> > ~~~
> > {: .r}
> > y vice versa:
> > 
> > ~~~
> > all(output_vector2 %in% output_vector)
> > ~~~
> > {: .r}
> > Por lo tanto, el elemento en `output_vector` y `output_vector2` estan en orden distinto.
> > Esto es porque `as.vector ()` genera los elementos de una matriz de entrada que pasa por su columna.
> > Echando un vistazo a `output_matrix`, podemos notar que queremos sus elementos por filas.
> > La solución es transponer la `output_matrix`. Podemos hacerlo llamando a la función de transposición
> > `t ()` o ingresando los elementos en el orden correcto.
> > La primera solución requiere cambiar el original
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
> > La segunda solución requiere cambiar
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

> ## Desafío 3
>
> Escribe un **script** que a través de bucles recorra los datos `gapminder` por continente e imprima
> si la esperanza de vida media es menor o mayor que 50
> años.
>
> > ## Solución al Desafío 3
> >
> > ** Paso 1 **: Queremos asegurarnos de que podamos extraer todos los valores únicos del vector continente
> > 
> > ~~~
> > gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> > unique(gapminder$continent)
> > ~~~
> > {: .r}
> >
> > ** Paso 2 **: También tenemos que recorrer cada uno de estos continentes y calcular la esperanza de vida promedio para cada "subconjunto" de datos.
> > Podemos hacer eso de la siguiente manera:
> >
> > 1. Pasa por encima de cada uno de los valores únicos de 'continente'
> > 2. Para cada valor de continente, crea una variable temporal que almacene la vida útil para ese subconjunto,
> > 3. Regresar la expectativa de vida calculada al usuario imprimiendo el resultado:
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
> > ** Paso 3 **: El ejercicio solo requiere que se imprima el resultado si la expectativa de vida promedio es menor a 50 o superior a 50. Por lo tanto, debemos agregar una condición 'if' antes de imprimir, lo cual evalúa si la expectativa de vida promedio calculada es superior o inferior a un umbral, e imprime una salida condicional en el resultado.
> > Necesitamos corregir (3) desde arriba:
> >
> > 3a. Si la esperanza de vida calculada es menor que algún umbral (50 años), devuelva el continente y una declaración de que la esperanza de vida es menor que el umbral, de lo contrario devuelva el continente y una declaración de que la esperanza de vida es mayor que el umbral ,:
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

> ## Desafío 4
>
> Modifica el **script** del Desafío 4 por un bucle sobre cada uno de los
> paises. Qué esta vez, imprima si la esperanza de vida es
> menor que 50, entre 50 y 70, o mayor que 70.
>
> > ## Solución al Desafío 4
> >  Modificamos nuestra solución al Reto 3 agregando ahora dos umbrales, `lowerThreshold` y` upperThreshold` y extendiendo nuestras declaraciones if-else:
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

> ## Desafío 5 - Avanzado
>
> Escribir un script que con un bucle recorra cada país en el **dataset** **`gapminder`**,
> prueba si el país comienza con una 'B' y grafica la esperanza de vida
> contra el tiempo como un gráfico de líneas si la esperanza de vida media es menor de 50 años.
>
> > Solución para el Desafío 5
> >
> > Usaremos el comando `grep` que se introdujo en la lección Shell de Unix para encontrar países que comiencen con" B "."
> > Vamos a entender cómo hacer esto primero.
> > Siguiendo la sección de shell de Unix, podemos tener la tentación de probar lo siguiente
> > 
> > ~~~
> > grep("^B", unique(gapminder$country))
> > ~~~
> > {: .r}
> >
> > Pero cuando evaluamos este comando, regresa los índices de la variable del factor `country` que comienza con" B ".
> > Para obtener los valores, debemos agregar la opción `value = TRUE` al comando` grep`:
> >
> > 
> > ~~~
> > grep("^B", unique(gapminder$country), value=TRUE)
> > ~~~
> > {: .r}
> >
> > Ahora almacenaremos estos países en una variable llamada candidateCountries, y luego con un bucle recorremos cada entrada en la variable.
> > Dentro del bucle, evaluamos la expectativa de vida promedio para cada país, y si la expectativa de vida promedio es menor a 50, usamos un gráfico base para trazar la evolución de la expectativa de vida promedio:
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
