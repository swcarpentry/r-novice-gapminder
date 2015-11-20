---
layout: page
title: R for reproducible scientific analysis
subtitle: Data frames and reading in data
minutes: 45
---



> ## Learning Objectives {.objectives}
>
> * Become familiar with data frames
> * Be able to read regular data into R
>

## Data frames

Data frames are similar to matrices, except each column can be a
different atomic type. A data frames is the standard structure for
storing and manipulating rectangular data sets.  Underneath the hood,
data frames are really lists, where each element is an atomic vector,
with the added restriction that they're all the same length.  As you
will see, if we pull out one column of a data frame,we will have a
vector. You will probably find that data frames are more complicated
than vectors and other data structures we have considered, but they
provide powerful capabilities.


Data frames can be created manually with the `data.frame` function:


~~~{.r}
df <- data.frame(id = c('a', 'b', 'c', 'd', 'e', 'f'), x = 1:6, y = c(214:219))
df
~~~



~~~{.output}
  id x   y
1  a 1 214
2  b 2 215
3  c 3 216
4  d 4 217
5  e 5 218
6  f 6 219

~~~

> ## Challenge 1: Data frames {.challenge}
>
> Try using the `length` function to query
> your data frame `df`. Does it give the result
> you expect?
>

Each column in the data frame is simply a list element, which is why
when you ask for the `length` of the data frame, it tells you the
number of columns. If you actually want the number of rows, you can
use the `nrow` function.

We can add columns or rows to a data.frame using `cbind` or `rbind`
(these are the two-dimensional equivalents of the `c` function):

## Adding columns to a data frame

To add a column we can use `cbind`:


~~~{.r}
df <- cbind(df, 6:1)
df
~~~



~~~{.output}
  id x   y 6:1
1  a 1 214   6
2  b 2 215   5
3  c 3 216   4
4  d 4 217   3
5  e 5 218   2
6  f 6 219   1

~~~

Note that R automatically names the column. We may decide to change
the name by assigning a value using the `names` function:


~~~{.r}
names(df)[4] <- 'SixToOne'
~~~

We can also provide a name when we add the column:


~~~{.r}
df <- cbind(df, caps=LETTERS[1:6])
df
~~~



~~~{.output}
  id x   y SixToOne caps
1  a 1 214        6    A
2  b 2 215        5    B
3  c 3 216        4    C
4  d 4 217        3    D
5  e 5 218        2    E
6  f 6 219        1    F

~~~

(`LETTERS` and `letters` are built-in constants.)


## Adding rows to a data frame 

To add a row we use `rbind`:


~~~{.r}
df <- rbind(df, list("g", 11, 42, 0, "G"))
~~~



~~~{.error}
Warning in `[<-.factor`(`*tmp*`, ri, value = "g"): invalid factor level, NA
generated

~~~



~~~{.error}
Warning in `[<-.factor`(`*tmp*`, ri, value = "G"): invalid factor level, NA
generated

~~~

Note that we add the row as a list, because we have multiple types
across the columns. Nevertheless, this doesn't work as expected! What
do the error messages tell us?

It appears that R was trying to append "g" and "G" as factor
levels. Why? Let's examine the first column.  We can access a column
in a `data.frame` by using the `$` operator.



~~~{.r}
class(df$id)
~~~



~~~{.output}
[1] "factor"

~~~



~~~{.r}
str(df)
~~~



~~~{.output}
'data.frame':	7 obs. of  5 variables:
 $ id      : Factor w/ 6 levels "a","b","c","d",..: 1 2 3 4 5 6 NA
 $ x       : num  1 2 3 4 5 6 11
 $ y       : num  214 215 216 217 218 219 42
 $ SixToOne: num  6 5 4 3 2 1 0
 $ caps    : Factor w/ 6 levels "A","B","C","D",..: 1 2 3 4 5 6 NA

~~~

