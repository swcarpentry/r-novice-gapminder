---
title: "Data Structures"
teaching: 40
exercises: 15
questions:
- "How can I read data in R?"
- "What are the basic data types in R?"
- "How do I represent categorical information in R?"
objectives:
- "To be aware of the different types of data."
- "To begin exploring data frames, and understand how it's related to vectors, factors and lists."
- "To be able to ask questions from R about the type, class, and structure of an object."
keypoints:
- "Use `read.csv` to read tabular data in R."
- "The basic data types in R are double, integer, complex, logical, and character."
- "Use factors to represent categories in R."
---



One of R's most powerful features is its ability to deal with tabular data -
like what you might already have in a spreadsheet or a CSV. Let's start by
making a toy dataset in your `data/` directory, called `feline-data.csv`:


~~~
coat,weight,likes_string
calico,2.1,TRUE
black,5.0,FALSE
tabby,3.2,TRUE
~~~
{: .r}

> ## Tip: Editing Text files in R
>
> Alternatively, you can create `data/feline-data.csv` using a text editor (Nano),
> or within RStudio with the **File -> New File -> Text File** menu item.
{: .callout}



We can load this into R via the following:


~~~
cats <- read.csv(file = "data/feline-data.csv")
cats
~~~
{: .r}



~~~
    coat weight likes_string
1 calico    2.1         TRUE
2  black    5.0        FALSE
3  tabby    3.2         TRUE
~~~
{: .output}


The `read.csv` function is used for reading in tabular data stored in a text
file where the columns of data are delimited by commas (csv = comma separated
values). Tabs are also commonly used to separate columns - if your data are in
this format you can use the function `read.delim`. If the columns in your data
are delimited by a character other than commas or tabs, you can use the more
general and flexible `read.table` function.


We can begin exploring our dataset right away, pulling out columns by specifying
them using the `$` operator:


~~~
cats$weight
~~~
{: .r}



~~~
[1] 2.1 5.0 3.2
~~~
{: .output}



~~~
cats$coat
~~~
{: .r}



~~~
[1] calico black  tabby 
Levels: black calico tabby
~~~
{: .output}

We can do other operations on the columns:


~~~
## Say we discovered that the scale weighs two Kgs light:
cats$weight + 2
~~~
{: .r}



~~~
[1] 4.1 7.0 5.2
~~~
{: .output}



~~~
paste("My cat is", cats$coat)
~~~
{: .r}



~~~
[1] "My cat is calico" "My cat is black"  "My cat is tabby" 
~~~
{: .output}

But what about


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

Understanding what happened here is key to successfully analyzing data in R.

## Data Types

If you guessed that the last command will return an error because `2.1` plus
`"black"` is nonsense, you're right - and you already have some intuition for an
important concept in programming called *data types*. We can ask what type of
data something is:


~~~
typeof(cats$weight)
~~~
{: .r}



~~~
[1] "double"
~~~
{: .output}

There are 5 main types: `double`, `integer`, `complex`, `logical` and `character`.


~~~
typeof(3.14)
~~~
{: .r}



~~~
[1] "double"
~~~
{: .output}



~~~
typeof(1L)
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

Note the `L` suffix to insist that a number is an integer. No matter how
complicated our analyses become, all data in R is interpreted as one of these
basic data types. This strictness has some really important consequences.

A user has added details of another cat. This information is in the file
`data/feline-data_v2.csv`.



~~~
file.show("data/feline-data_v2.csv")
~~~
{: .r}


~~~
coat,weight,likes_string
calico,2.1,TRUE
black,5.0,FALSE
tabby,3.2,TRUE
tabby,2.3 or 2.4,TRUE
~~~
{: .r}

Load the new cats data like before, and check what type of data we find in the
`weight` column:


~~~
cats <- read.csv(file="data/feline-data_v2.csv")
typeof(cats$weight)
~~~
{: .r}



~~~
[1] 2.1        5          3.2        2.3 or 2.4
Levels: 2.1 2.3 or 2.4 3.2 5
~~~
{: .output}


Oh no, our weights aren't the double type anymore! If we try to do the same math
we did on them before, we run into trouble:


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

What happened? When R reads a csv into one of these tables, it insists that
everything in a column be the same basic type; if it can't understand
*everything* in the column as a double, then *nobody* in the column gets to be a
double. The table that R loaded our cats data into is something called a
*data.frame*, and it is our first example of something called a *data
structure* - that is, a structure which R knows how to build out of the basic
data types.

We can see that it is a *data.frame* by calling the `class` function on it:


~~~
class(cats)
~~~
{: .r}



~~~
[1] "data.frame"
~~~
{: .output}

In order to successfully use our data in R, we need to understand what the basic
data structures are, and how they behave. For now, let's remove that extra line
from our cats data and reload it, while we investigate this behavior further:

