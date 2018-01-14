---
title: "Estructuras de datos"
teaching: 40
exercises: 15
questions:
- "¿Cómo puedo leer datos en R?"
- "¿Cuáles son los tipos de datos básicos en R?"
- "¿Cómo represento la información categórica en R?"
objectives:
- "Conocer los distintos tipos de datos."
- "Comenzar a explorar los *data frames* y entender cómo se relacionan con **vectors**, **factors** y **lists**."
- "Ser capaz de preguntar sobre el tipo, clase y estructura de un objeto en R."
keypoints:
- "Usar `read.csv` para leer los datos tabulares en R."
- "Los tipos de datos básicos en R son **double**, **integer**, **complex**, **logical**, y **character**."
- "Usa **factors** para representar categorías en R."
source: Rmd
---


Una de las características más poderosas de R es su habilidad de manejar datos tabulares -
como los que puedes tener en una planilla de cálculo o un archivo CSV. Comencemos creando un **dataset** de ejemplo
en tu directorio `datos/`, en el archivo llamado `feline-data.csv`:


~~~
pelaje,peso,likes_string
cálico,2.1,1
negro,5.0,0
atigrado,3.2,1
~~~
{: .r}

> ## Consejo: Edición de archivos de texto en R
>
> Alternativamente, puedes crear el archivo `datos/datos-felinos.csv` usando un editor de texto (Nano),
> o en RStudio usando el ítem del Menú  **File -> New File -> Text File**.
{: .callout}


Podemos leer el archivo en R con el siguiente comando:


~~~
gatos <- read.csv(file = "datos/datos-felinos.csv")
gatos
~~~
{: .r}



~~~
    pelaje peso likes_string
1 cálico    2.1            1
2  negro    5.0            0
3  atigrado    3.2            1
~~~
{: .output}

La función `read.table` se usa para leer datos tabulares que están guardados en un archivo de texto,
donde las columnas de datos están separadas por un signo de puntuación como en los archivos
CSV (donde **csv** es **comma-separated values** en inglés, es decir, valores separados por comas).

Los signos de puntuación más comunes usados para separar o delimitar datos en archivos de texto son tabuladores y comas.
Por conveniencia, R provee dos versiones de la función `read.table`. Estas versiones son: `read.csv`
para archivos donde los datos están separados por comas y `read.delim` para archivos donde los datos están separados
por tabuladores. De las tres variantes, `read.csv` es la usada más comúnmente. De ser necesario, es posible sobrescribir
 el signo de puntuación usado por defecto para ambas funciones: `read.csv` y `read.delim`.


Podemos empezar a explorar el **dataset** inmediatamente, proyectando las columnas usando el operador `$`:


~~~
gatos$peso
~~~
{: .r}



~~~
[1] 2.1 5.0 3.2
~~~
{: .output}



~~~
gatos$pelaje
~~~
{: .r}



~~~
[1] cálico negro  atigrado
Levels: negro cálico atigrado
~~~
{: .output}

Podemos efectuar otras operaciones a las columnas:


~~~
## Considera que descubrimos que la balanza pesa dos kilos menos:
gatos$peso + 2
~~~
{: .r}



~~~
[1] 4.1 7.0 5.2
~~~
{: .output}



~~~
paste("Mi gato es", gatos$pelaje)
~~~
{: .r}



~~~
[1] "Mi gato es cálico" "Mi gato es negro"  "Mi gato es atigrado"
~~~
{: .output}

Pero qué pasa con:


~~~
cats$weight + cats$coat
~~~
{: .r}



~~~
Warning in Ops.factor(cats$weight, cats$coat): '+' not meaningful for
factors
~~~
{: .error}



~~~
[1] NA NA NA
~~~
{: .output}

Entender qué es lo que pasa en este case es clave para analizar datos en R exitosamente.

## Tipos de datos

Si adivinaste que el último comando iba a resultar en un error porque `2.1` más
`"black"` no tiene sentido, estás en lo cierto - y ya tienes alguna intuición sobre un concepto
importante en programación que se llama *tipos de datos*. Podemos preguntar cuál es el tipo de datos de algo:


~~~
typeof(gatos$peso)
~~~
{: .r}



~~~
[1] "double"
~~~
{: .output}