When we created the data frame, R automatically made the first
and last columns into factors, not character vectors. There are no
pre-existing levels "g" and "G", so the attempt to add these values
fails. A row was added to the data frame, only there are missing
values in the factor columns:


~~~{.r}
df
~~~



~~~{.output}
    id  x   y SixToOne caps
1    a  1 214        6    A
2    b  2 215        5    B
3    c  3 216        4    C
4    d  4 217        3    D
5    e  5 218        2    E
6    f  6 219        1    F
7 <NA> 11  42        0 <NA>

~~~


There are two ways we can work around this issue:

1. We can convert the factor columns into characters. This is
convenient, but we lose the factor structure. 

2. We can add factor levels to accomodate the new additions. If we
really do want the columns to be factors, this is the correct way to
proceed.

We will illustrate both solutions in the same data frame:


~~~{.r}
df$id <- as.character(df$id)  # convert to character
class(df$id)
~~~



~~~{.output}
[1] "character"

~~~



~~~{.r}
levels(df$caps) <- c(levels(df$caps), 'G') # add a factor level
class(df$caps)
~~~



~~~{.output}
[1] "factor"

~~~

Okay, now let's try adding that row again.


~~~{.r}
df <- rbind(df, list("g", 11, 42, 0, 'G'))
tail(df, n=3)
~~~



~~~{.output}
    id  x   y SixToOne caps
6    f  6 219        1    F
7 <NA> 11  42        0 <NA>
8    g 11  42        0    G

~~~

We successfully added the last row, but we have an undesired row with
two `NA` values. How do delete it?

## Deleting rows and handling NA


There are multiple ways to delete a row containing `NA`:


~~~{.r}
df[-7, ]  # The minus sign tells R to delete the row
~~~



~~~{.output}
  id  x   y SixToOne caps
1  a  1 214        6    A
2  b  2 215        5    B
3  c  3 216        4    C
4  d  4 217        3    D
5  e  5 218        2    E
6  f  6 219        1    F
8  g 11  42        0    G

~~~



~~~{.r}
df[complete.cases(df), ]  # Return `TRUE` when no missing values
~~~



~~~{.output}
  id  x   y SixToOne caps
1  a  1 214        6    A
2  b  2 215        5    B
3  c  3 216        4    C
4  d  4 217        3    D
5  e  5 218        2    E
6  f  6 219        1    F
8  g 11  42        0    G

~~~



~~~{.r}
na.omit(df)  # Another function for the same purpose
~~~



~~~{.output}
  id  x   y SixToOne caps
1  a  1 214        6    A
2  b  2 215        5    B
3  c  3 216        4    C
4  d  4 217        3    D
5  e  5 218        2    E
6  f  6 219        1    F
8  g 11  42        0    G

~~~



~~~{.r}
df <- na.omit(df)
~~~

## Combining data frames

We  can also row-bind data.frames together, but notice what happens to
the rownames:


~~~{.r}
rbind(df, df)
~~~



~~~{.output}
   id  x   y SixToOne caps
1   a  1 214        6    A
2   b  2 215        5    B
3   c  3 216        4    C
4   d  4 217        3    D
5   e  5 218        2    E
6   f  6 219        1    F
8   g 11  42        0    G
11  a  1 214        6    A
21  b  2 215        5    B
31  c  3 216        4    C
41  d  4 217        3    D
51  e  5 218        2    E
61  f  6 219        1    F
81  g 11  42        0    G

~~~

R is making sure that rownames are unique. You can restore sequential
numbering by setting rownames to NULL:


~~~{.r}
df2 <- rbind(df, df)
rownames(df2) <- NULL
df2
~~~



~~~{.output}
   id  x   y SixToOne caps
1   a  1 214        6    A
2   b  2 215        5    B
3   c  3 216        4    C
4   d  4 217        3    D
5   e  5 218        2    E
6   f  6 219        1    F
7   g 11  42        0    G
8   a  1 214        6    A
9   b  2 215        5    B
10  c  3 216        4    C
11  d  4 217        3    D
12  e  5 218        2    E
13  f  6 219        1    F
14  g 11  42        0    G

