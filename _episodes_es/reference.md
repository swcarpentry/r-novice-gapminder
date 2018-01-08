---
layout: reference
permalink: /reference/
---

## Referencia

## [Introducción a R y RStudio]({{ page.root }}/01-rstudio-intro/)

 - Usa la tecla de escape para cancelar comandos incompletos o para ejecutar el código (Ctrl+C) si tu estas usando R desde la terminal. 
- Operaciones aritmeticas básicas tienen el siguiente orden de preferencia:
   - Parentesis: `(`, `)`
   - Exponentes: `^` o `**`
   - División: `/`
   - Multiplicación `*`
   - Suma: `+`
   - Resta: `-`
 - La notación científica está disponible, ejemplo: `2e-3`  
 - Cualquier cosa a la derecha de `#`  es un comentario, ¡R lo va a ignorar!
 - Las funciones son anotadas por `function_name()`. Las expresiones adentro
 de los parentesis se evalúan antes de pasarse a la función, y las funciones se pueden anidar.
 - Funciones matemáticas: `exp`, `sin`, `log`, `log10`, `log2` etc.
 - Operadores de comparación:  `<`, `<=`, `>`, `>=`, `==`, `!=`
 - ¡Usar `all.equal` para comparar numeros!
 - `<-` es el operador de asignamiento. Cualquier cosa a la derecha será evaluado, y después almacenado en la variable con el nombre de la izquierda.   
 - `ls` enlista todas las variables y funciones que has creado.
 - `rm` puede ser usado para eliminarlas.
 - Al asignar valores a los argumentos de la función, _debes_ usar `=`.


## [Gestión de proyectos con RStudio]({{ page.root }}/02-project-intro/)

- Para crear un nuevo proyecto, vaya a Archivo -> Nuevo proyecto.
- Instalar el paquete `packrat` para crear proyectos autocontenidos.
- `install.packages` para instalar paquetes de CRAN.
- `library` para cargar un paquete en R.
- `packrat :: status` para verificar si todos los paquetes referenciados en su
 los scripts han sido instalados.

## [Buscando ayuda]({{ page.root }}/03-seeking-help/)

