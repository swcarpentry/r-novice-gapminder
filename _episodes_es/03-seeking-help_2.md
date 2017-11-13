---
title: "buscando ayuda"
teaching: 10
exercises: 10
questions:
- "¿Cómo puedo obtener ayuda en R?"
objectives:
- "Poder leer archivos de ayuda de R, para funciones y operadores especiales"
- "Poder usar vistas de tareas CRAN para identificar paquetes para resolver un problema"
- "Para poder buscar ayuda de tus compañeros"
keypoints:
- "Usar `help()` para obtener ayuda online de R."
source: Rmd
---



## Lectura de archivos de ayuda

R, y cada paquete, proporciona archivos de ayuda para las funciones. La sintaxis general 
para buscar ayuda en cualquier función, "function_name", de una función específica que esté en un paquete
cargado dentro de tu **namespace** (tu sesión interactiva en R):


~~~
?function_name
help(function_name)
~~~
{: .r}

Esto cargará una página de ayuda en RStudio (o como texto sin formato en R por sí mismo).

Cada página de ayuda se divide en secciones:

 - Descripción: una descripción extendida de lo que hace la función.
 - Uso: los argumentos de la función y sus valores predeterminados.
 - Argumentos: una explicación de los datos que espera cada argumento.
 - Detalles: cualquier detalle importante a tener en cuenta.
 - Valor: los datos que regresa la función.
 - Ver también: cualquier función relacionada que pueda serte útil.
 - Ejemplos: algunos ejemplos de cómo usar la función.

Las diferentes funciones pueden tener diferentes secciones, pero estas son las principales que debes tener en cuenta.

> ## Sugerencia: Lectura de archivos de ayuda
>
> Uno de los aspectos más desalentadores de R es la gran cantidad de funciones
> disponibles. Es muy difícil, si no imposible, recordar el
> uso correcto para cada función que usa. Afortunadamente, están los archivos de ayuda
> ¡lo que significa, que no tienes que hacerlo!
{: .callout}

## Operadores especiales

Para buscar ayuda en operadores especiales, usa comillas:


~~~
?"<-"
~~~
{: .r}

## Obteniendo ayuda en los paquetes

Muchos paquetes vienen con "viñetas": tutoriales y documentación de ejemplo extendida.
Sin ningún argumento, `vignette()` listará todas las viñetas disponibles para todos los paquetes instalados;
`vignette(package="package-name")` listará todas las viñetas disponibles
`package-name`, y `vignette("vignette-name")` abrirán la viñeta especificada.

Si un paquete no tiene viñetas, generalmente puedes encontrar ayuda escribiendo
`help("package-name")`.

##  Cuando recuerdas un poco sobre la función

Si no estás seguro de en qué paquete está una función, o cómo se escribe específicamente, puedes hacer una búsqueda difusa:


~~~
??function_name
~~~
{: .r}

## Cuando no tienes idea de dónde comenzar