Hay 5 tipos de datos principales: `double`, `integer`, `complex`, `logical` and `character`.


~~~
typeof(3.14)
~~~
{: .r}



~~~
[1] "double"
~~~
{: .output}



~~~
typeof(1L) # The L suffix forces the number to be an integer, since by default R uses float numbers
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}



~~~
typeof(1+1i)
~~~
{: .r}



~~~
[1] "complex"
~~~
{: .output}



~~~
typeof(TRUE)
~~~
{: .r}



~~~
[1] "logical"
~~~
{: .output}



~~~
typeof('banana')
~~~
{: .r}



~~~
[1] "character"
~~~
{: .output}

No importa cuan complicado sea nuestro análisis, todos los datos en R se interpretan con uno de estos
tipos de datos básicos. Este rigor tiene algunas consecuencias importantes.

Un usuario ha agregado detalles de otro gato. Esta información está en el archivo
`datos/datos-felinos_v2.csv`.



~~~
file.show("datos/datos-felinos_v2.csv")
~~~
{: .r}


~~~
coat,weight,likes_string
calico,2.1,1
black,5.0,0
tabby,3.2,1
tabby,2.3 or 2.4,1
~~~
{: .r}

Carga los datos de los nuevos gatos de la misma forma anterior, y comprueba qué tipos de datos encuentras en la columna
`weight`:


~~~
cats <- read.csv(file="datos/datos-felinos_v2.csv")
typeof(cats$weight)
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}

Oh no, nuestros pesos ya no son de tipo **double**! Si intentamos hacer los mismos cálculos anteriores, tenemos problemas:

~~~
cats$weight + 2
~~~
{: .r}



~~~
Warning in Ops.factor(cats$weight, 2): '+' not meaningful for factors
~~~
{: .error}



~~~
[1] NA NA NA NA
~~~
{: .output}


¿Qué ocurrió? Cuando R lee un archivo CSV en una de estas tablas, insiste que todas
las columnas sean del mismo tipo de datos básico; si no puede entender todos los
elementos en la columna como **double**, entonces ningún elemento de la columna
se interpreta como **double**.

La tabla que R cargó con los datos de los gatos se denomina un
**data.frame**, y es nuestro primer ejemplo de algo que se llama una *estructura de datos* -
 es decir, una estructura que R sabe cómo construir basada en tipos de datos básicos.

Podemos ver que es un **data.frame** si usamos la función **`class`**:


~~~
class(cats)
~~~
{: .r}



~~~
[1] "data.frame"
~~~
{: .output}


Para usar nuestros datos en R exitosamente, necesitamos entender cuáles son las estructuras de datos
básicas, y cómo se comportan. Por ahora, eliminemos la línea extra de los datos sobre gatos y volvamos
a leer el archivo para investigar el comportamiento más en detalle:


datos-felinos.csv:

```
coat,weight,likes_string
calico,2.1,1
black,5.0,0
tabby,3.2,1
```

Y en RStudio:


~~~
cats <- read.csv(file="datos/datos-felinos.csv")
~~~
{: .r}


## Vectores y Coerción de Tipos

Para entender mejor este comportamiento, veamos otra de las estructuras de datos en R: el **vector**.

~~~
my_vector <- vector(length = 3)
my_vector
~~~
{: .r}



~~~
[1] FALSE FALSE FALSE
~~~
{: .output}

Un vector en R es esencialmente una lista ordenada de cosas, con la condición especial de que *todos los elementos en un vector
tienen que ser del mismo tipo de datos básico*. Si no eliges un tipo de datos, por defecto R elige el tipo de datos **logical**.
También puedes declarar un vector vacío de cualquier tipo que quieras.


~~~
another_vector <- vector(mode='character', length=3)
another_vector
~~~
{: .r}



~~~
[1] "" "" ""
~~~
{: .output}

You can check if something is a vector:


~~~
str(another_vector)
~~~
{: .r}



~~~
 chr [1:3] "" "" ""
~~~
{: .output}

La salida algo críptica de este comando indica el tipo de datos básico encontrado en este vector, en este caso `chr` o **character**;
una indicación del número de elementos en el vector - específicamente los índices del vector, en este caso `[1:3]`; y unos pocos ejemplos
de los elementos del vector - en este caso **strings** vacías.

