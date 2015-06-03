---
layout: page
title: R for reproducible scientific analysis
subtitle: Subsetting data
minutes: 15
---

> ### Learning Objectives {.objectives}
>
> * To be able to subset vectors, factors, matrices, lists, and data frames
> * To be able to extract individual and multiple elements:
>     * by index,
>     * by name,
>     * using comparison operations
> * To be able to skip and remove elements from various data structures.
>

R has many powerful subset operators and mastering them will allow you to
easily perform complex operations on any kind of dataset.

There are six different ways we can subset any kind of object, and three 
different subsetting operators for the different data structures.

Let's start with the workhorse of R: atomic vectors.

~~~ {.r}
x <- c(5.4, 6.2, 7.1, 4.8, 7.5) 
names(x) <- c('a', 'b', 'c', 'd', 'e')
~~~

So now that we've created a dummy vector to play with, how do we get at its
contents?

### Accessing elements using their indices

To extract elements of a vector we can give their corresponding index, starting 
from one:

~~~ {.r}
x[1]
~~~
~~~ {.output}
  a 
5.4
~~~

~~~ {.r}
x[4]
~~~

~~~ {.output}
  d 
4.8 
~~~

The square brackets operator is just like any other function. For atomic vectors 
(and matrices), it means "get me the nth element".

We can ask for multiple elements at once:

~~~ {.r}
x[c(1, 3)]
~~~

~~~ {.output}
  a   c 
5.4 7.1
~~~

Or slices of the vector:

~~~ {.r}
x[1:4]
~~~

~~~ {.output}
  a   b   c   d 
5.4 6.2 7.1 4.8 
~~~

the `:` operator just creates a sequence of numbers from the left element to the right.
I.e. `x[1:4]` is equivalent to `x[c(1,2,3,4)]`.

We can ask for the same element multiple times:

~~~ {.r}
x[c(1,1,3)]
~~~

~~~ {.output}
  a   a   c 
5.4 5.4 7.1 
~~~

If we ask for a number outside of the vector, R will return missing values:

~~~ {.r}
x[6]
~~~

~~~ {.output}
<NA> 
  NA
~~~

This is a vector of length one containing an `NA`, whose name is also `NA`.

If we ask for the 0th element, we get an empty vector:

~~~ {.r}
x[0]
~~~

~~~ {.output}
named numeric(0)
~~~

But what about negative values?

### Skipping and removing elements

If we use a negative number, R will return every element *except* for the
one specified:

~~~ {.r}
x[-2]
~~~

~~~ {.output}
  a   c   d   e 
5.4 7.1 4.8 7.5 
~~~

We can skip multiple elements:

~~~ {.r}
x[c(-1, -5)]  # or x[-c(1,5)]
~~~

~~~ {.output}
  b   c   d 
6.2 7.1 4.8 
~~~

> #### Tip: Order of operations {.callout}
>
> A common trip up for novices occurs when trying to skip
> slices of a vector. Most people first try to negate a
> sequence like so: 
>
> ~~~ {.r}
> x[-1:3]
> ~~~
> 
> This gives a somewhat cryptic error:
>
> ~~~ {.output}
> Error in x[-1:3] : only 0's may be mixed with negative subscripts
> ~~~
>
> But remember the order of operations. `:` is really a function, so
> what happens is it takes its first argument as -1, and second as 3,
> so generates the sequence of numbers: `c(-1, 0, 1, 2, 3)`. 
>
> The correct solution is to wrap that function call in brackets, so
> that the `-` operator applies to the results:
>
> ~~~ {.r}
> x[-(1:3)]
> ~~~
>
> ~~~ {.output}
>   d   e 
> 4.8 7.5 
> ~~~
>

To remove elements from a vector, we need to assign the results back
into the variable:

~~~ {.r}
x <- x[-4]
x
~~~

~~~ {.output}
  a   b   c   e 
5.4 6.2 7.1 7.5 
~~~

> #### Challenge {.challenge}
>
> ~~~ {.r}
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
>
> ~~~ {.output}
>   a   b   c   d   e
> 5.4 6.2 7.1 4.8 7.5
> ~~~
>
> 1. Come up with at least 3 different commands that will produce the following output:
>
> ~~~ {.output}
>   b   c   d
> 6.2 7.1 4.8 
> ~~~
>
> 2. Compare notes with your neighbour. Did you have different strategies?
>

### Subsetting by name

We can extract elements by using their name, instead of index:

~~~ {.r}
x[c("a", "c")]
~~~