feline-data.csv:

```
coat,weight,likes_string
calico,2.1,TRUE
black,5.0,FALSE
tabby,3.2,TRUE
```

And back in RStudio:


~~~
cats <- read.csv(file="data/feline-data.csv")
~~~
{: .r}




## Vectors and Type Coercion

To better understand this behavior, let's meet another of the data structures:
the *vector*.


~~~
my_vector <- vector(length = 3)
my_vector
~~~
{: .r}



~~~
[1] FALSE FALSE FALSE
~~~
{: .output}

A vector in R is essentially an ordered list of things, with the special
condition that *everything in the vector must be the same basic data type*. If
you don't choose the datatype, it'll default to `logical`; or, you can declare
an empty vector of whatever type you like.



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

The somewhat cryptic output from this command indicates the basic data type
found in this vector - in this case `chr`, character; an indication of the
number of things in the vector - actually, the indexes of the vector, in this
case `[1:3]`; and a few examples of what's actually in the vector - in this case
empty character strings. If we similarly do


~~~
str(cats$weight)
~~~
{: .r}



~~~
 num [1:3] 2.1 5 3.2
~~~
{: .output}

we see that that's a vector, too - *the columns of data we load into R
data.frames are all vectors*, and that's the root of why R forces everything in
a column to be the same basic data type.

> ## Discussion 1
>
> Why is R so opinionated about what we put in our columns of data?
> How does this help us?
>
> > ## Discussion 1
> >
> > By keeping everything in a column the same, we allow ourselves to make simple
> > assumptions about our data; if you can interpret one entry in the column as a
> > number, then you can interpret *all* of them as numbers, so we don't have to
> > check every time. This consistency, like consistently using the same separator
> > in our data files, is what people mean when they talk about *clean data*; in
> > the long run, strict consistency goes a long way to making our lives easier in
> > R.
> {: .solution}
{: .discussion}

You can also make vectors with explicit contents with the concatenate function:


~~~
concat_vector <- c(2,6,3)
concat_vector
~~~
{: .r}



~~~
[1] 2 6 3
~~~
{: .output}

Given what we've learned so far, what do you think the following will produce?


~~~
quiz_vector <- c(2,6,'3')
~~~
{: .r}

This is something called *type coercion*, and it is the source of many surprises
and the reason why we need to be aware of the basic data types and how R will
interpret them. When R encounters a mix of types (here numeric and character) to
be combined into a single vector, it will force them all to be the same
type. Consider:


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

The coercion rules go: `logical` -> `integer` -> `numeric` -> `complex` ->
`character`, where -> can be read as *are transformed into*. You can try to
force coercion against this flow using the `as.` functions:


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

As you can see, some surprising things can happen when R forces one basic data
type into another! Nitty-gritty of type coercion aside, the point is: if your
data doesn't look like what you thought it was going to look like, type coercion
may well be to blame; make sure everything is the same type in your vectors and
your columns of data.frames, or you will get nasty surprises!

But coercion can also be very useful! For example, in our `cats` data *change*
`likes_string` to numeric, we know that the 1s and 0s actually represent
`TRUE` and `FALSE` (a common way of representing them). We should use the
`logical` datatype here, which has two states: `TRUE` or `FALSE`, which is
exactly what our data represents. We can 'coerce' this column to be `logical` by
using the `as.logical` function:


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

Concatenate will also append things to an existing vector:


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
concat_example <- c(ab_vector, 'SWC')
concat_example
~~~
{: .r}



~~~
[1] "a"   "b"   "SWC"
~~~
{: .output}

You can also make series of numbers:


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

We can ask a few questions about vectors:


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

Finally, you can give names to elements in your vector:


~~~
names_example <- 5:8
names(names_example) <- c("a", "b", "c", "d")
names_example
~~~
{: .r}



~~~
a b c d 
5 6 7 8 
~~~
{: .output}



~~~
names(names_example)
~~~
{: .r}



~~~
[1] "a" "b" "c" "d"
~~~
{: .output}

> ## Challenge 1
>
> Start by making a vector with the numbers 1 through 26.
> Multiply the vector by 2, and give the resulting vector
> names A through Z (hint: there is a built in vector called `LETTERS`)
>
> > ## Solution to Challenge 1
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

We said that columns in data.frames were vectors:


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

These make sense. But what about


~~~
str(cats$coat)
~~~
{: .r}



~~~
 Factor w/ 3 levels "black","calico",..: 2 1 3
~~~
{: .output}

## Factors

Another important data structure is called a *factor*. Factors usually look like
character data, but are typically used to represent categorical information. For
example, let's make a vector of strings labelling cat colorations for all the
cats in our study:


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
 chr [1:5] "tabby" "tortoiseshell" "tortoiseshell" "black" ...
~~~
{: .output}

We can turn a vector into a factor like so:


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