Si, en forma similar, hacemos:


~~~
str(cats$weight)
~~~
{: .r}



~~~
 num [1:3] 2.1 5 3.2
~~~
{: .output}

podemos ver que `cats$weight` también es un vector - *las columnas de datos que cargamos en **data.frames** de R son todas vectores*
y este es el motivo por el cuál R requiere que todas las columnas sean del mismo tipo de datos básico.


> ## Discusión 1
>
> Why is R so opinionated about what we put in our columns of data?
> How does this help us?
>
> > ## Discusión 1
> >
> > Al mantener todos los elementos de una columna del mismo tipo, podemos hacer suposiciones simples sobre nuestros datos;
> > si puedes interpretar un elemento en una columna como un número, entonces puedes interpretar *todos* los elementos como números,
> > y por tanto no hace falta comprobarlo cada vez.
> > Esta consistencia es lo que se suele mencionar como *datos limpios*;
> > a la large, la consistencia estricta hace nuestras vidas más fáciles cuando usamos R.
> {: .solution}
{: .discussion}

También puedes crear vectores con contenido explícito con la función **combine**:

~~~
combine_vector <- c(2,6,3)
combine_vector
~~~
{: .r}



~~~
[1] 2 6 3
~~~
{: .output}

Dado lo que aprendidmos hasta ahora, ¿qué te parece que el siguiente código va a producir?


~~~
quiz_vector <- c(2,6,'3')
~~~
{: .r}

Esto se denomina *coerción de tipos de datos* y es motivo de muchas sorpresas y la razón por la cual es necesario conocer
los tipos de datos básicos y cómo R los interpreta. Cuando R encuentra una mezcla de tipos de datos (en este caso númerico y caracteres)
para combinarlos en un vector, va a forzarlos a ser del mismo tipo.

Considera:


~~~
coercion_vector <- c('a', TRUE)
coercion_vector
~~~
{: .r}



~~~
[1] "a"    "TRUE"
~~~
{: .output}



~~~
another_coercion_vector <- c(0, TRUE)
another_coercion_vector
~~~
{: .r}



~~~
[1] 0 1
~~~
{: .output}

Las reglas de coerción son: `logical` -> `integer` -> `numeric` -> `complex` ->
`character`, donde -> se puede leer como *se transforma en*.
Puedes intentar forzar la coerción de acuerdo a esta cadena usando las funciones `as.`:


~~~
character_vector_example <- c('0','2','4')
character_vector_example
~~~
{: .r}



~~~
[1] "0" "2" "4"
~~~
{: .output}



~~~
character_coerced_to_numeric <- as.numeric(character_vector_example)
character_coerced_to_numeric
~~~
{: .r}



~~~
[1] 0 2 4
~~~
{: .output}



~~~
numeric_coerced_to_logical <- as.logical(character_coerced_to_numeric)
numeric_coerced_to_logical
~~~
{: .r}



~~~
[1] FALSE  TRUE  TRUE
~~~
{: .output}

Como puedes ver, algunas cosas sorprendentes ocurren cuando R fuerza un tipo de datos en otro tipo!
Dejando de lado los detalles de la coerción, la cuestión es: si tus datos no lucen como pensabas que
deberían lucir, puede ser culpa de la coerción de tipos;  asegúrate que todos los elementos de tus vectores
son y las columnas de tus **data.frames** son del mismo tipo o te encontrarás con sorpresas desagradables!

Pero la coerción de tipos también puede ser muy útil. Por ejemplo, en los datos de `cats`,
`likes_string` es numérica, pero sabemos que los 1s y 0s en realidad representan **`TRUE`** y **`FALSE`**
(una forma habitual de representarlos). Deberíamos usar el tipo de datos
**`logical`** en este caso, que tiene dos estados: **`TRUE`** o **`FALSE`**, que es exactamente
lo que nuestros datos representan. Podemos

Podemos convertir esta columna al tipo de datos **`logical`** usando la función `as.logical`:


~~~
cats$likes_string
~~~
{: .r}



~~~
[1] 1 0 1
~~~
{: .output}



~~~
cats$likes_string <- as.logical(cats$likes_string)
cats$likes_string
~~~
{: .r}



~~~
[1]  TRUE FALSE  TRUE
~~~
{: .output}