Si no sabes qué función o paquete necesitas usar, utiliza
[CRAN Task Views](http://cran.at.r-project.org/web/views)
es una lista especialmente mantenida de paquetes agrupados en
campos. Este puede ser un buen punto de partida.

## Cuando tu código no funciona: busca ayuda de tus compañeros

Si tienes problemas para usar una función, 9 de cada 10 veces,
las respuestas que estas buscando ya han sido respondidas en
[Stack Overflow](http://stackoverflow.com/). Puedes buscar usando
la etiqueta `[r]`.

Si no puedes encontrar la respuesta, hay algunas funciones útiles para
ayudarte a hacer una pregunta a tus compañeros:


~~~
?dput
~~~
{: .r}

Descargará los datos con los que estás trabajando en un formato para que puedan
ser copiados y pegados por cualquier otra persona en su sesión de R.


~~~
sessionInfo()
~~~
{: .r}



~~~
R version 3.4.1 (2017-06-30)
Platform: x86_64-apple-darwin16.7.0 (64-bit)
Running under: macOS High Sierra 10.13

Matrix products: default
BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
LAPACK: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libLAPACK.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base     

other attached packages:
[1] checkpoint_0.4.1 stringr_1.2.0    knitr_1.17      

loaded via a namespace (and not attached):
[1] compiler_3.4.1  magrittr_1.5    tools_3.4.1     stringi_1.1.5  
[5] methods_3.4.1   evaluate_0.10.1
~~~
{: .output}

Imprimirá su versión actual de R, así como cualquier paquete que tú hayas
cargado. Esto puede ser útil para otros para ayudar a reproducir y depurar
tu problema.

> ## Reto 1
>
> Buscar la ayuda para la función `c`. ¿Qué tipo de vector
> crees que crearás si evalúas lo siguiente?:
> 
> ~~~
> c(1, 2, 3)
> c('d', 'e', 'f')
> c(1, 2, 'f')
> ~~~
> {: .r}
> > ## Solución al Reto 1
> >
> > La función `c()` crea un vector, en el cual todos los elementos son
> > del mismo tipo. En el primer caso, los elementos son numéricos, en el
> > segundo, son character, y en el tercero son **character**:
> > los valores numéricos son "coerced" para ser **characters**.
> {: .solution}
{: .challenge}

> ## Reto 2
>
> Buscar la ayuda para la función `paste`. Tendrás que usar esto más tarde.
> ¿Cuál es la diferencia entre los argumentos `sep` y `collapse`?
>
> > ## Solución para el Reto 2
> >
> > Buscar la ayuda de la función `paste()`, usa:
> > 
> > ~~~
> > help("paste")
> > ?paste
> > ~~~
> > {: .r}
> > La diferencia entre `sep` y `collapse` es un poco
> > complicada. La función `paste` acepta cualquier número de argumentos, cada uno 
> > de los cuales puede ser un vector de cualquier longitud. El argumento `sep` especifica la cadena
> > usada entre términos concatenados — by default, un espacio.  El resultado es un
> > vector tan largo como el argumento más largo proporcionado a `paste`. A diferencia de,
> > `collapse` especifica que después de la concatenación los elementos *collapsed*
> > juntos utilizando el separador dado, el resultado es una sola cadena.
> > e.g. 
> > 
> > ~~~
> > paste(c("a","b"), "c")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] "a c" "b c"
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > paste(c("a","b"), "c", sep = ",")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] "a,c" "b,c"
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > paste(c("a","b"), "c", collapse = "|")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] "a c|b c"
> > ~~~
> > {: .output}
> > 
> > 
> > 
> > ~~~
> > paste(c("a","b"), "c", sep = ",", collapse = "|")
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> > [1] "a,c|b,c"
> > ~~~
> > {: .output}
> > (Para más información,
> > ve a la parte inferior de la página de ayuda `?paste` y busca los
> > ejemplos, o prueba `example('paste')`.)
> {: .solution}
{: .challenge}

> ## Reto 3
> Usa la ayuda para encontrar una función (y sus parámetros asociados) que tu puedas
> usar para cargar datos de un archivo csv en los cuales las columnas están delimitadas con "\ t"
> (tab) y el punto decimal es un "." (punto). Esta comprobación para el separador decimal
> es importante, especialmente si está trabajando con colegas internacionales
> porque diferentes países tienen diferentes convenciones para el
> punto decimal (i.e. coma vs punto).
> sugerencia: usa `??csv` para buscar funciones relacionadas con csv.
> > ## Solución a el Reto 3
> >
> > La función R estándar para leer archivos delimitados por tabuladores con un separador
> > de punto decimal es read.delim(). Tu puedes hacer esto también con
> > `read.table(file, sep="\t")` (el punto es el *default* separador
> > decimal para `read.table()`, aunque es posible que tengas que cambiar también el argumento
> >  `comment.char` si tu archivo de datos contiene caracteres
> > **hash** (#)
> {: .solution}
{: .challenge}

## Otros puertos de llamada

* [Quick R](http://www.statmethods.net/)
* [RStudio cheat sheets](http://www.rstudio.com/resources/cheatsheets/)
* [Cookbook for R](http://www.cookbook-r.com/)