Now R has noticed that there are three possible categories in our data - but it
also did something surprising; instead of printing out the strings we gave it,
we got a bunch of numbers instead. R has replaced our human-readable categories
with numbered indices under the hood:


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

> ## Challenge 2
>
> Is there a factor in our `cats` data.frame? what is its name?
> Try using `?read.csv` to figure out how to keep text columns as character
> vectors instead of factors; then write a command or two to show that the factor
> in `cats` is actually a character vector when loaded in this way.
>
> > ## Solution to Challenge 2
> > 
> > ~~~
> > cats <- read.csv(file="data/feline-data.csv", stringsAsFactors=FALSE)
> > str(cats$coat)
> > ~~~
> > {: .r}
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

## Lists

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
another_list <- list(title = "Research Bazaar", numbers = 1:10, data = TRUE )
another_list
~~~
{: .r}



~~~
$title
[1] "Research Bazaar"

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
thus can be composed of element of different types.


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

> ## Challenge 3
>
> There are several subtly different ways to call variables, observations and
> elements from data.frames:
>
> - `cats[1]`
> - `cats[[1]]`
> - `cats$coat`
> - `cats`["coat"]
> - `cats[1, 1]`
> - `cats[, 1]`
> - `cats[1, ]`
>
> Try out these examples and explain what is returned by each one.
>
> *Hint:* Use the function `typeof()` to examine what is returned in each case.
>
> > ## Solution to Challenge 3
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
> > We can think of a data frame as a list of vectors. The single brace `[1]`
> returns the first slice of the list, as another list. In this case it is the
> first column of the data frame.
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

Last but not least is the matrix. We can declare a matrix full of zeros:


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

And similar to other data structures, we can ask things about our matrix:


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

> ## Challenge 4
>
> What do you think will be the result of
> `length(matrix_example)`?
> Try it.
> Were you right? Why / why not?
>
> > ## Solution to Challenge 4
> >
> > What do you think will be the result of
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


> ## Challenge 5
>
> Make another matrix, this time containing the numbers 1:50,
> with 5 columns and 10 rows.
> Did the `matrix` function fill your matrix by column, or by
> row, as its default behaviour?
> See if you can figure out how to change this.
> (hint: read the documentation for `matrix`!)
>
> > ## Solution to Challenge 5
> >
> > Make another matrix, this time containing the numbers 1:50,
> > with 5 columns and 10 rows.
> > Did the `matrix` function fill your matrix by column, or by
> > row, as its default behaviour?
> > See if you can figure out how to change this.
> > (hint: read the documentation for `matrix`!)
> >
> > 
> > ~~~
> > x <- matrix(1:50, ncol=5, nrow=10)
> > x <- matrix(1:50, ncol=5, nrow=10, byrow = TRUE) # to fill by row
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


> ## Challenge 6
>  Create a list of length two containing a character vector for each of the sections in this part of the workshop:
>
>  - Data types
>  - Data structures
>
>  Populate each character vector with the names of the data types and data
>  structures we've seen so far.
>
> > ## Solution to Challenge 6
> > 
> > ~~~
> > dataTypes <- c('double', 'complex', 'integer', 'character', 'logical')
> > dataStructures <- c('data.frame', 'vector', 'factor', 'list', 'matrix')
> > answer <- list(dataTypes, dataStructures)
> > ~~~
> > {: .r}
> > Note: it's nice to make a list in big writing on the board or taped to the wall
> > listing all of these types and structures - leave it up for the rest of the workshop
> > to remind people of the importance of these basics.
> >
> {: .solution}
{: .challenge}


> ## Challenge 7
>
> Consider the R output of the matrix below:
> 
> ~~~
>      [,1] [,2]
> [1,]    4    1
> [2,]    9    5
> [3,]   10    7
> ~~~
> {: .output}
> What was the correct command used to write this matrix? Examine
> each command and try to figure out the correct one before typing them.
> Think about what matrices the other commands will produce.
>
> 1. `matrix(c(4, 1, 9, 5, 10, 7), nrow = 3)`
> 2. `matrix(c(4, 9, 10, 1, 5, 7), ncol = 2, byrow = TRUE)`
> 3. `matrix(c(4, 9, 10, 1, 5, 7), nrow = 2)`
> 4. `matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)`
>
> > ## Solution to Challenge 7
> >
> > Consider the R output of the matrix below:
> > 
> > ~~~
> >      [,1] [,2]
> > [1,]    4    1
> > [2,]    9    5
> > [3,]   10    7
> > ~~~
> > {: .output}
> > What was the correct command used to write this matrix? Examine
> > each command and try to figure out the correct one before typing them.
> > Think about what matrices the other commands will produce.
> > 
> > ~~~
> > matrix(c(4, 1, 9, 5, 10, 7), ncol = 2, byrow = TRUE)
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}