La función **combine**, `c()`, también agregará elementos al final de un vector existente:


~~~
ab_vector <- c('a', 'b')
ab_vector
~~~
{: .r}



~~~
[1] "a" "b"
~~~
{: .output}



~~~
combine_example <- c(ab_vector, 'SWC')
combine_example
~~~
{: .r}



~~~
[1] "a"   "b"   "SWC"
~~~
{: .output}


También puedes hacer una serie de números:


~~~
mySeries <- 1:10
mySeries
~~~
{: .r}



~~~
 [1]  1  2  3  4  5  6  7  8  9 10
~~~
{: .output}



~~~
seq(10)
~~~
{: .r}



~~~
 [1]  1  2  3  4  5  6  7  8  9 10
~~~
{: .output}



~~~
seq(1,10, by=0.1)
~~~
{: .r}



~~~
 [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3
[15]  2.4  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7
[29]  3.8  3.9  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1
[43]  5.2  5.3  5.4  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5
[57]  6.6  6.7  6.8  6.9  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9
[71]  8.0  8.1  8.2  8.3  8.4  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3
[85]  9.4  9.5  9.6  9.7  9.8  9.9 10.0
~~~
{: .output}

Podemos preguntar algunas cosas sobre los vectores:


~~~
sequence_example <- seq(10)
head(sequence_example, n=2)
~~~
{: .r}



~~~
[1] 1 2
~~~
{: .output}



~~~
tail(sequence_example, n=4)
~~~
{: .r}



~~~
[1]  7  8  9 10
~~~
{: .output}



~~~
length(sequence_example)
~~~
{: .r}



~~~
[1] 10
~~~
{: .output}



~~~
class(sequence_example)
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}



~~~
typeof(sequence_example)
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}

Finalmente,puedes darle nombres a los elementos de tu vector:


~~~
my_example <- 5:8
names(my_example) <- c("a", "b", "c", "d")
my_example
~~~
{: .r}



~~~
a b c d 
5 6 7 8 
~~~
{: .output}



~~~
names(my_example)
~~~
{: .r}



~~~
[1] "a" "b" "c" "d"
~~~
{: .output}

> ## Desafío 1
>
> Comienza construyendo un vector con los números del 1 al 26.
> Multiplica el vector por 2 y asigna al vector resultante los nombres A hasta Z
> (Pista: hay un vector pre-definido llamado **`LETTERS`**)
>
> > ## Solución del desafío 1
> >
> > 
> > ~~~
> > x <- 1:26
> > x <- x * 2
> > names(x) <- LETTERS
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


## Data Frames

Ya mencionamos que las columnas en los **data.frames** son vectores:


~~~
str(cats$weight)
~~~
{: .r}



~~~
 num [1:3] 2.1 5 3.2
~~~
{: .output}



~~~
str(cats$likes_string)
~~~
{: .r}



~~~
 logi [1:3] TRUE FALSE TRUE
~~~
{: .output}

Esto tiene sentido, pero qué pasa con:


~~~
str(cats$coat)
~~~
{: .r}



~~~
 Factor w/ 3 levels "black","calico",..: 2 1 3
~~~
{: .output}

## Factores

Otra estructura de datos importante se llama un **factor**. Factores usualmente
parecen caracteres, pero se usan para representar información categórica. Por ejemplo,
construyamos un vector de **strings** con etiquetas para las coloraciones para todos los
gatos en nuestro estudio:


~~~
coats <- c('tabby', 'tortoiseshell', 'tortoiseshell', 'black', 'tabby')
coats
~~~
{: .r}



~~~
[1] "tabby"         "tortoiseshell" "tortoiseshell" "black"        
[5] "tabby"        
~~~
{: .output}



~~~
str(coats)
~~~
{: .r}



~~~
 chr [1:5] "tabby" "tortoiseshell" "tortoiseshell" "black" "tabby"
~~~
{: .output}

Podemos convertir un vector en un **factor** de la siguiente manera:


~~~
CATegories <- factor(coats)
class(CATegories)
~~~
{: .r}



~~~
[1] "factor"
~~~
{: .output}



~~~
str(CATegories)
~~~
{: .r}



~~~
 Factor w/ 3 levels "black","tabby",..: 2 3 3 1 2