~~~ {.output}
  a   c 
5.4 7.1 
~~~

This is usually a much more reliable way to subset objects: the 
position of various elements can often change when chaining together 
subsetting operations, but the names will always remain the same!

Unfortunately we can't skip or remove elements so easily.

To skip (or remove) a single named element:

~~~ {.r}
x[-which(names(x) == "a"))]
~~~

~~~ {.output}
  b   c   e 
6.2 7.1 7.5 
~~~

The `which` function returns the indices of all `TRUE` elements of its argument.
Remember that expressions evaluate before being passed to functions. Let's break
this down so that its clearer whats happening.

First this happens:

~~~ {.r}
names(x) == "a"
~~~

~~~ {.output}
[1]  TRUE FALSE FALSE FALSE
~~~

The condition operator is applied to every name of the vector `x`. Only the
first name is "a" so that element is TRUE.

`which` then converts this to an index:

~~~ {.r}
which(names(x) == "a")
~~~

~~~ {.output}
[1] 1
~~~ 

Only the first element is `TRUE`, so `which returns 1. Now that we have indices
the skipping works because we have a negative index!

Skipping multiple named indices is similar, but uses a different comparison
operator:

~~~ {.r}
x[-which(names(x) %in% c("a", "c"))]
~~~

~~~ {.output}
  b   e 
6.2 7.5 
~~~

The `%in%` goes through each element of its left argument, in this case the 
names of `x`, and asks, "Does this element occur in the second argument?".

> #### Tip: Getting help for operators {.callout}
> 
> Remember you can search for help on operators by wrapping them in quotes:
> `help("%in%")` or `?"%in%"`.
>

So why can't we use `==` like before? That's an excellent question. 

Let's take a look at just the comparison component:

~~~ {.r}
names(x) == c('a', 'c')
~~~

~~~ {.output}
[1]  TRUE FALSE FALSE FALSE
~~~

Obviously "c" is in the names of `x`, so why didn't this work? `==` works 
slightly differently to `%in%`. It will compare each element of its left argument
to the corresponding element of its right argument.

Here's a mock illustration:

~~~ {.r}
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c")
~~~

When one vector is shorter than the other, it gets *recycled*:

~~~ {.r}
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c", "a", "c")
~~~

In this case R simply repeats `c("a", "c")` twice. If the longer
vector length isn't a multiple of the shorter vector length, then
R will also print out a warning message:

~~~ {.r}
names(x) == c('a', 'c', 'e')
~~~

~~~ {.output}
[1]  TRUE FALSE FALSE FALSE
Warning message:
In names(x) == c("a", "c", "e") :
  longer object length is not a multiple of shorter object length
~~~~

This difference between `==` and `%in%` is important to remember,
because it can introduce hard to find and subtle bugs!

### Subsetting through other logical operations

We can also more simply subset through logical operations:

~~~ {.r}
x[c(TRUE, TRUE, FALSE, FALSE)]
~~~ 

~~~ {.output}
  a   b 
5.4 6.2 
~~~

Note that in this case, the logical vector is also recycled to the
length of the vector we're subsetting!

~~~ {.r}
x[c(TRUE, FALSE)]
~~~

~~~ {.output}
  a   c 
5.4 7.1 
~~~

Since comparison operators evaluate to logical vectors, we can also
use them to succinctly subset vectors:

~~~ {.r}
x[x > 7]
~~~

~~~ {.output}
  c   e 
7.1 7.5 
~~~

> #### Tip: Chaining logical operations {.callout}
>
> There are many situations in which you will wish to combine multiple conditions.
> To do so several logical operations exist in R:
> 
>  * `|` logical OR: returns `TRUE`, if either the left or right are `TRUE`.
>  * `&` logical AND: returns `TRUE` if both the left and right are `TRUE`
>  * `!` logical NOT: converts `TRUE` to `FALSE` and `FALSE` to `TRUE`
>  * `&&` and `||` compare the individual elements of two vectors. Recycling rules
>    also apply here.
>

> #### Challenge {.challenge}
> 
> ~~~ {.r}
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> 
> ~~~ {.output}
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> 
> 1. Write a subsetting command to return the values in x that are greater than 4 and less than 7.
> 

#### Handling special values

At some point you will encounter functions in R which cannot handle missing, infinite,
or undefined data.

There are a number of special functions you can use to filter out this data:

 * `is.na` will return all positions in a vector, matrix, or data.frame
   containing `NA`.
 * likewise, `is.nan`, and `is.infinite` will do the same for `NaN` and `Inf`.
 * `is.finite` will return all positions in a vector, matrix, or data.frame
   that do not contain `NA`, `NaN` or `Inf`.
 * `na.omit` will filter out all missing values from a vector

### Factor subsetting

Now that we've explored the different ways to subset vectors, how
do we subset the other data structures?

Factor subsetting works the same way as vector subsetting. 

~~~ {.r}
f <- factor(c("a", "a", "b", "c", "c", "d"))
f[f == "a"]
f[f %in% c("b", "c")]
f[1:3]
~~~

An important note is that skipping elements will not remove the level
even if no more of that category exists in the factor:

~~~ {.r}
f[-3]
~~~

~~~ {.output}
[1] a a c c d
Levels: a b c d
~~~

### Matrix subsetting

Matrices are also subsetted using the `[` function. In this case
it takes two arguments: the first applying to the rows, the second
to its columns:

~~~ {.r}
set.seed(1)
m <- matrix(rnorm(6*4), ncol=4, nrow=6)
m[3:4, c(3,1)]
~~~

~~~ {.output}
            [,1]       [,2]
[1,]  1.12493092 -0.8356286
[2,] -0.04493361  1.5952808
~~~

You can leave the first or second arguments blank to retrieve all the
rows or columns respectively:

~~~ {.r}
m[, c(3,4)]
~~~

~~~ {.output}
            [,1]        [,2]
[1,] -0.62124058  0.82122120
[2,] -2.21469989  0.59390132
[3,]  1.12493092  0.91897737
[4,] -0.04493361  0.78213630
[5,] -0.01619026  0.07456498
[6,]  0.94383621 -1.98935170
~~~

If we only access one row or column, R will automatically convert the result
to a vector:

~~~ {.r}
m[3,]
~~~

~~~ {.output}
[1] -0.8356286  0.5757814  1.1249309  0.9189774
~~~

If you want to keep the output as a matrix, you need to specify a *third* argument;
`drop = FALSE`:

~~~ {.r}
m[3, , drop=FALSE]
~~~

~~~ {.output}
           [,1]      [,2]     [,3]      [,4]
[1,] -0.8356286 0.5757814 1.124931 0.9189774
~~~

Unlike vectors, if we try to access a row or column outside of the matrix,
R will throw an error:

~~~ {.r}
m[, c(3,6)]
~~~

~~~ {.output}
Error in m[, c(3, 6)] : subscript out of bounds
~~~

> #### Tip: Higher dimensional arrays {.callout}
>
> when dealing with multi-dimensional arrays, each argument to `[` 
> corresponds to a dimension. For example, a 3D array, the first three
> arguments correspond to the rows, columns, and depth dimension.
>

Because matrices are really just vectors underneath the hood, we can
also subset using only one argument:

~~~ {.r}
m[5]
~~~

~~~ {.output}
[1] 0.3295078 
~~~

This usually isn't useful. However it is useful to note that matrices
are laid out in *column-major format* by default. That is the elements of the 
vector are arranged column-wise:

~~~ {.r}
matrix(1:6, nrow=2, ncol=3)
~~~

~~~ {.output}
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
~~~

Matrices can also be subsetted using their rownames and column names
instead of their row and column indices.

> #### Challenge {.challenge}
> 
> ~~~ {.r}
> m <- matrix(1:18, nrow=3, ncol=6)
> print(m)
> ~~~
> 
> ~~~ {.output}
>      [,1] [,2] [,3] [,4] [,5] [,6]
> [1,]    1    4    7   10   13   16
> [2,]    2    5    8   11   14   17
> [3,]    3    6    9   12   15   18
> ~~~
> 
> 1. Which of the following commands will extract the values 11 and 14?
> 
> A. m[2,4,2,5]
> 
> B. m[2:5]
> 
> C. m[4:5,2]
> 
> D. m[2,c(4,5)]
> 


### List subsetting

Now we'll introduce some new subsetting operators. There are three functions 
used to subset lists. `[`, as we've seen for atomic vectors and matrices,
as well as `[[` and `$`.

Using `[` will always return a list. If you want to *subset* a list, but not
*extract* an element, then you will likely use `[`.

~~~ {.r}
xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris)) 
xlist[1] 
~~~

This returns a *list with one element*:

~~~ {.output}
$a
[1] "Software Carpentry"

~~~

We can subset elements of a list exactly the same was as atomic
vectors using `[`. Comparison operations however won't work as 
they're not recursive, they will try to condition on the data structures
in each element of the list, not the individual elements within those
data structures.

~~~ {.r}
xlist[1:2]
~~~

~~~ {.output}
$a
[1] "Software Carpentry"

$b
 [1]  1  2  3  4  5  6  7  8  9 10

~~~

To extract individual elements of a list, you need to use the double-square
bracket function: `[[`.

~~~ {.r}
xlist[[1]]
~~~

~~~ {.output}
[1] "Software Carpentry"
~~~

Notice that now the result is a vector, not a list.

You can't extract more than one element at once:

~~~ {.r}
xlist[[1:2]]
~~~

~~~ {.output}
Error in xlist[[1:2]] : subscript out of bounds
~~~

Nor use it to skip elements:

~~~ {.r}
xlist[[-1]]
~~~

~~~ {.output}
Error in xlist[[-1]] : attempt to select more than one element
~~~

But you can use names to both subset and extract elements:

~~~ {.r}
xlist[["a"]]
~~~

~~~ {.output}
[1] "Software Carpentry"
~~~

The `$` function is a shorthand way for extracting elements by name:

~~~ {.r}
xlist$data
~~~

~~~ {.output}
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
  1          5.1         3.5          1.4         0.2  setosa
  2          4.9         3.0          1.4         0.2  setosa
  3          4.7         3.2          1.3         0.2  setosa
  4          4.6         3.1          1.5         0.2  setosa
  5          5.0         3.6          1.4         0.2  setosa
  6          5.4         3.9          1.7         0.4  setosa
~~~

> #### Challenge {.challenge}
> 1. Given the following list:
>
> ~~~ {.r}
> xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris)) 
> ~~~
> 
> Using your knowledge of both list and vector subsetting, extract the number 2 from xlist. Hint: the number 2 is contained within the "b" item in the list.
> 
> 2. Given a linear model:
> 
> ~~~ {.r}
> mod <- aov(pop ~ lifeExp, data=gapminder)
> ~~~
>
> Extract the residual degrees of freedom (hint: `attributes()` will help you)
>

### Data frames

Remember the data frames are lists underneath the hood, so similar rules
apply. However they are also two dimensional objects:

`[` with one argument will act the same was as for lists, where each list
element corresponds to a column. The resulting object will be a data frame:

~~~ {.r}
head(gapminder[3])
~~~

~~~ {.output}
       pop
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
~~~

Similarly, `[[` will act to extract *a single column*:

~~~ {.r}
head(gapminder[["lifeExp"]])
~~~

~~~ {.output}
[1] 28.801 30.332 31.997 34.020 36.088 38.438
~~~

And `$` provides a convenient shorthand to extact columns by name:

~~~ {.r}
head(gapminder$year)
~~~

~~~ {.output}
[1] 1952 1957 1962 1967 1972 1977
~~~

With two arguments, `[` behaves the same way as for matrices:

~~~ {.r}
gapminder[1:3,]
~~~

~~~ {.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~

If we subset a single row, the result will be a data frame (because
the elements are mixed types):

~~~ {.r}
gapminder[3,]
~~~

~~~ {.output}
      country year      pop continent lifeExp gdpPercap
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~

But for a single column the result will be a vector (this can
be changed with the third argument, `drop = FALSE`).

> #### Challenge {.challenge}
> 
> Fix each of the following common data frame subsetting errors:
> 
> 1. Extract observations collected for the year 1957
>
> ~~~ {.r}
> gapminder[gapminder$year = 1957,]
> ~~~
>
> 2. Extract all columns except 1 through to 4
>
> ~~~ {.r}
> gapminder[,-1:4]
> ~~~
>
> 3. Extract the rows where the life expectancy is longer the 80 years
>
> ~~~ {.r}
> gapminder[gapminder$lifeExp > 80]
> ~~~
>
> 4. Extract the first row, and the fourth and fifth columns 
>   (`lifeExp` and `gdpPercap`).
>
> ~~~ {.r}
> gapminder[1, 4, 5]
> ~~~
>
> 5. Advanced: extract rows that contain information for the years 2002
>    and 2007
>
> ~~~ {.r}
> gapminder[gapminder$year == 2002 | 2007,]
> ~~~
>

> #### Challenge {.challenge}
>
> 1. Why does `gapminder[1:20]` return an error? How does it differ from `gapminder[1:20, ]`?
>
> 
> 2. Create a new `data.frame` called `gapminder_small` that only contains rows 1 through 9 
> and 19 through 23. You can do this in one or two steps.
>


