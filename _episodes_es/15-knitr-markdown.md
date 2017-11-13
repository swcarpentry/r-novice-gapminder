---
title: Produciendo informes con **knitr**
teaching: 60
exercises: 15
questions:
- "¿Cómo puedo integrar programas e informes?"
objectives:
- Valor de informes reproducibles
- Conceptos básicos de **Markdown**
- Fragmentos de código **R**
- Opciones de fragmentos
- Código **R** en línea
- Otros formatos de salida
keypoints:
- "Informes mixtos escritos en **R Markdown** con programa escrito en **R**."
- "Especificar opciones de fragmento para controlar el formateo".
- "Usar `knitr` para convertir estos documentos en PDF y en otros formatos ".
source: Rmd
---




## Informes de análisis de datos

Los analistas de datos tienden a escribir muchos informes, describiendo sus
análisis y resultados, para sus colaboradores o para documentar su
trabajo para referencia futura.

Cuando comencé por primera vez, escribía una rutina **R** con todos mis
trabajos, y simplemente enviaría un correo electrónico a mi colaborador, describiendo el
resultados y adjuntanso varios gráficos. Al discutir los resultados,
a menudo había confusión sobre qué gráfico era cuál.

Pasé a escribir informes formales, con **Word** o **LaTeX**, pero tenía que
pasar mucho tiempo haciendo que las figuras se vieran bien. En su mayoría, 
la preocupación es sobre los saltos de página.

Todo es más fácil ahora que creo una página **web** (como un
archivo **html**). Puede ser un largo flujo, así que puedo usar figuras largas que
no cabrían ordinariamente en una página. El desplazamiento de página es tu amigo.


## Programación literaria

Idealmente, dichos informes de análisis son documentos _reproducibles_: Si
se descubre un error, o si se agregan algunos temas adicionales a los
datos, puedes volver a compilar el informe y obtener los resultados, nuevo o corregido 
(en lugar de tener que reconstruir figuras, pegarlas en
un documento de **Word** y luego editar manualmente varios resultados detallados).

