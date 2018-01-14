---
layout: reference
permalink: /reference/
---

## Referencia

## [Introducción a R y RStudio]({{ page.root }}/01-rstudio-intro/)

 - Usa la tecla **escape** para cancelar comandos incompletos o código en ejecución
   (Ctrl+C) si estas usando R desde el **shell**.
 - Las operaciones aritméticas básicas siguen el orden estándar de precedencia:
   - Paréntesis: `(`, `)`
   - Exponentes: `^` or `**`
   - División: `/`
   - Multiplicación: `*`
   - Suma: `+`
   - Resta: `-`
 - La notación científica está disponible, por ejemplo: `2e-3`
 - Cualquier cosa a la derecha de `#` es un comentario, R lo ignorará!
 - Las funciones se denotan por `function_name()`. Las expresiones dentro de los paréntesis se evaluan antes de pasarse a la función, y las funciones se pueden anidar.
 - Funciones matemáticas: `exp`, `sin`, `log`, `log10`, `log2` etc.
 - Operadores de comparación: `<`, `<=`, `>`, `>=`, `==`, `!=`
 - Usa `all.equal` para comparar valores numéricos!
 - `<-` es el operador de asignación. Cualquier expresión a la derecha del operador es evaluada, luego se almacena en la variable nombrada a la izquierda.
 - `ls` lista todas las variables y funciones que has creado
 - `rm` puede utilizarse para borrarlas
 - Al asignar valores a los argumentos de la función, debes usar `=`.

## [Manejo de proyectos con RStudio]({{ page.root }}/02-project-intro/)

 - Para crear un nuevo proyecto, ve a File -> New Project
 - Instala el paquete `packrat` para crear proyectos independientes
 - `install.packages` para instalar paquetes desde CRAN
 - `library` para cargar un paquete en R
 - `packrat::status` para verificar si se han instalado todos los paquetes a los que se hacer referencia en tus **scripts**.

## [Buscando ayuda]({{ page.root }}/03-seeking-help/)

