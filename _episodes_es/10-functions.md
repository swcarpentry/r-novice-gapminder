---
title: Funciones
teaching: 45
exercises: 15
questions:
- "¿Cómo puedo escribir una nueva función en R?"
objectives:
- "Definir una función que usa argumentos."
- "Obtener un valor a partir de una función."
- "Revisar argumentos con `stopifnot()` en las funciones."
- "Probar una función."
- "Establecer valores por defecto para los argumentos de las funciones."
- "Explicar por qué debemos dividir programas en funciones pequeñas y de propósitos únicos."
keypoints:
- "Usar `function` para definir una nueva función en R."
- "Usar parámetros para ingresar valores dentro de las funciones."
- "Usar `stopifnot()` para revisar los argumentos de una función en R de manera flexible."
- "Cargar funciones dentro de programas empleando `source()`."
source: Rmd
---




Si tuviéramos un único conjunto de datos para analizar, probablemente sería más rápido cargar el archivo en una hoja de cálculo y usarla para graficar estadísticos simples. Sin embargo, los datos `gapminder` son actualizados periódicamente, y podríamos querer volver a bajar esta información actualizada más adelante y re-analizar los datos. También podríamos obtener datos similares de una fuente distinta en el futuro. 

En esta lección, aprenderemos cómo escribir una función de forma que seamos capaces de repetir varias operaciones con un comando único. 

> ## ¿Qué es una función?
>
> Las funciones reunen una secuencia de operaciones en un todo, almacenándola para
> su uso. Las funciones proveen:
>
> * un nombre que podemos recordar y usar para invocarla
> * una solución para la necesidad de recordar operaciones individuales
> * un conjunto definido de **inputs** y **ouputs** esperados
> * conexiones ricas con el ambiente de programación mayor
>
> Así como en la estructura de construcción básica de la mayoría de los lenguajes de programación, las funciones 
> definidas por el usuario constituyen "programación" tan válida como lo es cualquier simple abstracción. Si
> has escrito una función, entonces eres un programador de computación.
{: .callout}

## Definiendo una función

Empecemos abriendo un nuevo __script__ de R en el directorio `functions/` y nombrémosle functions-lesson.R.


~~~
mi_suma <- function(a, b) {
  la_suma <- a + b
  return(la_suma)
}
~~~
{: .r}

Definamos una función `fahr_a_kelvin()` que convierta temperaturas de 
Fahrenheit a Kelvin:


~~~
fahr_a_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