~~~
{: .output}

Ahora R puede interpretar que hay tres posibles categorías en nuestros datos - pero también
hizo algo sorprendente; en lugar de imprimir las **strings** como se las dimos, imprimió una
serie de números. R ha reemplazado las categorías con índices numéricos, lo cuál es necesario porque
muchos cálculos estadísticos usan esa representación para datos categóricos:


~~~
typeof(coats)
~~~
{: .r}



~~~
[1] "character"
~~~
{: .output}



~~~
typeof(CATegories)
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}

> ## Desafío 2
>
> ¿Hay algún un **factor** en nuestro **data.frame** `cats`? ¿Cuál es el nombre?
> Intenta usar `?read.csv` para darte cuenta cómo mantener las columnas de texto como vectores de caracteres
> en lugar de factores; luego escribe uno o más comandos para mostrar que el **factor** en
> `cats` es en realidad un vector de caracteres cuando se carga de esta manera.
>
> > ## Solución al desafío 2
> >
> > One solution is use the argument `stringAsFactors`:
> >
> > 
> > ~~~
> > cats <- read.csv(file="datos/datos-felinos.csv", stringsAsFactors=FALSE)
> > str(cats$coat)
> > ~~~
> > {: .r}
> >
> > Another solution is use the argument `colClasses`
> > that allow finer control.
> >
> > 
> > ~~~
> > cats <- read.csv(file="datos/datos-felinos.csv", colClasses=c(NA, NA, "character"))
> > str(cats$coat)
> > ~~~
> > {: .r}
> >
> > Note: new students find the help files difficult to understand; make sure to let them know
> > that this is typical, and encourage them to take their best guess based on semantic meaning,
> > even if they aren't sure.
> {: .solution}
{: .challenge}

In modelling functions, it's important to know what the baseline levels are. This
is assumed to be the first factor, but by default factors are labelled in
alphabetical order. You can change this by specifying the levels:


~~~
mydata <- c("case", "control", "control", "case")
factor_ordering_example <- factor(mydata, levels = c("control", "case"))
str(factor_ordering_example)
~~~
{: .r}



~~~
 Factor w/ 2 levels "control","case": 2 1 1 2
~~~
{: .output}

In this case, we've explicitly told R that "control" should represented by 1, and
"case" by 2. This designation can be very important for interpreting the
results of statistical models!

## Listas

Another data structure you'll want in your bag of tricks is the `list`. A list
is simpler in some ways than the other types, because you can put anything you
want in it:


~~~
list_example <- list(1, "a", TRUE, 1+4i)
list_example
~~~
{: .r}



~~~
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 1+4i
~~~
{: .output}



~~~
another_list <- list(title = "Numbers", numbers = 1:10, data = TRUE )
another_list
~~~
{: .r}



~~~
$title
[1] "Numbers"

$numbers
 [1]  1  2  3  4  5  6  7  8  9 10

$data
[1] TRUE
~~~
{: .output}

We can now understand something a bit surprising in our data.frame; what happens if we run:


~~~
typeof(cats)
~~~
{: .r}



~~~
[1] "list"
~~~
{: .output}

We see that data.frames look like lists 'under the hood' - this is because a
data.frame is really a list of vectors and factors, as they have to be - in
order to hold those columns that are a mix of vectors and factors, the
data.frame needs something a bit more flexible than a vector to put all the
columns together into a familiar table.  In other words, a `data.frame` is a
special list in which all the vectors must have the same length.

In our `cats` example, we have an integer, a double and a logical variable. As
we have seen already, each column of data.frame is a vector.


~~~
cats$coat
~~~
{: .r}



~~~
[1] calico black  tabby 
Levels: black calico tabby
~~~
{: .output}



~~~
cats[,1]
~~~
{: .r}



~~~
[1] calico black  tabby 
Levels: black calico tabby
~~~
{: .output}



~~~
typeof(cats[,1])
~~~
{: .r}



~~~
[1] "integer"
~~~
{: .output}



~~~
str(cats[,1])
~~~
{: .r}



~~~
 Factor w/ 3 levels "black","calico",..: 2 1 3
~~~
{: .output}

Each row is an *observation* of different variables, itself a data.frame, and
thus can be composed of elements of different types.