- Para acceder a la ayuda de una función `?function_name` o `help(function_name)`
- Usa comillas para operadores especiales, por ejemplo: `?"+"`
- Utiliza la búsqueda difusa si no puedes recordar un nombre '??search_term'
- [CRAN task views](http://cran.at.r-project.org/web/views) son un buen punto de partida.
- [Stack Overflow](http://stackoverflow.com/) es un buen lugar para obtener ayuda con tu código.
    - `?dput` Guardará datos que estás trabajando, para que otros puedan cargarlos fácilmente.
    - `sessionInfo()` te dará detalles de tu configuración.

## [Estructuras de datos]({{ page.root }}/04-data-structures-part1/)

Los valores atómicos en R deben ser de alguno de los 5 **tipos de datos**, múltiples valores se pueden agrupar en **estructuras de datos**.

 **Tipos de datos**

 - `typeof(object)` proporciona información sobre el tipo de dato de un objeto.
 - Existen 5 tipos de datos principales:
    - `?numeric` números reales(decimal)
    - `?integer` sólo números enteros
    - `?character` texto
    - `?complex` números complejos
    - `?logical` valores **TRUE** o **FALSE**

    **Tipos especiales:**

     - `?NA` valores faltantes
     - `?NaN` "no es número" para valores indefinidos (por ejemplo, `0/0`).
     - `?Inf`, `-Inf` infinito.
     - `?NULL` una estructura de datos que no existe

    `NA` puede ocurrir en cualquier vector atómico. `NaN`, and `Inf` sólo pueden aparecer en vectores de tipo **complex**, **integer** o **numeric**. Los vectores atómicos son los bloques de construcción para todas las demás estructuras de datos. Un valor `NULL` ocurrirá en una estructura de datos entera (pero puede ocurrir como elementos de lista).


 **Estructuras de datos básicas en R:**
  - atómico `?vector` (sólo puede conener un tipo de dato)
  - `?list` (contenedores para otros objetos)
  - `?data.frame` objetos bidimensionales cuyas columnas pueden contener diferentes tipos de datos
  - `?matrix` objeto bidimensional que puede contener sólo un tipo de dato.
  - `?factor` vectores que contienen datos categóricos predefinidos.
  - `?array` objeto multi-dimensional que puede contener sólo un tipo de dato.

 Recuerda que las matrices son realmente vectores atómicos, y que los
data.frames son realmente listas(esto explica algunos de los comportamientos extraños de R).

 **[Vectores]({{ page.root }}/04-data-structures-part1/)**
 - `?vector()` Todos los elementos del vector deben ser del mismo tipo.
 - Los elementos se pueden convertir de un tipo a otro utilizando *coercion*.
 - La función concatenar 'c()' agrega elementos al vector.
 - `seq(from=0, to=1, by=1)` crea una secuencia de números.
 - Los elementos de un vector se pueden nombrar usando la función `names()`.

 **[Factores]({{ page.root }}/04-data-structures-part1/)**
 - `?factor()` Los factores son una estructura de datos diseñada para almacenar datos categóricos.
 - `levels()` muestra los valores válidos que se pueden almacenar en un vector de tipo factor.

 **[Listas]({{ page.root }}/04-data-structures-part1/)**
 - `?list()` Las listas son una estructura de datos diseñada para almacenar datos de diferente tipo.

 **[Matrices]({{ page.root }}/04-data-structures-part1/)**
 - `?matrix()` Las matrices son una estructura de datos diseñada para almacenar datos bidimensionales.

 **[Data Frames]({{ page.root }}/05-data-structures-part2/)**
 - `?data.frame` es una estructura de datos clave. Es una  `list` de `vectors`.
 - `cbind()` agregará una columna (vector) a un data.frame.
 - `rbind()` agregará un renglón (list) a un data.frame.

 **Funciones útiles para consultar estructuras de datos:**
 - `?str` estructura, imprime un resumen de toda la estructura de datos
 - `?typeof` te dice el tipo dentro de un vector atómico
 - `?class` ¿Cuál es la estructura de datos?
 - `?head` Imprime los primeros `n` elementos (filas para objetos bidimensionales)
 - `?tail` imprime los últimos `n` elementos (filas para objetos bidimensionales)
 - `?rownames`, `?colnames`, `?dimnames` recuperar o modificar los nombres de fila y columna de un objeto.
 - `?names` recuperar omodificar los nombres de un vector o lista atómica (o columnas de un dataframe).
 - `?length` obtener el número de elementos de un vector atómico
 - `?nrow`, `?ncol`, `?dim` obtener las dimensiones de un objeto n-dimensional
   (No funcionará en vectores o listas atómicas).

## [Explorando Dataframes]({{ page.root }}/05-data-structures-part2/)

 - `read.csv` para leer datos en una estructura regular
   - `sep` argumento para especificar el separador
     - "," para valores separados por coma
     - "\t" para valores separados por tabulador
   - Otros argumentos:
     - `header=TRUE` si hay una fila de encabezado

## [Subconjunto de datos]({{ page.root }}/06-data-subsetting/)

 - Se puede acceder a los elementos por:
   - Indice
   - Nombre
   - Vectores lógicos

- `[` corchetes:
   - *extraer* elementos individuales o *subset* vectores
    - por ejemplo,`x[1]` extrae el primer elemento del vector x.
   - *extraer* elementos individuales de una lista. El valor devuelto será otra `list()`.
   - *extraer* columnas de un data.frame
 - `[` con dos argumentos para:
   - *extraer* filas y/o columnas de
     - matrices
     - data.frames
     - por ejemplo: `x[1,2]` extraerá el valor de la fila 1, columna 2.
     - por ejemplo: `x[2,:]` extraerá toda la segunda fila.

 - `[[` dobles corchetes para extraer elementos de las listas.
 - `$` para acceder a columnas o listar elementos por nombre
 - índices negativos omiten elementos

## [Control de flujo]({{ page.root }}/07-control-flow/)

 - Usa la condición `if` para iniciar una instrucción condicional, `else if` para proporcionar pruebas adicionales, y `else` para proporcionar un  valor predeterminado
 - Las instrucciones que se encuentran entre las llaves de las declaraciones condicionales deben estar indentadas.
 - Usa `==` para probar la igualdad.
 - `X && Y` sólo es cierto si tanto X como Y son `TRUE`.
 - `X || Y` es cierto si ya sea X o Y, o ambos, son `TRUE`.
 - Cero se considera `FALSE`; todos los demás numeros se consideran `TRUE`
 - Anidar loops para operar en datos multidimensionales.

## [Creación de gráficos con calidad para publicación]({{ page.root }}/08-plot-ggplot2/)

 - las figuras se pueden crear con la gramática de los gráficos:
   - `library(ggplot2)`
   - `ggplot` para crear la figura base
   - `aes`especifica la estética de los ejes de datos, la forma, color y tamaño
   - `geom`especifica el tipo de gráfico, por ejemplo, `point`, `line`, `density`, `box`
   - `geom`agrega también transformaciones estadísticas, por ejemplo. `geom_smooth`
   - `scale` functions change the mapping from data to aesthetics
   - `facet` functions stratify the figure into panels
   - `aes`thetics apply to individual layers, or can be set for the whole plot
     inside `ggplot`.
   - `theme` cambia el aspecto general del gráfico
   - order of layers matters!
   - `ggsave` para salvar una figura.

## [Vectorización]({{ page.root }}/09-vectorization/)

- Most functions and operations apply to each element of a vector
- `*` applies element-wise to matrices
- `%*%` for true matrix multiplication
- `any()` will return `TRUE` if any element of a vector is `TRUE`
- `all()` will return `TRUE` if *all* elements of a vector are `TRUE`

## [Funciones]({{ page.root }}/10-functions/)

  - `?"function"`
  - Put code whose parameters change frequently in a function, then call it with
    different parameter values to customize its behavior.
  - The last line of a function is returned, or you can use `return` explicitly
  - Any code written in the body of the function will preferably look for variables defined inside the function.
  - Document Why, then What, then lastly How (if the code isn't self explanatory)

## [Escribiendo datos]({{ page.root }}/11-writing-data/)

 - `write.table` to write out objects in regular format
 - set `quote=FALSE` so that text isn't wrapped in `"` marks

## [Split-apply-combine]({{ page.root }}/12-plyr/)

 - Use the `xxply` family of functions to apply functions to groups within
   some data.
 - the first letter, `a`rray , `d`ata.frame or `l`ist corresponds to the input data
 - the second letter denotes the output data structure
 - Anonymous functions (those not assigned a name) are used inside the `plyr` family
   of functions on groups within data.

## [Manejo de dataframe con dplyr]({{ page.root }}/13-dplyr/)
 - `library(dplyr)`
 - `?select` to extract variables by name.
 - `?filter` return rows with matching conditions.
 - `?group_by` group data by one of more variables.
 - `?summarize` summarize multiple values to a single value.
 - `?mutate` add new variables to a data.frame.
 - Combine operations using the `?"%>%"` pipe operator.

## [Manejo de dataframe con tidyr]({{ page.root }}/14-tidyr/)
- `library(tidyr)`
- '?gather' convert data from *wide* to *long* format.
- '?spread' convert data from *long* to *wide* format.
- '?separate' split a single value into multiple values.
- '?unite' merge multiple values into a single value.

## [Generando reportes con knitr]({{ page.root }}/15-knitr-markdown/)
- Value of reproducible reports
- Basics of Markdown
- R code chunks
- Chunk options
- Inline R code
- Other output formats

## [Buenas prácticas para escribir un buen código]({{ page.root }}/16-wrap-up/)

 * Program defensively, i.e., assume that errors are going to arise, and write code to detect them when they do.
 * Write tests before writing code in order to help determine exactly what that code is supposed to do.
 * Know what code is supposed to do before trying to debug it.
 * Make it fail every time.
 * Make it fail fast.
 * Change one thing at a time, and for a reason.
 * Keep track of what you've done.
 * Be humble

## Glosario

{:auto_ids}
argument
:   A value given to a function or program when it runs.
    The term is often used interchangeably (and inconsistently) with [parameter](#parameter).

assign
:   To give a value a name by associating a variable with it.

body
:   (of a function): the statements that are executed when a function runs.

comment
:   A remark in a program that is intended to help human readers understand what is going on,
    but is ignored by the computer.
    Comments in Python, R, and the Unix shell start with a `#` character and run to the end of the line;
    comments in SQL start with `--`,
    and other languages have other conventions.

comma-separated values
:   (CSV) A common textual representation for tables
    in which the values in each row are separated by commas.

delimiter
:   A character or characters used to separate individual values,
    such as the commas between columns in a [CSV](#comma-separated-values) file.

documentation
:   Human-language text written to explain what software does,
    how it works, or how to use it.

floating-point number
:   A number containing a fractional part and an exponent.
    See also: [integer](#integer).

for loop
:   A loop that is executed once for each value in some kind of set, list, or range.
    See also: [while loop](#while-loop).

index
:   A subscript that specifies the location of a single value in a collection,
    such as a single pixel in an image.

integer
:   A whole number, such as -12343. See also: [floating-point number](#floating-point-number).

library
:   In R, the directory(ies) where [packages](#package) are stored.

package
:   A collection of R functions, data and compiled code in a well-defined format. Packages are stored in a [library](#library) and loaded using the library() function.

parameter
:   A variable named in the function's declaration that is used to hold a value passed into the call.
    The term is often used interchangeably (and inconsistently) with [argument](#argument).

return statement
:   A statement that causes a function to stop executing and return a value to its caller immediately.

sequence
:   A collection of information that is presented in a specific order.

shape
:   An array's dimensions, represented as a vector.
    For example, a 5×3 array's shape is `(5,3)`.

string
:   Short for "character string",
    a [sequence](#sequence) of zero or more characters.

syntax error
:  Un error de programación que ocurre cuando las instrucciones están en un orden o contienen caracteres no esperados por el lenguaje de programación.

type
:   La clasificación de algo en un programa (por ejemplo, el contenido de una variable)
    como un tipo de número (por ejemplo [floating-point](#float), [integer](#integer)), [string](#string),
    o algo más. En R el comando typeof() se usa para consultar el tipo de una variable.

while loop
:   Un bucle que se ejecuta siempre que una condición dada sea verdadera.
    See also: [for loop](#for-loop).