Definimos `fahr_a_kelvin()` asignándola al __output__ de `function`. La
lista de los nombres de los argumentos se encuentran entre paréntesis. Luego, el 
[cuerpo]({{ page.root }}/reference/#function-body) de la función--los
comandos que son ejecutados cuando se corre--se encuentran entre paréntesis curvos
(`{}`). Los comandos en el cuerpo se indentan con dos espacios. Esto hace que
el código sea legible sin afectar cómo opera.

Cuando utilizamos la función, los valores que definimos como argumentos se asignan a 
esas variables para que podamos usarlos dentro de la función. Dentro de la 
función, usamos un [return
statement]({{ page.root }}/reference/#return-statement) para devolver un resultado a 
quien lo solicitó. 


> ## Sugerencia
>
> Una característica única de R es que el __return statement__ no es requerido.
> R automáticamente devuelve cualquier variable que esté en la última linea del cuerpo
> de la función. Pero por claridad, nosotros explícitamente definiremos el 
> __return statement__.
{: .callout}


Tratemos de correr nuestra función.
Llamamos nuestra propia función de la misma manera que llamamos cualquier otra:


~~~
# Punto de congelación del agua
fahr_a_kelvin(32)
~~~
{: .r}



~~~
[1] 273.15
~~~
{: .output}


~~~
# Punto de ebullición del agua
fahr_a_kelvin(212)
~~~
{: .r}



~~~
[1] 373.15
~~~
{: .output}

> ## Desafío 1
>
> Escribe una función llamada `kelvin_a_celsius()` que toma la temperatura en 
> grados Kelvin y devuelve la temperatura en Celsius.
>
> Pista: Para convertir de Kelvin a Celsius se debe restar 273.15
>
> > ## Solución al desafío 1
> >
> > Escribe una función llamada `kelvin_a_celsius()` que toma la temperatura en grados
> > Kelvin y devuelve la temperatura en Celsius.
> >
> > 
> > ~~~
> > kelvin_a_celsius <- function(temp) {
> >  celsius <- temp - 273.15
> >  return(celsius)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

## Combinando funciones

El poder real de las funciones proviene de mezclarlas y combinarlas en 
pedazos de código aún mas grandes para lograr el resultado que buscamos.

Definamos dos funciones que convertirán la temperatura de Fahrenheit a
Kelvin, y de Kelvin a Celsius:


~~~
fahr_a_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

kelvin_a_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}
~~~
{: .r}

> ## Desafío 2
>
> Define la función para convertir directamente de Fahrenheit a Celsius,
> reutilizando las dos funciones de arriba (o utilizando tus propias funciones
> si lo prefieres).
>
>
> > ## Solución a desafío 2
> >
> > Define la función para convertir directamente de Fahrenheit a Celsius,
> > reutilizando las dos funciones de arriba.
> >
> >
> > 
> > ~~~
> > fahr_a_celsius <- function(temp) {
> >   temp_k <- fahr_a_kelvin(temp)
> >   result <- kelvin_a_celsius(temp_k)
> >   return(result)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

## Interludio: Programación defensiva

Ahora que hemos empezado a apreciar cómo las funciones proporcionan una manera eficiente de hacer que el código R sea reutilizable
y modular, debemos tener en cuenta que es importante garantizar que las funciones solo funcionen en los casos de uso previstos.
Revisar los parámetros de las funciones está relacionado con el concepto de _programación defensiva_.
La programación defensiva nos alienta a chequear las condiciones frecuentemente y arrojar un
error si algo está mal. Estos chequeos se conocen como __assertion statements__ porque queremos 
asegurarnos de que una determinada condición es `TRUE` antes de proceder. 
Esto facilita la depuración porque nos dan una mejor idea de dónde se originan los errores. 

### Chequear condiciones con `stopifnot()`

Empecemos por re-examinar `fahr_a_kelvin()`, nuestra función para convertir
temperaturas de Fahrenheit a Kelvin. Estaba definida de la siguiente manera:


~~~
fahr_a_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

Para que esta función trabaje como se desea, el argumento `temp` debe ser un valor `numeric`; de lo contrario, el procedimiento
matemático para convertir entre las dos escalas de temperatura no funcionará. Para crear un error, podemos usar la función
`stop()`. Por ejemplo, dado que el argumento `temp` debe ser un vector `numeric`, podríamos
chequearlo con un condicional `if` y devolver un error si la 
condición no se cumple. Podríamos agregar esto a nuestra función de la siguiente manera:


~~~
fahr_a_kelvin <- function(temp) {
  if (!is.numeric(temp)) {
    stop("temp debe ser un vector numerico.")
  }
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

Si tuviéramos muchas condiciones o argumentos para revisar, podría llevar muchas líneas
de código chequearlas a todas. Afortunadamente R provee la función de conveniencia
`stopifnot()`. Podemos listar todos los requerimientos que deben ser evaluados como `TRUE`;
`stopifnot()` arroja un error si encuentra uno que sea `FALSE`. 
Listar estas condiciones tiene como objetivo secundario el generar documentación extra para la función.

Probemos la programación defensiva con `stopifnot()` agregando aseveraciones para
chequear el __input__ a nuestra función `fahr_a_kelvin()`.

Queremos asegurar lo siguiente: `temp` es un vector numérico. Lo podemos hacer de la siguiente manera:


~~~
fahr_a_kelvin <- function(temp) {
  stopifnot(is.numeric(temp))
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
~~~
{: .r}

Aún funciona si se le da un __input__ adecuado.


~~~
# temperatura de congelación del agua
fahr_a_kelvin(temp = 32)
~~~
{: .r}



~~~
[1] 273.15
~~~
{: .output}

Pero falla instantáneamente si se le da un __input__ inapropiado.


~~~
# Aquí la medida es un factor, no un valor numérico
fahr_a_kelvin(temp = as.factor(32))
~~~
{: .r}



~~~
Error: is.numeric(temp) is not TRUE
~~~
{: .error}

> ## Desafío 3
>
> Usar programación defensiva para asegurar que nuestra función `fahr_a_celsius()`
> arroja inmediatamente un error si el argumento `temp` se especifica 
> inadecuadamente.
>
>
> > ## Solución al desafío 3
> >
> > Extender la definición previa de nuestra función agregándole una llamada explícita
> > a `stopifnot()`. Dado que `fahr_a_celsius()` es una composición de otras dos
> > funciones, hacer un chequeo a la función hace redundante el agregar chequeos a cada una de las 
> > dos funciones que la componen.
> >
> >
> > 
> > ~~~
> > fahr_a_celsius <- function(temp) {
> >   stopifnot(!is.numeric(temp))
> >   temp_k <- fahr_a_kelvin(temp)
> >   result <- kelvin_a_celsius(temp_k)
> >   return(result)
> > }
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}```

## Más sobre combinar funciones

Ahora vamos a definir una función que calcula el Producto Bruto Interno ("GDP" en la base de datos, por sus siglas en inglés 
Gross Domestic Product) de un país a partir de los datos disponibles en nuestro set de datos:


~~~
# Toma un set de datos y multiplica la columna de la población
# con la del Producto Bruto Interno per cápita.
calcGDP <- function(dat) {
  gdp <- dat$pop * dat$gdpPercap
  return(gdp)
}
~~~
{: .r}

Definimos `calcGDP()` asignándola al __output__ de `function`. La lista de
los nombres de los argumentos se encuentran entre paréntesis. Luego, el 
cuerpo de la función--los 
comandos que son ejecutados cuando se corre-- se encuentran entre paréntesis curvos
(`{}`). 

Hemos indentado los comandos en el cuerpo con dos espacios. Esto hace que el código 
sea mas fácil de leer sin afectar su funcionamiento. 

Cuando utilizamos la función, los valores que le pasamos se asignan como argumentos,
que se convierten en variables dentro del cuerpo de la función.

Dentro de la función, usamos la función `return()` para obtener el resultado.

Esta función `return()` es opcional: R automáticamente devolverá el resultado de cualquier 
sea el comando que se ejecute en la última línea de la función.


~~~
calcGDP(head(gapminder))
~~~
{: .r}



~~~
[1]  6567086330  7585448670  8758855797  9648014150  9678553274 11697659231
~~~
{: .output}

Eso no es muy informativo. Agreguemos algunos argumentos más para poder extraer
 por año y país. 


~~~
# Toma un set de datos y multiplica la columna de la población
# con la del Producto Bruto Interno per cápita.
calcGDP <- function(dat, year=NULL, country=NULL) {
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
  gdp <- dat$pop * dat$gdpPercap

  new <- cbind(dat, gdp=gdp)
  return(new)
}
~~~
{: .r}

Si has estado escribiendo estas funciones en un __script__ de R aparte
(¡una buena idea!), puedes cargar las funciones en nuestra sesión de R
usando la función `source()`:


~~~
source("functions/functions-lesson.R")
~~~
{: .r}

Ok, entonces están pasando muchas cosas en esta función ahora. En pocas palabras, ahora
la función filtra un subconjunto de datos por año si el argumento año no está vacío,
luego filtra un subconjunto de los resultados por país si el argumento país no está vacío.
Luego calcula el GDP de los datos filtrados resultado de los dos 
pasos anteriores. La función luego agrega el valor calculado de GDP como una nueva columna
en los datos filtrados y devuelve esto como el resultado final. Puedes ver que el __output__ 
es mucho más informativo que un vector numérico.

Veamos qué sucede cuando especificamos el año:


~~~
head(calcGDP(gapminder, year=2007))
~~~
{: .r}



~~~
       country year      pop continent lifeExp  gdpPercap          gdp
12 Afghanistan 2007 31889923      Asia  43.828   974.5803  31079291949
24     Albania 2007  3600523    Europe  76.423  5937.0295  21376411360
36     Algeria 2007 33333216    Africa  72.301  6223.3675 207444851958
48      Angola 2007 12420476    Africa  42.731  4797.2313  59583895818
60   Argentina 2007 40301927  Americas  75.320 12779.3796 515033625357
72   Australia 2007 20434176   Oceania  81.235 34435.3674 703658358894
~~~
{: .output}

O para un país específico:


~~~
calcGDP(gapminder, country="Australia")
~~~
{: .r}



~~~
     country year      pop continent lifeExp gdpPercap          gdp
61 Australia 1952  8691212   Oceania  69.120  10039.60  87256254102
62 Australia 1957  9712569   Oceania  70.330  10949.65 106349227169
63 Australia 1962 10794968   Oceania  70.930  12217.23 131884573002
64 Australia 1967 11872264   Oceania  71.100  14526.12 172457986742
65 Australia 1972 13177000   Oceania  71.930  16788.63 221223770658
66 Australia 1977 14074100   Oceania  73.490  18334.20 258037329175
67 Australia 1982 15184200   Oceania  74.740  19477.01 295742804309
68 Australia 1987 16257249   Oceania  76.320  21888.89 355853119294
69 Australia 1992 17481977   Oceania  77.560  23424.77 409511234952
70 Australia 1997 18565243   Oceania  78.830  26997.94 501223252921
71 Australia 2002 19546792   Oceania  80.370  30687.75 599847158654
72 Australia 2007 20434176   Oceania  81.235  34435.37 703658358894
~~~
{: .output}

O ambos:


~~~
calcGDP(gapminder, year=2007, country="Australia")
~~~
{: .r}



~~~
     country year      pop continent lifeExp gdpPercap          gdp
72 Australia 2007 20434176   Oceania  81.235  34435.37 703658358894
~~~
{: .output}

Veamos paso a paso el cuerpo de la función:


~~~
calcGDP <- function(dat, year=NULL, country=NULL) {
~~~
{: .r}

Aquí hemos agregado dos argumentos: año ("year") y país ("country"). Hemos seteado
*argumentos por defecto* para ambos como `NULL` usando el operador `=` 
en la definición de la función. Esto significa que estos argumentos tendrán esos valores
a menos que el usuario especifique otra cosa.


~~~
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
~~~
{: .r}

Aquí chequeamos si cada argumento adicional esta seteado a `null`, y cuando no sea
`null` se sobreescriben los datos almacenados en `dat` con un subconjunto de datos determinados por el 
argumento no nulo.

Hacemos esto para que nuestra función sea más flexible para más adelante. Podemos pedirle que
calcule el GDP para:

 * El __dataset__ completo;
 * Un solo año;
 * Un solo país;
 * Una combinación única de año y país.

Al utilizar el operador `%in%`, también podemos asignarle múltiples años o países a estos
argumentos.

> ## Sugerencia: Pasar por valor
>
> Las funciones en R casi siempre hacen copias de los datos para operar dentro 
> del cuerpo de una función. Cuando modificamos `dat` dentro de la función
> estamos modificando la copia del __dataset__ gapminder almacenado en `dat`,
> y no la variable original que asignamos como el primer argumento.
>
> Eso se llama **__pasar por valor__**  y hace la escritura del código mucho más segura:
> puedes estar seguro que cualquier cambio que hagas dentro del 
> cuerpo de la función, se mantendrá dentro de la función.
{: .callout}

> ## Sugerencia: Alcance de la función
>
> Otro concepto importante es el alcance: las variables (¡o funciones!) que 
> creas o modificas dentro del cuerpo de una función sólo existen durante 
> el tiempo de ejecución de la función. Cuando llamamos `calcGDP()`, las variables `dat`,
> `gdp` y `new` sólo existen dentro del cuerpo de la función. Incluso si 
> tenemos variables con el mismo nombre en nuestra sesión interactiva de R, éstas no 
> son modificadas en ninguna manera cuando se ejecuta la función.
{: .callout}


~~~
  gdp <- dat$pop * dat$gdpPercap
  new <- cbind(dat, gdp=gdp)
  return(new)
}
~~~
{: .r}

Finalmente, calculamos GDP en nuestro nuevo subconjunto de datos, y creamos una nueva __dataframe__
con esta columna agregada. Esto significa que cuando llamamos a la función, en el resultado 
podemos ver el contexto de los valores GDP obtenidos, lo que es mucho mejor que 
nuestro primer intento cuando habíamos obtenido un vector de números. 


> ## Desafío 3
>
> Probar tu función GDP calculando el GDP para Nueva Zelandia ("New Zealand") en 1987. ¿Cómo
> difiere del GDP de Nueva Zelandia en 1952?
>
> > ## Solución al desafío 3
> >
> > 
> > ~~~
> >   calcGDP(gapminder, year = c(1952, 1987), country = "New Zealand")
> > ~~~
> > {: .r}
> > GDP para Nueva Zelandia en 1987: 65050008703
> >
> > GDP para Nueva Zelandia en 1952: 21058193787
> {: .solution}
{: .challenge}


> ## Desafío 4
>
> La función `paste()` puede ser usada para combinar texto, ej.:
>
> 
> ~~~
> buenas_practicas <- c("Escribir", "programas", "para", "personas", "no", "computadoras")
> paste(buenas_practicas, collapse=" ")
> ~~~
> {: .r}
> 
> 
> 
> ~~~
> [1] "Escribir programas para personas no computadoras"
> ~~~
> {: .output}
>
>  Escribir una función `fence()` que toma dos vectores como argumentos, llamados
> `text` y `wrapper`, e muestra el texto flanqueado del `wrapper`:
>
> 
> ~~~
> fence(text=buenas_practicas, wrapper="***")
> ~~~
> {: .r}
>
> *Nota:* la función `paste()` tiene un argumento llamado `sep`, que especifica
> el separador de texto. Por defecto es un espacio: " ". El valor por defecto de la función
> `paste0()` es sin espacio "".
>
> > ## Solución al desafío 4
> >
> >  Escribir una función `fence()` que toma dos vectores como argumentos, llamados
> > `text` y `wrapper`, e imprime el texto flanqueado del `wrapper`:
> > 
> > ~~~
> > fence <- function(text, wrapper){
> >   text <- c(wrapper, text, wrapper)
> >   result <- paste(text, collapse = " ")
> >   return(result)
> > }
> > buenas_practicas <- c("Escribir", "programas", "para", "personas", "no", "computadores")
> > fence(text=buenas_practicas, wrapper="***")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] "*** Escribir programas para personas no computadores ***"
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

> ## Sugerencia
>
> R tiene algunos aspectos únicos que pueden ser explotados cuando se realizan 
> operaciones más complicadas. No escribiremos nada que requiera el conocimiento de estos 
> conceptos más avanzados. En el futuro, cuando te sientas cómodo escribiendo funciones
> en R, puedes aprender más leyendo el
> [Manual de lenguaje de R][man] o este [capítulo][] de
> [Advanced R Programming][adv-r] de Hadley Wickham.
{: .callout}

[man]: http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Environment-objects
[capítulo]: http://adv-r.had.co.nz/Environments.html
[adv-r]: http://adv-r.had.co.nz/


> ## Sugerencia: Probar y documentar
>
> Es importante probar las funciones así como documentarlas:
> la documentación ayuda, a tí y a otros, a entender cuál es el propósito
> de la función, y cómo usarla, además de ser importante 
> para asegurarse que la función realmente hace
> lo que tu crees que hace.
>
> Cuando recién comiences, tu flujo de trabajo probablemente luzca 
> algo así:
>
>  1. Escribir una función
>  2. Comentar partes de la función para documentar su comportamiento
>  3. Cargar el archivo __source__
>  4. Experimentar con ella en la consola para asegurarte que se comporta tal como tu esperas. 
>  5. Hacer los arreglos necesarios
>  6. Volver a probar y repetir.
>
> La documentación formal para las funciones, escritas en archivos `.Rd`
> aparte, se transforman en la documentación que ves en los archivos de ayuda.
> El paquete [roxygen2][] le permite a los programadores de R escribir la
> documentación junto con el código, y luego procesarlo para generar los archivos `.Rd`
> apropiados. Quizas quieras cambiarte a este método más formal de escribir 
> la documentación cuando empieces a escribir projectos de R más complicados.
>
> Pruebas automatizadas formales se pueden escribir usando el paquete [testthat][].
{: .callout}

[roxygen2]: http://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html
[testthat]: http://r-pkgs.had.co.nz/tests.html