~~~
cats[1,]
~~~
{: .r}



~~~
    coat weight likes_string
1 calico    2.1         TRUE
~~~
{: .output}



~~~
typeof(cats[1,])
~~~
{: .r}



~~~
[1] "list"
~~~
{: .output}



~~~
str(cats[1,])
~~~
{: .r}



~~~
'data.frame':	1 obs. of  3 variables:
 $ coat        : Factor w/ 3 levels "black","calico",..: 2
 $ weight      : num 2.1
 $ likes_string: logi TRUE
~~~
{: .output}

> ## Desafío 3
>
> Hay varias maneras sutílmente diferentes de indicar variables, observaciones y elementos de **data.frames**:
>
> - `cats[1]`
> - `cats[[1]]`
> - `cats$coat`
> - `cats["coat"]`
> - `cats[1, 1]`
> - `cats[, 1]`
> - `cats[1, ]`
>
> Investiga cada uno de los ejemplos anteriores y explica el resultado de cada uno.
>
> *Sugerencia:* Usa la función **`typeof()`** para examinar el resultado en cada caso.
>
> > ## Solución al desafío 3
> > 
> > ~~~
> > cats[1]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >     coat
> > 1 calico
> > 2  black
> > 3  tabby
> > ~~~
> > {: .output}
> > Podemos interpretar un **data frame** como una lista de vectores. Un único par de corchetes `[1]`
> resulta en la primer proyección de la lista, como otra lista. En este caso es la primer columna del
> **data frame**.
> > 
> > ~~~
> > cats[[1]]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] calico black  tabby 
> > Levels: black calico tabby
> > ~~~
> > {: .output}
> > The double brace `[[1]]` returns the contents of the list item. In this case
> it is the contents of the first column, a _vector_ of type _factor_.
> > 
> > ~~~
> > cats$coat
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] calico black  tabby 
> > Levels: black calico tabby
> > ~~~
> > {: .output}
> > This example uses the `$` character to address items by name. _coat_ is the
> first column of the data frame, again a _vector_ of type _factor_.
> > 
> > ~~~
> > cats["coat"]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >     coat
> > 1 calico
> > 2  black
> > 3  tabby
> > ~~~
> > {: .output}
> > Here we are using a single brace `["coat"]` replacing the index number with
> the column name. Like example 1, the returned object is a _list_.
> > 
> > ~~~
> > cats[1, 1]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] calico
> > Levels: black calico tabby
> > ~~~
> > {: .output}
> > This example uses a single brace, but this time we provide row and column
> coordinates. The returned object is the value in row 1, column 1. The object
> is an _integer_ but because it is part of a _vector_ of type _factor_, R
> displays the label "calico" associated with the integer value.
> > 
> > ~~~
> > cats[, 1]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] calico black  tabby 
> > Levels: black calico tabby
> > ~~~
> > {: .output}
> > Like the previous example we use single braces and provide row and column
> coordinates. The row coordinate is not specified, R interprets this missing
> value as all the elements in this _column_ _vector_.
> > 
> > ~~~
> > cats[1, ]
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >     coat weight likes_string
> > 1 calico    2.1         TRUE
> > ~~~
> > {: .output}
> > Again we use the single brace with row and column coordinates. The column
> coordinate is not specified. The return value is a _list_ containing all the
> values in the first row.
> {: .solution}
{: .challenge}

## Matrices

Finalmente está la matriz. Podemos declarar una matriz llena de ceros:


~~~
matrix_example <- matrix(0, ncol=6, nrow=3)
matrix_example
~~~
{: .r}



~~~
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    0    0    0    0    0    0
[2,]    0    0    0    0    0    0
[3,]    0    0    0    0    0    0
~~~
{: .output}

Y de manera similar a otras estructuras de datos, podemos preguntar cosas sobre la matriz:


~~~
class(matrix_example)
~~~
{: .r}



~~~
[1] "matrix"
~~~
{: .output}



~~~
typeof(matrix_example)
~~~
{: .r}



~~~
[1] "double"
~~~
{: .output}



~~~
str(matrix_example)
~~~
{: .r}



~~~
 num [1:3, 1:6] 0 0 0 0 0 0 0 0 0 0 ...
~~~
{: .output}



