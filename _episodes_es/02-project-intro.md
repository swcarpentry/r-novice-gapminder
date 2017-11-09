---
title: "Gestión de proyectos con RStudio"
teaching: 20
exercises: 10
questions:
- "¿Cómo pudo gestionar mis proyectos en R?"
objectives:
- Crear proyectos independientes en RStudio
keypoints:
- "Usar RStudio para crear y gestionar proyectos con un diseño consistente."
- "Tratar los datos brutos como de sólo lectura."
- "Tratar la salida generada como disponible."
- "Definición y aplicación de funciones separadas."
source: Rmd
---


## Introducción

El proceso científico es naturalmente incremental, y la vida de muchos proyectos comienza como notas aleatorias, algún código, luego un manuscrito, y
eventualmente todo está mezclado.

<blockquote class="twitter-tweet"><p>Managing your projects in a reproducible fashion doesn't just make your science reproducible, it makes your life easier.</p>— Vince Buffalo (@vsbuffalo) <a href="https://twitter.com/vsbuffalo/status/323638476153167872">April 15, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

La mayoría de la gente tiende a organizar sus proyectos de esta manera:

![](../fig/bad_layout.png)

Hay muchas razones de porqué debemos *siempre* evitar esto:

1. Es realmente difícil saber cuál versión de tus datos es 
la original y cuál es la modificada;
2. Es realmente complicado porque se mezclan archivos con varias
extensiones juntas;
3. Probablemente te lleve mucho tiempo encontrar realmente
cosas, y relacionar las figuras correctas con el código exacto
que ha sido utilizado para generarlas;

Un buen diseño del proyecto finalmente hará tu vida más fácil:

* Ayudará a garantizar la integridad de tus datos;
* Hace que sea más simple compartir tu código con alguien más 
(un compañero de laboratorio, colaborador, o supervisor);
* Permite cargar fácilmente tu código con el envío de tu manuscrito;
* Hace que sea más fácil volver a seleccionar el proyecto después de un descanso.

## Una posible solución

Afortunadamente hay herramientas y paquetes que pueden ayudarte a gestionar efectivamente tu trabajo.

Uno de los aspectos más poderosos y útiles de RStudio es su funcionalidad de gestión de proyectos. Lo utilizaremos hoy para crear un proyecto autocontenido y reproducible.


> ## Desafío: Creando un proyecto autocontenido
>
> Vamos a crear un proyecto en RStudio:
>
> 1. Hacer clic en el menú "File", luego en "New Project".
> 2. Hacer clic en "New Directory".
> 3. Hacer clic en "Empty Project".
> 4. Introducir el nombre del directorio para guardar tu proyecto, por ejemplo: "my_project".
> 5. Si está disponible, seleccionar la casilla de verificación "Create a git repository."
> 6. Hacer clic en el botón "Create Project".
{: .challenge}

Ahora cuando inicie R en este directorio de proyectos, o abra este proyecto con RStudio, todo nuestro trabajo en este proyecto estará completamente autocontenido en este directorio.

## Mejores practicas para la organización del proyecto

Aunque no existe una "mejor" forma de diseñar un proyecto, existen algunos principios
generales que deben cumplirse para facilitar la gestión de proyectos: 

### Tratar los datos como de sólo lectura

Este es probablemente el objetivo más importante al configurar un proyecto. Los datos
suelen consumir mucho tiempo y/o ser costosos de recolectar. Trabajando interactivamente
con ellos (por ejemplo, en Excel) donde los datos pueden ser modificados significa que nunca estás seguro de donde provienen, o cómo han sido modificados desde su recolección.
Por lo tanto, es una buena idea manejar tus datos como "sólo lectura".

### Limpieza de datos

En muchos casos tus datos estarán "sucios": y necesitarán un preprocesamiento significativo
para  obtener un formato R (o cualquier otro lenguaje de programación) que te resulte útil. Esta
tarea es algunas veces llamada **"data munging"**. Es útil almacenar estos **scripts** en una carpeta separada y crear una segunda carpeta de datos de "solo lectura" para contener los **data sets** "limpios"

### Tratar la salida generada como disponible

Todo lo generado por tus **scripts** debe tratarse como disponible: todo debería 
poder regenerarse a partir de tus **scripts**.

Hay muchas diferentes maneras de gestionar esta salida. Me parece útil 
tener una carpeta de salida con diferentes subdirectorios para cada análisis 
por separado. Esto hace que sea más fácil después, ya que muchos de mis análisis son exploratorios
y no terminan siendo utilizados en el proyecto final, y algunos de los análisis se comparten entre proyectos.

> ## Tip: Good Enough Practices for Scientific Computing
>
> [Good Enough Practices for Scientific Computing](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/good-enough-practices-for-scientific-computing.pdf) brinda las siguientes recomendaciones para la organización de proyectos:
>
> 1. Coloque cada proyecto en su propio directorio, el cual lleva el nombre del proyecto.
> 2. Coloque documentos de texto asociados con proyecto en el directorio `doc`.
> 3. Coloque los datos sin procesar y los metadatas en el directorio `data`, y archivos generados durante la limpieza y análisis en un directorio `results` .
> 4. Coloque los **scripts** fuente del proyecto y los programas en el directorio `src`, y programas traídos de otra parte o compilados localmente en el directorio `bin`.
> 5. Nombre todos archivos de tal manera que reflejen su contenido o función.
>
{: .callout}

