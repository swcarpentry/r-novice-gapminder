---
layout: page
title: R for reproducible scientific analysis
subtitle: Data structures
minutes: lots
---

> ### Learning Objectives {.objectives}
>
> - To be aware of the different types of data
> - To be aware of the different basic data structures commonly encountered in R
> - To be able to ask questions from R about the type, class, and structure of an object.
>

### Data Types

Before we can analyse any data, we'll need to have a strong
understanding of the basic data types and data structures. It is **Very
Important** to understand because these are the things you will
manipulate on a day-to-day basis in R, and are the source of most
frustration encountered by beginners.

R has 5 basic atomic types (meaning they can't be broken down into anything smaller):

* logical (e.g., `TRUE`, `FALSE`)
* numeric 
  * integer (e.g, 3, 2L, as.integer(3))
  * double (i.e. decimal) (e.g, -24.57, 2.0, pi)
* complex (i.e. complex numbers) (e.g, 1 + 0i, 1 + 4i)
* character (e.g, "a", "swc", 'This is a cat')

There are a few functions we can use to interrogate data in R to determine its type:

~~~ {.r}
typeof() # what is its atomic type?
is.logical() # is it TRUE/FALSE data?
is.numeric() # is it numeric?
is.complex() # is it complex number data?
is.character() # is it character data?
~~~

> #### Challenge 1: Data types {.challenge}
>
> Use your knowledge of how to assign a value to 
> a variable, to create examples of data with the 
> following characteristics:
>
> * 1) Variable name: 'answer', Type: logical
> * 2) Variable name: 'height', Type: numeric
> * 3) Variable name: 'dog_name', Type: character
>
> For each variable you've created, test that it
> has the data type you intended. Do you find 
> anything unexpected?
>

### Data Structures

There are five data structures you will commonly encounter in R. These include:

* vector
* factors
* list
* matrix
* data.frame

For now, let's focus on vectors in more detail, to discover more about data types. 

#### Vectors

A vector is the most common and basic data structure in `R` and is pretty much
the workhorse of R. They are sometimes referred to as atomic vectors, because
importantly, they can **only contain one data type**. They are the building blocks of
every other data structure.

A vector can contain any of the five types we introduced before:

* logical (e.g., `TRUE`, `FALSE`)
* integer (e.g,, 2L, as.integer(3))
* numeric (real or decimal) (e.g, 2, 2.0, pi)
* complex (e.g, 1 + 0i, 1 + 4i)
* character (e.g, "a", "swc")

> #### Tip: "Character Vectors" {.callout}
>
> You will sometimes hear the term "character vector", especially in
> warning or error messages. This is a somewhat confusing and unfortunate
> name. Remember that the type "character" really means some text
> wrapped in quotation symbols.
>

Create an empty vector with `vector()` or by using the concatenate 
function, `c()`.

~~~ {.r} 
x <- vector()
x
~~~

~~~ {.output}
logical(0) 
~~~

So by default, it creates an empty vector (i.e. a length of 0) of type "logical".

~~~ {.r}
x <- vector(length = 10) # with a predefined length
x
~~~

~~~ {.output}
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
~~~

If we count the number of FALSEs there should be 10.

~~~ {.r}
x <- vector("character", length = 10)  # with a predefined length and type
x
~~~

~~~ {.output}
 [1] "" "" "" "" "" "" "" "" "" ""
~~~