~~~
dim(matrix_example)
~~~
{: .r}



~~~
[1] 3 6
~~~
{: .output}



~~~
nrow(matrix_example)
~~~
{: .r}



~~~
[1] 3
~~~
{: .output}



~~~
ncol(matrix_example)
~~~
{: .r}



~~~
[1] 6
~~~
{: .output}

> ## Desafío 4
>
> ¿Cuál crees que es el resultado del comando
> `length(matrix_example)`?
> Inténtalo.
> ¿Estabas en lo correcto? ¿Por qué / por qué no?
>
> > ## Solución al desafío 4
> >
> > ¿Cuál crees que es el resultado del comando
> > `length(matrix_example)`?
> >
> > 
> > ~~~
> > matrix_example <- matrix(0, ncol=6, nrow=3)
> > length(matrix_example)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] 18
> > ~~~
> > {: .output}
> >
> > Because a matrix is a vector with added dimension attributes, `length`
> > gives you the total number of elements in the matrix.
> {: .solution}
{: .challenge}


> ## Desafío 5
>
> Construye otra matriz, esta vez conteniendo los números 1:50,
> con 5 columnas y 10 renglones.
> ¿Cómo va completando la matriz la función **`matrix`**? ¿Cuál es el comportamiento por defector: por columna or por renglón?
> Investiga como cambiar este comportamento.
> (Sugerencia: lee la documentación de la función **`matrix`**.)
>
> > ## Solución al desafío 5
> >
> > Construye otra matriz, esta vez conteniendo los números 1:50,
> > con 5 columnas y 10 renglones.
> > ¿Cómo va completando la matriz la función **`matrix`**? ¿Cuál es el comportamiento por defector: por columna or por renglón?
> > Investiga como cambiar este comportamento.
> > (Sugerencia: lee la documentación de la función **`matrix`**.)
> >
> > 
> > ~~~
> > x <- matrix(1:50, ncol=5, nrow=10)
> > x <- matrix(1:50, ncol=5, nrow=10, byrow = TRUE) # to fill by row
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


> ## Desafío 6
>  Crea una lista de longitud dos que contenga un vector de caracteres para cada una de las secciones en esta parte del curso:
>
>  - tipos de datos
>  - estructura de datos
>
>  Inicializa cada vector de caracteres con los nombres de los tipos de datos y estructuras de datos
>  que hemos visto hasta ahora.
>
> > ## Solución al desafío 6
> > 
> > ~~~
> > dataTypes <- c('double', 'complex', 'integer', 'character', 'logical')
> > dataStructures <- c('data.frame', 'vector', 'factor', 'list', 'matrix')
> > answer <- list(dataTypes, dataStructures)
> > ~~~
> > {: .r}
> > Nota: es útil hacer una lista en el pizarrón o en papel colgado en la pared listando
> > todos los tipos y estructuras de datos y mantener la lista durante el resto del curso
> > para recordar la importancia de estos elementos básicos.
> >
> {: .solution}
{: .challenge}


> ## Desafío 7
>
> Considera la salida de R para la siguiente matriz:
> 
> ~~~
>      [,1] [,2]
> [1,]    4    1
> [2,]    9    5
> [3,]   10    7
> ~~~
> {: .output}
> ¿Cuál era el comando correcto para escribir esta matriz? Examina
> cada comando e intenta determinar el correcto antes de escribirlos.
> Piensa sobre las matrices que cada comando produce.
>
> 1. `matrix(c(4, 1, 9, 5, 10, 7), nrow = 3)`
> 2. `matrix(c(4, 9, 10, 1, 5, 7), ncol = 2, byrow = TRUE)`
> 3. `matrix(c(4, 9, 10, 1, 5, 7), nrow = 2)`
> 4. `matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)`
>
> > ## Solución al desafío 7
> >
> > Considera la salida de R para la siguiente matriz:
> > 
> > ~~~
> >      [,1] [,2]
> > [1,]    4    1
> > [2,]    9    5
> > [3,]   10    7
> > ~~~
> > {: .output}
> > ¿Cuál era el comando correcto para escribir esta matriz? Examina
> > cada comando e intenta determinar el correcto antes de escribirlos.
> > Piensa sobre las matrices que cada comando produce.
> > 
> > ~~~
> > matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}