La herramienta clave para *R* es [knitr] (http://yihui.name/knitr/), que te permite
crear un documento que es una mezcla de texto y algunos fragmentos de
código. Cuando el documento es procesado por **knitr**, los fragmentos del código **R**
serán ejecutados, y los gráficos u otros resultados insertados.

Este tipo de idea ha sido llamado "programación literaria".

**knitr** te permite mezclar básicamente cualquier tipo de texto con cualquier tipo de
código, pero te recomendamos que use **R Markdown**, que mezcla **Markdown**
con **R**. **Markdown** es un ligero lenguaje de marcado para crear
páginas **web**.


## Creando un archivo **R Markdown**

Dentro de **R Studio**, haz clic en Archivo y rarr; Nuevo archivo y rarr; **R Markdown** y
obtendrás un cuadro de diálogo como este:

![](../fig/New_R_Markdown.png)

Puedes mantener el valor predeterminado (salida **HTML**), pero dale un título.


## Componentes básicos de **R Markdown**

El fragmento inicial de texto contiene instrucciones para **R**: le das
un título, autor y fecha, y díle que va a querer
producir una salida **html** (en otras palabras, una página **web**).

```
---
title: "Documento inicial **R Markdown**"
author: "Karl Broman"
date: "23 de Abril de 2015"
output: html_document
---
```

Puedes eliminar cualquiera de esos campos si no los quieres
incluido. Las comillas dobles no son estrictamente _necesarias_ en este caso.
En su mayoría son necesarios si deseas incluir dos puntos en el título.

**RStudio** crea el documento con un texto de ejemplo para ayudarte
a empezar. Observa a continuación que hay fragmentos como

<pre>
&#96;&#96;&#96;{r}
summary(cars)
&#96;&#96;&#96;
</pre>

Estos son fragmentos de código **R** que serán ejecutados por **knitr** y reemplazados
por sus resultados. Más sobre esto más tarde.

También fíjate en la dirección **web** que se coloca entre corchetes angulares (`<>`) así
como los asteriscos dobles en `**Knit**`. Esto es
[Markdown](http://daringfireball.net/projects/markdown/syntax).

## **Markdown**

    **Markdown** es un sistema para escribir páginas **web** marcando el texto tanto
como lo haría en un correo electrónico en lugar de escribir código **html**. El texto marcado 
es _convertido_ a **html**, reemplazando las marcas con el
código **HTML**.

Por ahora, borremos todas las cosas que están ahí y escribamos un poco de
**markdown**.

Haces las cosas en **negrita** usando dos asteriscos, como esto: `** negrita **`,
y haces cosas _italicas_ usando guiones bajos, como esto:
`_italics_`.

Puede hacer una lista con viñetas escribiendo una lista con guiones o
asteriscos, como este:

`` `
* negrita con doble asterisco
* itálico con guiones bajos
* letra de tipo de código con retrocesos
`` `

o así:

`` `
- negrita con doble asterisco
- itálico con guiones bajos
- letra de tipo de código con retrocesos
`` `

Cada uno aparecerá como:

- negrita con doble asterisco
- itálico con guiones bajos
- letra de tipo de código con retrocesos

(Prefiero guiones en lugar de asteriscos, yo mismo)

Puedes hacer una lista numerada simplemente usando números. Puedes usar el
mismo número una y otra vez si lo desea:

`` `
1. negrita con doble asterisco
1. cursiva con guiones bajos
1. tipo de letra de código con retrocesos
`` `

Esto aparecerá como:

1. negrita con doble asterisco
1. cursiva con guiones bajos
1. tipo de letra de código con retrocesos

Puede crear encabezados de sección de diferentes tamaños iniciando una línea
con un cierto número de símbolos `#`:

`` `
# Título
## Sección principal
### Subsección
#### Sección sub-sub
`` `

Usted _compila_ el documento R Markdown a una página web html haciendo clic
el "HTML de punto" en la esquina superior izquierda. Y tenga en cuenta el pequeño signo de interrogación
junto a él; haga clic en el signo de interrogación y obtendrá un "Markdown Quick"
Referencia "(con la sintaxis Markdown) al RStudio
documentación sobre el descuento de R

> ## Desafío
>
> Cree un nuevo documento de R Markdown. Eliminar todos los fragmentos de código R
> y escriba un poco de Markdown (algunas secciones, algunas en cursiva)
> texto y una lista detallada).
>
> Convierte el documento a una página web.
{: .challenge}


## Un poco más de Markdown

Puede hacer un hipervínculo como este:
`[text to show](http://the-web-page.com)`.

Puede incluir un archivo de imagen como este: `![caption](http://url/for/file)`

Puede hacer subíndices (por ejemplo, F ~ 2 ~) con `F ~ 2` y superíndices (p.
F ^ 2 ^) con `F ^ 2 ^`.

Si sabes cómo escribir ecuaciones en
[LaTeX] (http://www.latex-project.org/), le alegrará saber que
puedes usar `$ $` y `$$ $$` para insertar ecuaciones matemáticas, como
`$ E = mc ^ 2 $` y

```
$$ y = \ mu + \ sum_ {i = 1} ^ p \ beta_i x_i + \ epsilon $$
```



## Trozos de código R

Markdown es interesante y útil, pero el poder real proviene de
mezcla de descuento con fragmentos de código R. Esto es R Markdown. Cuando
procesado, se ejecutará el código R; si producen figuras, el
las figuras se insertarán en el documento final.

Los fragmentos del código principal se ven así:

<pre>
&#96;&#96;&#96;{r load_data}
gapminder <- read.csv("~/Desktop/gapminder.csv")
&#96;&#96;&#96;
</pre>

Es decir, coloca un fragmento de código R entre <code>&#96;&#96;&#96;{r chunk_name}</code>
and <code>&#96;&#96;&#96;</code>. Es una buena idea darle a cada pedazo
un nombre, ya que te ayudarán a corregir los errores y, si hay gráficos,
producido, los nombres de archivo se basan en el nombre del fragmento de código que
los produjo.

> ## Desafío
>
> Agregue fragmentos de código a
>
> - Cargar el paquete ggplot2
> - Leer los datos del gapminder
> - Crear una trama
{: .challenge}

## Cómo se compilan las cosas

Cuando presiona el botón "Knit HTML", el documento de R Markdown es
procesado por [knitr] (http://yihui.name/knitr) y un Markdown simple
se produce el documento (así como, potencialmente, un conjunto de archivos de figuras): se ejecuta el código R
y reemplazado por la entrada y la salida; si las figuras son
producido, se incluyen enlaces a esas figuras.

Los documentos Markdown y figura son procesados por la herramienta
[pandoc] (http://pandoc.org/), que convierte el archivo Markdown en un
archivo html, con las figuras incrustadas.

<img src="../fig/rmd-15-rmd_to_html_fig-1.png" title="plot of chunk rmd_to_html_fig" alt="plot of chunk rmd_to_html_fig" style="display: block; margin: auto auto auto 0;" />




## Opciones de fragmento

Hay una variedad de opciones para afectar la forma en que los fragmentos de código son
tratado

- Use `echo = FALSE` para evitar que se muestre el código en sí.
- Use `results =" hide "` para evitar que se impriman los resultados.
- Use `eval = FALSE` para tener el código mostrado pero no evaluado.
- Use `warning = FALSE` y` message = FALSE` para ocultar cualquier advertencia o
   mensajes producidos
- Use `fig.height` y` fig.width` para controlar el tamaño de las figuras
   producido (en pulgadas).

Entonces podrías escribir:

<pre>
&#96;&#96;&#96;{r load_libraries, echo=FALSE, message=FALSE}
library("dplyr")
library("ggplot2")
&#96;&#96;&#96;
</pre>

A menudo habrá opciones particulares que querrá usar
repetidamente; para esto, puede establecer las opciones _global_ chunk, de esta forma:

<pre>
&#96;&#96;&#96;{r global_options, echo=FALSE}
knitr::opts_chunk$set(fig.path="Figs/", message=FALSE, warning=FALSE,
                      echo=FALSE, results="hide", fig.width=11)
&#96;&#96;&#96;
</pre>

La opción `fig.path` define dónde se guardarán las figuras. El `/`
aquí es realmente importante; sin él, las figuras se guardarían en
el lugar estándar, pero solo con los nombres que están con `Figs`.

Si tiene varios archivos R Markdown en un directorio común, es posible que
quiere usar `fig.path` para definir prefijos separados para el archivo de figuras
nombres, como `fig.path =" Figs / cleaning- "` y `fig.path =" Figs / analysis- "`.


> ## Desafío
>
> Use las opciones de fragmentos para controlar el tamaño de una figura y ocultar el
> código.
{: .challenge}


## Código R en línea

Puede hacer que se reproduzcan todos los números de su informe. Utilizar
<code> `r </ code> y <code>` </ code> para un fragmento de código en línea,
al igual que: <code>&#96;r round(some_value, 2)&#96;</code>. El código será
ejecutado y reemplazado con el _valor_ del resultado.

No permita que estos fragmentos en línea se dividan en líneas.

Tal vez anteceda el párrafo con un fragmento de código más grande que lo hace
calcula y define cosas, con `include = FALSE` para ese tamaño
fragmento (que es lo mismo que `echo = FALSE` y` results = "hide" `).

Soy muy particular sobre el redondeo en tales situaciones. Es posible que desee
`2.0`, pero` round (2.03, 1) `dará solo` 2`.

Los
[`myround`](https://github.com/kbroman/broman/blob/master/R/myround.R)
function in my [R/broman](https://github.com/kbroman) manijas del paquete
esta.

> ## Desafío
>
> Pruebe un poco de código R en línea.
{: .challenge}


## Otras opciones de salida

También puede convertir R Markdown en un documento PDF o Word. Haga clic en el
pequeño triángulo junto al botón "Knit HTML" para obtener un menú desplegable
menú. O podría poner `pdf_document` o` word_document` en el encabezado
del archivo.

> ## Sugerencia: crear documentos PDF
>
> La creación de documentos .pdf puede requerir la instalación de algún programa adicional. Si
> obligatorio esto se detalla en un mensaje de error.
>
> Tex para Windows está disponible [aquí](http://miktex.org/2.9/setup).
>
> Tex for mac está disponible [aquí] (http://tug.org/mactex).
{: .callout}


## Recursos

- [Knitr in a knutshell tutorial](http://kbroman.org/knitr_knutshell)
- [Dynamic Documents with R and knitr](http://www.amazon.com/exec/obidos/ASIN/1482203537/7210-20) (book)
- [R Markdown documentation](http://rmarkdown.rstudio.com)
- [R Markdown cheat sheet](http://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
* [Getting started with R Markdown](https://www.rstudio.com/resources/webinars/getting-started-with-r-markdown/)
* [Reproducible Reporting](https://www.rstudio.com/resources/webinars/reproducible-reporting/)
* [The Ecosystem of R Markdown](https://www.rstudio.com/resources/webinars/the-ecosystem-of-r-markdown/)
* [Introducing Bookdown](https://www.rstudio.com/resources/webinars/introducing-bookdown/)