> ## Tip: ProjectTemplate - una posible solución
>
> Una manera de automatizar la gestión de un proyecto es instalar el paquete, `ProjectTemplate`.
> Este paquete configurará una estructura de directorios ideal para la gestión de proyectos.
> Esto es muy útil ya que te permite tener tu análisis **pipeline/workflow** organizado y estructurado.
> Junto con la funcionalidad predeterminada del proyecto RStudio y Git, podrás realizar el seguimiento de tu
> trabajo y compartirlo con colaboradores.
>
> 1. Instalar `ProjectTemplate`.
> 2. Cargar la librería
> 3. Inicializar el proyecto:
>
> 
> ~~~
> install.packages("ProjectTemplate")
> library("ProjectTemplate")
> create.project("../my_project", merge.strategy = "allow.non.conflict")
> ~~~
> {: .r}
>
> Para más información de ProjectTemplate y su functionalida visita la
> página [ProjectTemplate](http://projecttemplate.net/index.html)
{: .callout}

### Separar la definición de funciones y la aplicación

Una de las maneras más efectivas de trabajar con R es comenzar escribiendo el código que deseas que se ejecute directamente en un **script** .R, y enseguida ejecutar las líneas seleccionadas (ya sea utilizando los atajos del teclado en RStudio o haciendo clic en el botón "Run") en la consola interactiva de R.

Cuando tu proyecto se encuentra en sus primeras etapas, el archivo **script** inicial .R generalmente contendrá muchas líneas de código ejecutadas directamente. Conforme vaya madurando, fragmentos reutilizables podrán ser llevados a sus
propias funciones. Es buena idea separar estas funciones en dos carpetas separadas; una
para guardar funciones útiles que reutilizarás a través del análisis y proyectos, y
uno para guardar los **scripts** de análisis.

> ## Tip: evitando la duplicación
>
> Puedes encontrarte utilizando datos o **scripts** de análisis a través de varios proyectos.
> Normalmente, deseas evitar la duplicación para ahorrar espacio y evitar
> actualizar el código en múltiples lugares.
>
> En este caso, me parece útil hacer "links simbólicos", los cuales son esencialmente
> accesos directos a archivos en otro lugar en un sistema de archivos. En Linux y OS X puedes
> utilizar el comando `ln -s`, y en Windows crear un acceso directo o
> utilizar el comando `mklink` desde la terminal de windows.
{: .callout}

### Guardar los datos en el directorio de datos

Ahora que tenemos una buena estructura de directorios colocaremos/guardaremos los archivos de datos en el directorio `data/`.

> ## Desafío 1
> Descargar los datos gapminder de [aquí](https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv).
>
> 1. Descargar el archivo (CTRL + S, clic botón derecho del **mouse** -> "Save as", o File -> "Save page as")
> 2. Asegúrate de que esté guardado con el nombre `gapminder-FiveYearData.csv`
> 3. Guardar el archivo en la carpet `data/` dentro de tu proyecto.
>
> Más delante cargaremos e inspeccionaremos estos datos.
{: .challenge}

> ## Desafío 2
> Es útil tener una idea general sobre el **dataset**, directamente desde la
> línea de comandos, antes de cargarlo en R. Comprender mejor el **dataset**
> será útil al tomar decisiones sobre cómo cargarlo en R. Utiliza la terminal de
> línea de comandos para contestar las siguientes preguntas:
> 1. ¿Cuál es el tamaño del archivo?
> 2. ¿Cuántas líneas de datos contiene?
> 3. ¿Cuáles tipos de valores están almacenados en este archivo?
>
> > ## Solución al desafío 2
> >
> > Al ejecutar estos comandos en la terminal:
> > 
> > ~~~
> > ls -lh data/gapminder-FiveYearData.csv
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > 
> > ~~~
> > -rw-r--r--  1 naupaka  staff    80K Jul 19  2016 data/gapminder-FiveYearData.csv
> > ~~~
> > {: .output}
> > El tamaño del archivo es 80K.
> > 
> > ~~~
> > wc -l data/gapminder-FiveYearData.csv
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > 
> > ~~~
> >     1705 data/gapminder-FiveYearData.csv
> > ~~~
> > {: .output}
> > Hay 1705 líneas. Los datos se ven así:
> > 
> > ~~~
> > head data/gapminder-FiveYearData.csv
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > 
> > ~~~
> > country,year,pop,continent,lifeExp,gdpPercap
> > Afghanistan,1952,8425333,Asia,28.801,779.4453145
> > Afghanistan,1957,9240934,Asia,30.332,820.8530296
> > Afghanistan,1962,10267083,Asia,31.997,853.10071
> > Afghanistan,1967,11537966,Asia,34.02,836.1971382
> > Afghanistan,1972,13079460,Asia,36.088,739.9811058
> > Afghanistan,1977,14880372,Asia,38.438,786.11336
> > Afghanistan,1982,12881816,Asia,39.854,978.0114388
> > Afghanistan,1987,13867957,Asia,40.822,852.3959448
> > Afghanistan,1992,16317921,Asia,41.674,649.3413952
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

> ## Tip: Línea de comandos en R Studio
>
> Puedes abrir rápidamente una terminal en RStudio usando la opción del menú  **Tools -> Shell...**.
{: .callout}

### Control de versiones

Es importante llevar a cabo el control de versiones en un proyecto. Ve [aquí](http://swcarpentry.github.io/git-novice/14-supplemental-rstudio/) para una buena lección donde se describe el uso de Git con R Studio.