~~~


<!-- 
When we add a row we need to use a list, because each column is
a different type!  If you want to add multiple rows to a data.frame,
you will need to separate the new columns in the list:


~~~{.r}
df <- rbind(df, list(c("l", "m"), c(12, 13), c(534, -20), c(-1, -2),
c('H', 'I')))
~~~



~~~{.error}
Warning in `[<-.factor`(`*tmp*`, ri, value = c("H", "I")): invalid factor
level, NA generated

~~~



~~~{.r}
tail(df, n=3)
~~~



~~~{.output}
   id  x   y SixToOne caps
8   g 11  42        0    G
81  l 12 534       -1 <NA>
9   m 13 -20       -2 <NA>

~~~
-->

> ## Challenge 2 {.challenge}
>
> Create a data frame that holds the following information for yourself:
>
> * First name
> * Last name
> * Age
>
> Then use rbind to add the same information for the people sitting near you.
>
> Now use cbind to add a column of logicals that will, for each
>person, hold the answer to the question,
> "Is there anything in this workshop you're finding confusing?"
>

## Reading in data

Remember earlier we obtained the gapminder dataset.
If you're curious about where this data comes from you might like to
look at the [Gapminder website](http://www.gapminder.org/data/documentation/).

Now we want to load the gapminder data into R.
Before reading in data, it's a good idea to have a look at its structure.
Let's take a look using our newly-learned shell skills:


~~~{.r}
cd data/ # navigate to the data directory of the project folder
head gapminder-FiveYearData.csv
~~~




~~~{.output}
country,year,pop,continent,lifeExp,gdpPercap
Afghanistan,1952,8425333,Asia,28.801,779.4453145
Afghanistan,1957,9240934,Asia,30.332,820.8530296
Afghanistan,1962,10267083,Asia,31.997,853.10071
Afghanistan,1967,11537966,Asia,34.02,836.1971382
Afghanistan,1972,13079460,Asia,36.088,739.9811058
Afghanistan,1977,14880372,Asia,38.438,786.11336
Afghanistan,1982,12881816,Asia,39.854,978.0114388
Afghanistan,1987,13867957,Asia,40.822,852.3959448
Afghanistan,1992,16317921,Asia,41.674,649.3413952

~~~

As its file extension would suggest, the file contains comma-separated
values, and seems to contain a header row.

We can use `read.table` to read this into R


~~~{.r}
gapminder <- read.table(
  file="data/gapminder-FiveYearData.csv",
  header=TRUE, sep=","
)
head(gapminder)
~~~



~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134

~~~

Because we know the structure of the data, we're able
to specify the appropriate arguments to `read.table`.
Without these arguments, `read.table` will do its
best to do something sensible, but it is always more
reliable to explicitly tell `read.table` the structure
of the data. `read.csv` function provides a convenient shortcut
for loading in CSV files.


~~~{.r}
# Here is the read.csv version of the above command
gapminder <- read.csv(
  file="data/gapminder-FiveYearData.csv"
)
head(gapminder)
~~~



~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134

~~~

> ## Miscellaneous Tips {.callout}
>
> 1. Another type of file you might encounter are tab-separated
> format. To specify a tab as a separator, use `"\t"`.
>
> 2. You can also read in files from the Internet by replacing
> the file paths with a web address.
>
> 3. You can read directly from excel spreadsheets without
> converting them to plain text first by using the `xlsx` package.
>

To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later.

> ## Challenge 3 {.challenge}
>
> Go to file -> new file -> R script, and write an R script
> to load in the gapminder dataset. Put it in the `scripts/`
> directory and add it to version control.
>
> Run the script using the `source` function, using the file path
> as its argument (or by pressing the "source" button in RStudio).
>

## Using data frames: the `gapminder` dataset


To recap what we've just learned, let's have a look at our example
data (life expectancy in various countries for various years).

Remember, there are a few functions we can use to interrogate data structures in R:


~~~{.r}
class() # what is the data structure?
typeof() # what is its atomic type?
length() # how long is it? What about two dimensional objects?
attributes() # does it have any metadata?
str() # A full summary of the entire object
dim() # Dimensions of the object - also try nrow(), ncol()
~~~

Let's use them to explore the gapminder dataset.


~~~{.r}
typeof(gapminder)
~~~



~~~{.output}
[1] "list"

~~~

Remember, data frames are lists 'under the hood'.


~~~{.r}
class(gapminder)
~~~



~~~{.output}
[1] "data.frame"

~~~

The gapminder data is stored in a "data.frame". This is the default
data structure when you read in data, and (as we've heard) is useful
for storing data with mixed types of columns.

Let's look at some of the columns.

> ## Challenge 4: Data types in a real dataset {.challenge}
>
> Look at the first 6 rows of the gapminder data frame we loaded before:
>
> 
> ~~~{.r}
> head(gapminder)
> ~~~
> 
> 
> 
> ~~~{.output}
>       country year      pop continent lifeExp gdpPercap
> 1 Afghanistan 1952  8425333      Asia  28.801  779.4453
> 2 Afghanistan 1957  9240934      Asia  30.332  820.8530
> 3 Afghanistan 1962 10267083      Asia  31.997  853.1007
> 4 Afghanistan 1967 11537966      Asia  34.020  836.1971
> 5 Afghanistan 1972 13079460      Asia  36.088  739.9811
> 6 Afghanistan 1977 14880372      Asia  38.438  786.1134
> 
> ~~~
>
> Write down what data type you think is in each column
>



~~~{.r}
typeof(gapminder$year)
~~~



~~~{.output}
[1] "integer"

~~~



~~~{.r}
typeof(gapminder$lifeExp)
~~~



~~~{.output}
[1] "double"

~~~

Can anyone guess what we should expect the type of the continent column to be?


~~~{.r}
typeof(gapminder$continent)
~~~



~~~{.output}
[1] "integer"

~~~

If you were expecting a the answer to be "character", you would rightly be
surprised by the answer. Let's take a look at the class of this column:


~~~{.r}
class(gapminder$continent)
~~~



~~~{.output}
[1] "factor"

~~~

One of the default behaviours of R is to treat any text columns as "factors"
when reading in data. The reason for this is that text columns often represent
categorical data, which need to be factors to be handled appropriately by
the statistical modeling functions in R.

However it's not obvious behaviour, and something that trips many people up. We can
disable this behaviour and read in the data again.


~~~{.r}
options(stringsAsFactors=FALSE)
gapminder <- read.table(
  file="data/gapminder-FiveYearData.csv", header=TRUE, sep=","
)
~~~

Remember, if you do turn it off automatic conversion to factors you will need to
explicitly convert the variables into factors when
running statistical models.
This can be useful, because it forces you to think about the
question you're asking, and makes it easier to specify the ordering of the categories.

However there are many in the R community who find it more sensible to
leave this as the default behaviour.

> ## Tip: Changing options {.callout} 
> When R starts, it runs any
>code in the file `.Rprofile` in the project directory. You can make
>permanent changes to default behaviour by storing the changes in that
>file. BE CAREFUL, however. If you change R's default options,
>programs written by others may not run correctly in your environment
>and vice versa. For this reason, some argue that most such changes
>should be in your scripts, where they are visible.

The first thing you should do when reading data in, is check that it matches what
you expect, even if the command ran without warnings or errors. The `str` function,
short for "structure", is really useful for this:


~~~{.r}
str(gapminder)
~~~



~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

We can see that the object is a `data.frame` with 1,704 observations (rows),
and 6 variables (columns). Below that, we see the name of each column, followed
by a ":", followed by the type of variable in that column, along with the first
few entries.

As discussed above, we can retrieve or modify the column or row names
of the data.frame:


~~~{.r}
colnames(gapminder)  
~~~



~~~{.output}
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"

~~~



~~~{.r}
copy <- gapminder
colnames(copy) <- letters[1:6]
head(copy, n=3)
~~~



~~~{.output}
            a    b        c    d      e        f
1 Afghanistan 1952  8425333 Asia 28.801 779.4453
2 Afghanistan 1957  9240934 Asia 30.332 820.8530
3 Afghanistan 1962 10267083 Asia 31.997 853.1007

~~~

> ## Challenge 5 {.challenge}
>
> Recall that we also used the `names` function (above) to modify
> column names. Does it matter which you use? You can check help with
> `?names` and `?colnames` to see whether it should matter.



~~~{.r}
rownames(gapminder)[1:20]
~~~



~~~{.output}
 [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14"
[15] "15" "16" "17" "18" "19" "20"

~~~

See those numbers in the square brackets on the left? That tells you
the number of the first entry in that row of output. So we see that
for the 5th row, the rowname is "5". In this case, the rownames are
simply the row numbers.


There are a few related ways of retrieving and modifying this information.
`attributes` will give you both the row and column names, along with the
class information, while `dimnames` will give you just the rownames and
column names.

In both cases, the output object is stored in a `list`:


~~~{.r}
str(dimnames(gapminder))
~~~



~~~{.output}
List of 2
 $ : chr [1:1704] "1" "2" "3" "4" ...
 $ : chr [1:6] "country" "year" "pop" "continent" ...

~~~

## Understanding how lists are used in function output


Lets run a basic linear regression on the gapminder dataset:


~~~{.r}
# What is the relationship between life expectancy and year?
reg <- lm(lifeExp ~ year, data=gapminder)
~~~

We won't go into too much detail, but briefly: 

* `lm` estimates linear statistical models
* The first argument is a formula, with  `a ~ b` meaning that `a`,
     the dependent (or response) variable, is a
    function of `b`, the independent variable. 
* We tell `lm` to use the gapminder data frame, so it knows where to
 find the variables `lifeExp` and `year`. 



Let's look at the output:


~~~{.r}
reg
~~~



~~~{.output}

Call:
lm(formula = lifeExp ~ year, data = gapminder)

Coefficients:
(Intercept)         year  
  -585.6522       0.3259  

~~~

Not much there right? But if we look at the structure...


~~~{.r}
str(reg)
~~~



~~~{.output}
List of 12
 $ coefficients : Named num [1:2] -585.652 0.326
  ..- attr(*, "names")= chr [1:2] "(Intercept)" "year"
 $ residuals    : Named num [1:1704] -21.7 -21.8 -21.8 -21.4 -20.9 ...
  ..- attr(*, "names")= chr [1:1704] "1" "2" "3" "4" ...
 $ effects      : Named num [1:1704] -2455.1 232.2 -20.8 -20.5 -20.2 ...
  ..- attr(*, "names")= chr [1:1704] "(Intercept)" "year" "" "" ...
 $ rank         : int 2
 $ fitted.values: Named num [1:1704] 50.5 52.1 53.8 55.4 57 ...
  ..- attr(*, "names")= chr [1:1704] "1" "2" "3" "4" ...
 $ assign       : int [1:2] 0 1
 $ qr           :List of 5
  ..$ qr   : num [1:1704, 1:2] -41.2795 0.0242 0.0242 0.0242 0.0242 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:1704] "1" "2" "3" "4" ...
  .. .. ..$ : chr [1:2] "(Intercept)" "year"
  .. ..- attr(*, "assign")= int [1:2] 0 1
  ..$ qraux: num [1:2] 1.02 1.03
  ..$ pivot: int [1:2] 1 2
  ..$ tol  : num 1e-07
  ..$ rank : int 2
  ..- attr(*, "class")= chr "qr"
 $ df.residual  : int 1702
 $ xlevels      : Named list()
 $ call         : language lm(formula = lifeExp ~ year, data = gapminder)
 $ terms        :Classes 'terms', 'formula' length 3 lifeExp ~ year
  .. ..- attr(*, "variables")= language list(lifeExp, year)
  .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:2] "lifeExp" "year"
  .. .. .. ..$ : chr "year"
  .. ..- attr(*, "term.labels")= chr "year"
  .. ..- attr(*, "order")= int 1
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. ..- attr(*, "predvars")= language list(lifeExp, year)
  .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. ..- attr(*, "names")= chr [1:2] "lifeExp" "year"
 $ model        :'data.frame':	1704 obs. of  2 variables:
  ..$ lifeExp: num [1:1704] 28.8 30.3 32 34 36.1 ...
  ..$ year   : int [1:1704] 1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
  ..- attr(*, "terms")=Classes 'terms', 'formula' length 3 lifeExp ~ year
  .. .. ..- attr(*, "variables")= language list(lifeExp, year)
  .. .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. .. ..$ : chr [1:2] "lifeExp" "year"
  .. .. .. .. ..$ : chr "year"
  .. .. ..- attr(*, "term.labels")= chr "year"
  .. .. ..- attr(*, "order")= int 1
  .. .. ..- attr(*, "intercept")= int 1
  .. .. ..- attr(*, "response")= int 1
  .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. .. ..- attr(*, "predvars")= language list(lifeExp, year)
  .. .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. .. ..- attr(*, "names")= chr [1:2] "lifeExp" "year"
 - attr(*, "class")= chr "lm"

~~~

There's a great deal stored in nested lists! The structure function
allows you to see all the data available, in this case, the data that
was returned by the `lm` function.

For now, we can look at the `summary`:


~~~{.r}
summary(reg)
~~~



~~~{.output}

Call:
lm(formula = lifeExp ~ year, data = gapminder)

Residuals:
    Min      1Q  Median      3Q     Max 
-39.949  -9.651   1.697  10.335  22.158 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) -585.65219   32.31396  -18.12   <2e-16 ***
year           0.32590    0.01632   19.96   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 11.63 on 1702 degrees of freedom
Multiple R-squared:  0.1898,	Adjusted R-squared:  0.1893 
F-statistic: 398.6 on 1 and 1702 DF,  p-value: < 2.2e-16