- Para acceder a la ayuda de una función escriba `?function_name` o `help(function_name) `
- Utilice comillas para operadores especiales, ejemplo. `?"+"`
- Utilice la búsqueda amplia si no puede recordar un nombre '??search_term'
- [CRAN task views](http://cran.at.r-project.org/web/views) son un buen punto de partida.
- [Stack Overflow](http://stackoverflow.com/) es un buen lugar para obtener ayuda con tu código.
  - `?dput` va a escribir un archivo de texto con los datos que está trabajando para que otros puedan cargarlos fácilmente.
  - `sessionInfo()` dará detalles de tu configuración que otros podrían necesitar para la depuración.

## [Estructuras de datos]({{ page.root }}/04-data-structures-part1/)

Los valores individuales en R deben pertenecer a uno de los 5 **tipos de datos**, los valores múltiples se pueden agrupar en **estructuras de datos**.

**Tipos de datos**

- `typeof(object)` proporciona información sobre el tipo de datos de un elemento.
- Hay 5 tipos de datos principales:
    - `?numeric` números reales (decimales).
    - `?integer` números enteros `enteros` solamente.
    - `?character` texto.
    - `?complex` números complejos.
    - `?logical` valores TRUE/FALSE.

**Tipos especiales:**

- `?NA` datos no disponibles.
- `?NaN` "no es un número" (del ingles "Not a Number") para valores indefinidos (por ejemplo,` 0/0`).
- `?Inf`, `-Inf` infinito.
- `NULL` una estructura de datos que no existe

`NA` puede ocurrir en cualquier vector atómico. `NaN`, y` Inf` solo pueden
ocurren en vectores de tipo complejo, entero o numérico. Los vectores atómicos
son los bloques base para todas las demás estructuras de datos. Un valor `NULL` ocurrirá en lugar de una estructura de datos completa (pero puede ocurrir como lista
elementos).

**Estructuras básicas de datos en R:**
- `?vector` atómico (solo puede contener un tipo).
- `?list` (contenedor para otros objetos).
- ``data.frame` objetos bidimensionales cuyas columnas pueden contener diferentes tipos de datos.
- ``matrix` objetos bidimensionales que pueden contener solo un tipo de datos.
- ``factor` vectores que contienen datos categóricos predefinidos.
- `?array` objetos multidimensionales que solo pueden contener un tipo de datos.

Recuerde que las matrices son realmente vectores atómicos al final de cuentas, y que los
data.frames son realmente listas (esto explica algunos de los más extraños
comportamiento de R).

**[Vectores]({{page.root}}/04-Estructura-de-datos-parte1/)**
- `?vector()` Todos los elementos en un vector deben ser del mismo tipo.
- Los elementos se pueden convertir de un tipo a otro usando *coerción*.
- La función de concatenación 'c()' agregará elementos a un vector.
- `seq(from = 0, to = 1, by = 1)` creará una secuencia de números.
- Los elementos en un vector se pueden nombrar usando la función `names()`.

**[Factores]({{page.root}}/04-Estructura-de-datos-parte1/)**
- `?factor()` Los factores son una estructura de datos diseñada para almacenar datos categóricos.
- `levels()` muestra los valores válidos que se pueden almacenar en un vector de tipo factor.

**[Listas]({{page.root}}/04-Estructura-de-datos-parte1/)**
- ``list() `Las listas son una estructura de datos diseñada para almacenar datos de diferentes tipos.

**[Matrices]({{page.root}}/04-Estructura-de-datos-parte1/)**
- `?matrix()` Las matrices son una estructura de datos diseñada para almacenar datos bidimensionales.

**[Data Frame]({{page.root}}/05-Estructura-de-datos-parte2/) **
- `?data.frame` es una estructura de datos clave. Es una `lista` de `vectores`.
- `cbind()` agregará una columna (vector) a un data.frame.
- `rbind()` agregará una fila (lista) a un data.frame.

**Funciones útiles para consultar estructuras de datos: **
- estructura `?str`, imprime un resumen de toda la estructura de datos.
- `?typeof` te dice el tipo dentro de un vector atómico.
- `?class` ¿cuál es la estructura de datos?
- `?head` imprime los primeros elementos `n` (filas para objetos bidimensionales).
- `?tail` imprime los últimos elementos `n` (filas para objetos bidimensionales).
- `?rownames`,`?colnames`, `?dimnames` recupera o modifica los nombres de la fila o de la columna de un objeto.
- `?names` recupera o modifica los nombres de un vector o lista atómica (o
columnas de un data.frame).
- `?length` obtiene la cantidad de elementos en un vector atómico.
- `?nrow`,`?ncol`, `?dim` obtiene las dimensiones de un objeto n-dimensional
(No funcionará en vectores o listas atómicas).

## [Explorando los data frames]({{ page.root }}/05-data-structures-part2/)

- `read.csv` para leer datos en una estructura regular
  - `sep` es un argumento para especificar el tipo de separador
    - "," para archivos separados por comas
    - "\t" para archivos separados por tab
  - Otros argumentos:
    - `header = TRUE` para indicar que hay una fila de encabezado

## [Subconjunto de datos]({{ page.root }}/06-data-subsetting/)

- Se puede acceder a los elementos por:
  - Índice
  - Nombre
  - Vectores lógicos

- `[` corchetes individuales:
  - *extraer* elementos individuales o *subconjuntos* de vectores
  - p.ej. `x[1] `extrae el primer elemento del vector x.
  - *extrae* elementos individuales de una lista. El valor devuelto será otra `lista()`.
  - *extrae* columnas de un data.frame
- `[` con dos argumentos para:
- *extrae* filas y / o columnas de
  - matrices
  - data.frames
  - p.ej. `x[1,2]` extraerá el valor en la fila 1, columna 2.
  - p.ej. `x[2,:]` extraerá toda la segunda columna de valores.

- `[[` dobles corchetes para extraer elementos de las listas.
- `$` para acceder a columnas o elementos de lista por nombre.
- Índices negativos omiten elementos.

## [Condicional]({{ page.root }}/07-control-flow/)

- Use la condición `if` para iniciar una instrucción condicional, la condición `else if` para proporcionar pruebas adicionales, y `else` para proporcionar un valor predeterminado.
- El cuerpo de los enunciados condicionales deben estar indentados.
- Usa `==` para probar la igualdad.
- `X && Y` solo es verdadero si tanto X como Y son` TRUE`.
- `X || Y` es verdadero si X o Y, o ambos, son `TRUE`.
- Cero se considera `FALSE`; todos los demás números se consideran `TRUE`
- Usar bucles dentro de bucles para operar en datos multidimensionales.


## [Creación de gráficos de calidad de publicación]({{ page.root }}/08-plot-ggplot2/)

- las figuras se pueden crear con la misma semantica de los gráficos:
  - `library(ggplot2)`.
  - `ggplot` para crear la figura base.
  - `aes` especifica los ejes de datos, la forma, el color y el tamaño de los datos.
  - La función `geom` especifica el tipo de gráfico, p. `punto`,` línea`, `densidad`,` caja`.
  - La función `geom` también agrega transformaciones estadísticas, p.ej. `geom_smooth`.
  - Las funciones `scale` cambian la asignación de datos a la estética * change the mapping from data to aesthetics.
  - la función `facet` estratifica la figura en paneles.
  - `aes`thetics se aplica a capas individuales, o se puede configurar para toda la trama
  dentro de `ggplot`.
  - las funciones `theme` cambian el aspecto general de la trama.
  - ¡El orden de las capas importa!
  - `ggsave` para guardar una figura.

## [Vectorización]({{ page.root }}/09-vectorization/)

- La mayoría de las funciones y operaciones se aplican a cada elemento de un vector.
- `*` aplica elemento a las matrices.
- `% *%` para la verdadera multiplicación de matrices.
- `any()` devolverá `TRUE` si cualquier elemento de un vector es` TRUE`.
- `all()` devolverá `TRUE` si *todos* los elementos de un vector son` TRUE`.

## [Funciones explicadas]({{ page.root }}/10-functions/)

- `?"función"`.
- Coloqua el código cuyos parámetros cambian frecuentemente en una función, luego llámalo con
  diferentes valores de parámetros para personalizar el comportamiento.
- Devuelve la última línea de una función, o puede usar `return` explícitamente.
- Cualquier código escrito en el cuerpo de la función buscará preferiblemente variables definidas dentro de la función.
- Documentar por qué, luego qué, y finalmente cómo (si el código no se explica por sí mismo).

## [Escribir datos]({{ page.root }}/11-writing-data/)

- `write.table` para escribir objetos en formato regular.
- establecer `quote = FALSE` para que el texto no esté envuelto en` "` marks.

## [Split-apply-combine]({{ page.root }}/12-plyr/)

- Usar la familia de funciones `xxply` para aplicar funciones a grupos dentro de
  algunos datos.
- la primera letra, `a`rray,` d`ata.frame o `l`ist corresponde a los datos de entrada.
- la segunda letra denota la estructura de datos de salida.
- Las funciones anónimas (aquellas que no tienen asignado un nombre) se usan dentro de la familia `plyr` de funciones en grupos dentro de datos.

## [Manipulación de dataframe con dplyr]({{ page.root }}/13-dplyr/)
- `library(dplyr)`.
- `?select` para extraer variables por nombre.
- `?filter` devuelve filas con condiciones coincidentes.
- `?group_by` group data por una o más variables.
- `?summarize` resume múltiples valores en un solo valor.
- `?mutate` agrega nuevas variables a un data.frame.
- Combina operaciones usando el operador pipe `?"%>% "`.

## [Manipulación de dataframe con tidyr]({{ page.root }}/14-tidyr/)
- `biblioteca(tidyr)`.
- '?gather' convierte datos del formato *ancho* al *largo*.
- '?spread' convierte datos del formato *largo* al *ancho*.
- '?separate' divide un solo valor en múltiples valores.
- '?unite' fusiona múltiples valores en un solo valor.

## [Producir informes con knitr]({{ page.root }}/15-knitr-markdown/)
- Tiene valor de informes reproducibles.
- Conceptos básicos de Markdown.
- Trozos de código R.
- Opciones de fragmentos.
- Código R en línea.
- Otros formatos de salida.

## [Mejores prácticas para escribir un buen código]({{ page.root }}/16-wrap-up/)

* Programa a la defensiva, es decir, supon que surgirán errores, y escribe el código para poder detectarlos cuando surgan.
* Escribe pruebas antes de escribir el código para ayudarte a determinar exactamente qué se supone que debe hacer ese código.
* Es importante saber qué esperas que haga el código antes de intentar depurarlo.
* Haz que falle.
* Haz que falle rápido.
* Cambiar una cosa a la vez, y por una razón en específico.
* Manten un registro de lo que has hecho.
* Se humilde.

## Glosario

{:auto_ids}

argumento
: Un valor dado a una función o programa cuando se ejecuta.
  El término a menudo se usa indistintamente (y de manera inconsistente) con [parámetro](#parámetro).

asignar
: Darle un nombre a un valor asociando una variable a él.

cuerpo
: (de una función): las instrucciones que se ejecutan cuando se ejecuta una función.

comentario
: Un comentario en un programa que pretende ayudar a los lectores humanos a entender lo que está sucediendo,
  pero es ignorado por la computadora.
  Los comentarios en Python, R y el shell de Unix comienzan con un caracter `#` y se ejecutan hasta el final de la linea;
  los comentarios en SQL comienzan con `--`,
  y otros lenguajes tienen otras convenciones.

Valores Separados por Comas
: (CSV) Una representación textual común para tablas
  en el cual los valores en cada fila están separados por comas.

delimitador
: Un caracter utilizado para separar los valores individuales,
  como las comas entre columnas en un archivo [CSV] (# comma-separated-values).

documentación
: Texto en lenguaje humano escrito para explicar qué hace el software,
  cómo funciona, o cómo usarlo.

número punto flotante
: Un número que contiene una parte fraccionaria y un exponente.
  Ver también: [entero](#entero).

bucle
: Un bucle que se ejecuta una vez para cada valor en algún tipo de conjunto, lista o rango.
  Ver también: [bucle condicionado](#bucle-condicionado).

índice
: Un subíndice que especifica la ubicación de un único valor en una colección,
  como un solo píxel en una imagen.

entero
: Un número entero, como -12343. Ver también: [número de punto flotante](número punto flotante).

biblioteca
: En R, el directorio(s) donde [paquetes](#paquete) están almacenados.

paquete
: Una colección de funciones R, datos y código compilado en un formato bien definido. Los paquetes se almacenan en una [biblioteca](#biblioteca) y se cargan usando la función de biblioteca().

parámetro
: Una variable nombrada en la declaración de la función que se usa para mantener un valor pasado en la función.
  El término a menudo se usa indistintamente (y de manera inconsistente) con [argumento](#argumento).

Declaración de devolución
: Una instrucción que hace que una función deje de ejecutarse y devuelva un valor a su llamador de inmediato.

secuencia 
: Una colección de información que se presenta en un orden específico.

forma
: Las dimensiones de una matriz, representadas como un vector.
  Por ejemplo, una forma de matriz 5 × 3 es `(5,3)`.

sequencia de caracteres
: Una [secuencia](#secuencia) de cero o más caracteres.

error de sintaxis
: Un error de programación que ocurre cuando las instrucciones no están en orden o contienen caracteres
  no esperado por el lenguaje de programación.

tipo
: La clasificación de algo en un programa (por ejemplo, el contenido de una variable)
  como un tipo de número (por ejemplo [punto flotante](#flotante), [entero](#entero))
  o algo mas. En R, el comando typeof() se usa para consultar un tipo de variable.

bucle condicionado
: Un bucle que se ejecuta siempre que alguna condición sea verdadera.
  Ver también: [bucle](#bucle).