Or we can use the concatenate function to combine any values we like into
a vector (so long as they're the same atomic type!).

~~~ {.r}
x <- c(10, 12, 45, 33)
x
~~~

~~~ {.output}
[1] 10 12 45 33
~~~

You can also create vectors as sequence of numbers

~~~ {.r}
series <- 1:10 
series
~~~

~~~ {.output}
 [1]  1  2  3  4  5  6  7  8  9 10
~~~

~~~ {.r}
seq(10) 
~~~

~~~ {.output}
 [1]  1  2  3  4  5  6  7  8  9 10
~~~

~~~ {.r}
seq(1, 10, by = 0.1)
~~~

~~~ {.output}
 [1]  1.0  1.1  1.2  1.3  1.4  1.5  1.6  1.7  1.8  1.9  2.0  2.1  2.2  2.3  2.4
 [16]  2.5  2.6  2.7  2.8  2.9  3.0  3.1  3.2  3.3  3.4  3.5  3.6  3.7  3.8  3.9
 [31]  4.0  4.1  4.2  4.3  4.4  4.5  4.6  4.7  4.8  4.9  5.0  5.1  5.2  5.3  5.4
 [46]  5.5  5.6  5.7  5.8  5.9  6.0  6.1  6.2  6.3  6.4  6.5  6.6  6.7  6.8  6.9
 [61]  7.0  7.1  7.2  7.3  7.4  7.5  7.6  7.7  7.8  7.9  8.0  8.1  8.2  8.3  8.4
 [76]  8.5  8.6  8.7  8.8  8.9  9.0  9.1  9.2  9.3  9.4  9.5  9.6  9.7  9.8  9.9
 [91] 10.0
~~~


> #### Tip: Creating integers {.callout}
>
> When you combine numbers using the concatenate function, `c()` the type
> will automatically become "numeric", that is real/decimal numbers. If you
> specifically want to create a vector of integers (whole numbers only),
> you need to append each number with an L, i.e. `c(10L, 12L, 45L, 33L)`.
>

You can also use the concatenate function to add elements to a vector:

~~~ {.r}
x <- c(x, 57)
x
~~~

~~~ {.output}
[1] 10 12 45 33 57
~~~

> #### Challenge 2 {.challenge}
>
> Vectors can only contain one atomic type. If you try to combine different
> types, R will create a vector that is the least common denominator: the
> type that is easiest to coerce to.
>
> **Guess what the following do without running them first:**
> 
> ~~~ {.r}
> xx <- c(1.7, "a") 
> xx <- c(TRUE, 2) 
> xx <- c("a", TRUE) ```
> ~~~
>

This is called implicit coercion.

The coersion rule goes `logical` -> `integer` -> `numeric` -> `complex` ->
`character`. 

You can also coerce vectors explicitly using the `as.<class_name>`. Example

~~~ {.r}
as.numeric() 
as.character()
~~~~

R will try to do whatever makes the most sense for that value:

~~~ {.r}
as.character(x)
~~~

~~~ {.output}
[1] "0" "1" "2" "3" "4" "5" "6"
~~~

~~~ {.r}
as.complex(x)
~~~

~~~ {.output}
[1] 0+0i 1+0i 2+0i 3+0i 4+0i 5+0i 6+0i
~~~

~~~ {.r}
x <- 0:6 
as.logical(x)
~~~

~~~ {.output}
[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
~~~

This is behaviour you will find in many programming languages. 0 is
FALSE, while every other number is treated as TRUE.
Sometimes coercions, especially nonsensical ones won't work.

In some cases, R won't be able to do anything sensible:

~~~ {.r}
x <- c("a", "b", "c") 
as.numeric(x) 
as.logical(x)
~~~ 

~~~ {.output}
[1] NA NA NA
Warning message:
NAs introduced by coercion 
~~~

In both cases, a vector of "NAs" was returned, and in the first case
so was a warning. 

> #### Tip: Special Objects {.callout}
>
> "NA" is a special object in R which denotes a missing value. NA can
> occur in any type of vector. There are a few other types of
> special objects: `Inf` denotes infinity (can be positive or negative),
> while `NaN` means Not a number, an undefined value (i.e. `0/0`).
> `NULL` denotes that the data structure doesn't exist (but can occur
> in list elements).
>

You can ask questions about the structure of vectors:

~~~ {.r}
x <- 0:10
tail(x, n=2) # get the last 'n' elements
~~~

~~~ {.output}
[1] 45 33
~~~

~~~ {.r}
head(x, n=1) # get the first 'n' elements
~~~

~~~ {.output}
[1] 33
~~~

~~~ {.r}
length(x) 
~~~

~~~ {.output}
[1] 4
~~~

~~~ {.r}
str(x)
~~~

~~~ {.output}
 num [1:4] 10 12 45 33
~~~

Like data.frames, vectors can also be named:

~~~ {.r}
names(x) <- c("a", "b", "c", "d")
x
~~~

~~~ {.output}
 a  b  c  d 
 10 12 45 33 
~~~

> #### Advanced Tip for Programmers {.callout}
>
> If you're coming from other programming languages you might 
> recognise this as a useful tool akin to dictionaries and hash
> tables. This is true for small vectors, but for true hash table
> functionality, you should use the environment object. See
> `?new.env`.
>

#### Matrices

Another data structure you'll likely encounter are Matrices. Underneath the
hood, they are really just atomic vectors, with added dimension attributes.

We can create one with the `matrix` function. Let's generate some random data:

~~~ {.r}
set.seed(1) # make sure the random numbers are the same for each run
x <- matrix(rnorm(18), ncol=6, nrow=3)
x
~~~

~~~ {.output}
           [,1]       [,2]      [,3]       [,4]       [,5]        [,6]
[1,] -0.6264538  1.5952808 0.4874291 -0.3053884 -0.6212406 -0.04493361
[2,]  0.1836433  0.3295078 0.7383247  1.5117812 -2.2146999 -0.01619026
[3,] -0.8356286 -0.8204684 0.5757814  0.3898432  1.1249309  0.94383621
~~~

~~~ {.r}
str(x)
~~~

~~~ {.output}
num [1:3, 1:6] -0.626 0.184 -0.836 1.595 0.33 ...
~~~

You can use `rownames`, `colnames`, and `dimnames` to set or 
retrieve the column and rownames of a matrix. The functions `nrow` and `ncol` 
will tell you the number of rows and columns (this also applies to data frames!),
while `length` will tell you the number of elements.

>
> ### Challenge 3 {.challenge}
> 
> What do you think will be the result of 
> `length(x)`?
> Try it.
> Were you right? Why / why not?
>

>
> ### Challenge 4 {.challenge}
>
> Make another matrix, this time containing the numbers 1:50,
> with 5 columns and 10 rows.
> Did the `matrix` function fill your matrix by column, or by
> row, as its default behaviour?
> See if you can figure out how to change this.
> (hint: read the documentation for `matrix`!)
>


#### Factors

Factors are special vectors that represent categorical data. Factors can be
ordered or unordered and are important when for modelling functions such as
`aov()`, `lm()` and `glm()` and also in plot methods.

Factors can only contain pre-defined values, and we can create one with the
`factor` function:

~~~ {.r}
x <- factor(c("yes", "no", "no", "yes", "yes"))
x
~~~

~~~ {.output}
[1] yes no  no  yes yes
Levels: no yes
~~~

So we can see that the output is very similar to a character vector, but with an
attached levels component. This becomes clearer when we look at its structure:

~~~ {.r}
str(x)
~~~

~~~ {.output}
 Factor w/ 2 levels "no","yes": 2 1 1 2 2
~~~

This reveals something important: while factors look (and often behave) like
character vectors, they are actually integers under the hood, and here, we can
see that "no" is represented by a 1, and "yes" a 2.

In modelling functions, important to know what baseline levels is.  This is the
first factor but by default the ordering is determined by alphabetical order of
words entered. You can change this by specifying the levels:

~~~ {.r}
x <- factor(c("case", "control", "control", "case"), levels = c("control", "case"))
str(x)
~~~

~~~ {.output}
 Factor w/ 2 levels "case","control": 2 1 1 2
~~~

In this case, we've explicitly told R that "control" should represented by 1, and 
"case" by 2. This designation can be very important for interpreting the
results of statistical models!

#### Lists

If you want to combine different types of data, you will need to use lists.
Lists act as containers, and can contain any type of data structure, even 
themselves!

Lists can be created using `list` or coerced from other objects using `as.list()`:

~~~ {.r} 
x <- list(1, "a", TRUE, 1+4i)
x
~~~

~~~ {.output}
[[1]]
[1] 1

[[2]]
[1] "a"

[[3]]
[1] TRUE

[[4]]
[1] 1+4i
~~~

Each element of the list is denoted by a `[[` in the output. Inside
each list element is an atomic vector of length one containing 

Lists can contain more complex objects:

~~~ {.r}
xlist <- list(a = "Research Bazaar", b = 1:10, data = head(iris))
xlist
~~~

~~~ {.output}
$a
[1] "Research Bazaar"

$b
 [1]  1  2  3  4  5  6  7  8  9 10

$data
   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
   1          5.1         3.5          1.4         0.2  setosa
   2          4.9         3.0          1.4         0.2  setosa
   3          4.7         3.2          1.3         0.2  setosa
   4          4.6         3.1          1.5         0.2  setosa
   5          5.0         3.6          1.4         0.2  setosa
   6          5.4         3.9          1.7         0.4  setosa
~~~

In this case our list contains a character vector of lenght one,
a numeric vector with 10 entries, and a small data frame from
one of R's many preloaded datasets (see `?data`). We've also given
each list element a name, which is why you see `$a` instead of `[[1]]`.

Lists can also contain themselves:

~~~ {.r}
list(list(list(list())))
~~~

~~~ {.output}
[[1]]
[[1]][[1]]
[[1]][[1]][[1]]
list()
~~~

> ### Challenge 5 {.challenge}
> 
> Create a list containing two character vectors for each of the sections in this
> part of the workshop:
> 
> * Data types
> * Data structures
> 
> Populate each character vector with the names of the data types and data 
> structures we've seen so far.
>

Lists are extremely useful inside functions. You can "staple" together lots of
different kinds of results into a single object that a function can return. In
fact many R functions which return complex output store their results in a list.