~~~

As you might expect, life expectancy has slowly been increasing over
time, so we see a significant positive association!


## Challenge Solutions

> ## Solution to Challenge 2 {.challenge}
>
> Create a data frame that holds the following information for yourself:
>
> * First name
> * Last name
> * Age
>
> Then use rbind to add the same information for the people sitting near you.
>
> Now use cbind to add a column of logicals answering the question,
> "Is there anything in this workshop you're finding confusing?"
>
> 
> ~~~{.r}
> my_df <- data.frame(first_name = "Software", last_name = "Carpentry", age = 17)
> my_df <- rbind(my_df, list("Jane", "Smith", 29))
> my_df <- rbind(my_df, list(c("Jo", "John"), c("White", "Lee"), c(23, 41)))
> my_df <- cbind(my_df, confused = c(FALSE, FALSE, TRUE, FALSE))
> ~~~

> ## Solution to Challenge 5 {.challenge}
> 
> `?colnames` tells you that the `colnames` function is the same as
> `names` for a data frame. For other structures, they may not be the
> same. In particular, `names` does not work for matrices, but
> `colnames` does. You can verify this with 
> 
> ~~~{.r}
> m <- matrix(1:9, nrow=3)
> colnames(m) <- letters[1:3] # works as you would expect
> names(m) <- letters[1:3]  # destroys the matrix
> ~~~
