---
title: Subsetting Data
teaching: 10
exercises: 10
questions:
- "How can I work with subsets of data in R?"
objectives:
- "To be able to subset vectors, factors, matrices, lists, and data frames"
- "To be able to extract individual and multiple elements: by index, by name, using comparison operations"
- "To be able to skip and remove elements from various data structures."
keypoints:
- "Indexing in R starts at 1, not 0."
- "Access individual values by location using `[]`."
- "Access slices of data using `[low:high]`."
- "Access arbitrary sets of data using `[c(...)]`."
- "Use `which` to select subsets of data based on value."
---




R has many powerful subset operators and mastering them will allow you to
easily perform complex operations on any kind of dataset.

There are six different ways we can subset any kind of object, and three
different subsetting operators for the different data structures.

Let's start with the workhorse of R: atomic vectors.


~~~
x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
x
~~~
{: .r}



~~~
  a   b   c   d   e 
5.4 6.2 7.1 4.8 7.5 
~~~
{: .output}

So now that we've created a dummy vector to play with, how do we get at its
contents?

## Accessing elements using their indices

To extract elements of a vector we can give their corresponding index, starting
from one:


~~~
x[1]
~~~
{: .r}



~~~
  a 
5.4 
~~~
{: .output}


~~~
x[4]
~~~
{: .r}



~~~
  d 
4.8 
~~~
{: .output}

It may look different, but the square brackets operator is a function. For atomic vectors
(and matrices), it means "get me the nth element".

We can ask for multiple elements at once:


~~~
x[c(1, 3)]
~~~
{: .r}



~~~
  a   c 
5.4 7.1 
~~~
{: .output}

Or slices of the vector:


~~~
x[1:4]
~~~
{: .r}



~~~
  a   b   c   d 
5.4 6.2 7.1 4.8 
~~~
{: .output}

the `:` operator reates a sequence of numbers from the left element to the right.

~~~
1:4
~~~
{: .r}



~~~
[1] 1 2 3 4
~~~
{: .output}



~~~
c(1, 2, 3, 4)
~~~
{: .r}



~~~
[1] 1 2 3 4
~~~
{: .output}


We can ask for the same element multiple times:


~~~
x[c(1,1,3)]
~~~
{: .r}



~~~
  a   a   c 
5.4 5.4 7.1 
~~~
{: .output}

If we ask for a number outside of the vector, R will return missing values:


~~~
x[6]
~~~
{: .r}



~~~
<NA> 
  NA 
~~~
{: .output}

This is a vector of length one containing an `NA`, whose name is also `NA`.

If we ask for the 0th element, we get an empty vector:


~~~
x[0]
~~~
{: .r}



~~~
named numeric(0)
~~~
{: .output}

> ##Vector numbering in R starts at 1
>
> In many programming languages (C and python, for example), the first
> element of a vector has an index of 0. In R, the first element is 1.
{: .callout}

## Skipping and removing elements

If we use a negative number as the index of a vector, R will return
every element *except* for the one specified:


~~~
x[-2]
~~~
{: .r}



~~~
  a   c   d   e 
5.4 7.1 4.8 7.5 
~~~
{: .output}


We can skip multiple elements:


~~~
x[c(-1, -5)]  # or x[-c(1,5)]
~~~
{: .r}



~~~
  b   c   d 
6.2 7.1 4.8 
~~~
{: .output}

> ## Tip: Order of operations
>
> A common trip up for novices occurs when trying to skip
> slices of a vector. Most people first try to negate a
> sequence like so:
>
> 
> ~~~
> x[-1:3]
> ~~~
> {: .r}
>
> This gives a somewhat cryptic error:
>
> 
> ~~~
> Error in x[-1:3]: only 0's may be mixed with negative subscripts
> ~~~
> {: .error}
>
> But remember the order of operations. `:` is really a function, so
> what happens is it takes its first argument as -1, and second as 3,
> so generates the sequence of numbers: `c(-1, 0, 1, 2, 3)`.
>
> The correct solution is to wrap that function call in brackets, so
> that the `-` operator applies to the results:
>
> 
> ~~~
> x[-(1:3)]
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>   d   e 
> 4.8 7.5 
> ~~~
> {: .output}
{: .callout}


To remove elements from a vector, we need to assign the results back
into the variable:


~~~
x <- x[-4]
x
~~~
{: .r}



~~~
  a   b   c   e 
5.4 6.2 7.1 7.5 
~~~
{: .output}

> ## Challenge 1
>
> Given the following code:
>
> 
> ~~~
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> {: .output}
>
> 1. Come up with at least 3 different commands that will produce the following output:
>
> 
> ~~~
>   b   c   d 
> 6.2 7.1 4.8 
> ~~~
> {: .output}
>
> 2. Compare notes with your neighbour. Did you have different strategies?
>
> > ## Solution to challenge 1
> >
> >
> > Given the following code:
> >
> > 
> > ~~~
> > x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> > names(x) <- c('a', 'b', 'c', 'd', 'e')
> > print(x)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >   a   b   c   d   e 
> > 5.4 6.2 7.1 4.8 7.5 
> > ~~~
> > {: .output}
> >
> > 1. Come up with at least 3 different commands that will produce the following output:
> >
> > 
> > ~~~
> >   b   c   d 
> > 6.2 7.1 4.8 
> > ~~~
> > {: .output}
> >
> > 
> > ~~~
> > x[2:4]
> > x[-c(1,5)]
> > x[c("b", "c", "d")]
> > x[c(2,3,4)]
> > ~~~
> > {: .r}
> >
> {: .solution}
{: .challenge}

## Subsetting by name

We can extract elements by using their name, instead of index:


~~~
x[c("a", "c")]
~~~
{: .r}



~~~
  a   c 
5.4 7.1 
~~~
{: .output}

This is usually a much more reliable way to subset objects: the
position of various elements can often change when chaining together
subsetting operations, but the names will always remain the same!

Unfortunately we can't skip or remove elements so easily.

To skip (or remove) a single named element:


~~~
x[-which(names(x) == "a")]
~~~
{: .r}



~~~
  b   c   d   e 
6.2 7.1 4.8 7.5 
~~~
{: .output}

The `which` function returns the indices of all `TRUE` elements of its argument.
Remember that expressions evaluate before being passed to functions. Let's break
this down so that its clearer what's happening.

First this happens:


~~~
names(x) == "a"
~~~
{: .r}



~~~
[1]  TRUE FALSE FALSE FALSE FALSE
~~~
{: .output}

The condition operator is applied to every name of the vector `x`. Only the
first name is "a" so that element is TRUE.

`which` then converts this to an index:


~~~
which(names(x) == "a")
~~~
{: .r}



~~~
[1] 1
~~~
{: .output}



Only the first element is `TRUE`, so `which` returns 1. Now that we have indices
the skipping works because we have a negative index!

Skipping multiple named indices is similar, but uses a different comparison
operator:


~~~
x[-which(names(x) %in% c("a", "c"))]
~~~
{: .r}



~~~
  b   d   e 
6.2 4.8 7.5 
~~~
{: .output}

The `%in%` goes through each element of its left argument, in this case the
names of `x`, and asks, "Does this element occur in the second argument?".

> ## Challenge 2
>
> Run the following code to define vector `x` as above:
>
> 
> ~~~
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> {: .output}
>
> Given this vector `x`, what would you expect the following to do?
>
>~~~
> x[-which(names(x) == "g")]
>~~~
>{: .r}
>
> Try out this command and see what you get. Did this match your expectation?
> Why did we get this result? (Tip: test out each part of the command on it's own - this is a useful debugging strategy)
>
> Which of the following are true:
>
> * A) if there are no `TRUE` values passed to `which`, an empty vector is returned
> * B) if there are no `TRUE` values passed to `which`, an error message is shown
> * C) `integer()` is an empty vector
> * D) making an empty vector negative produces an "everything" vector
> * E) `x[]` gives the same result as `x[integer()]`
>
> > ## Solution to challenge 2
> >
> > Run the following code to define vector `x` as above:
> >
> > 
> > ~~~
> > x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> > names(x) <- c('a', 'b', 'c', 'd', 'e')
> > print(x)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >   a   b   c   d   e 
> > 5.4 6.2 7.1 4.8 7.5 
> > ~~~
> > {: .output}
> >
> > Given this vector `x`, what would you expect the following to do?
> >
> >~~~
> > x[-which(names(x) == "g")]
> >~~~
> >{: .r}
> >
> > Try out this command and see what you get. Did this match your expectation?
> >
> > Why did we get this result? (Tip: test out each part of the command on it's own - this is a useful debugging strategy)
> >
> > Which of the following are true:
> >
> > * A) if there are no `TRUE` values passed to "which", an empty vector is returned
> > * B) if there are no `TRUE` values passed to "which", an error message is shown
> > * C) `integer()` is an empty vector
> > * D) making an empty vector negative produces an "everything" vector
> > * E) `x[]` gives the same result as `x[integer()]`
> >
> > Answer: A and C are correct.
> >
> > The `which` command returns the index of every `TRUE` value in its
> input. The `names(x) == "g"` command didn't return any `TRUE` values. Because
> there were no `TRUE` values passed to the `which` command, it returned an
> empty vector. Negating this vector with the minus sign didn't change its
> meaning. Because we used this empty vector to retrieve values from `x`, it
> produced an empty numeric vector. It was a `named numeric` empty vector
> because the vector type of x is "named numeric" since we assigned names to the
> values (try `str(x)` ).
> {: .solution}
{: .challenge}

> ## Tip: Non-unique names
>
> You should be aware that it is possible for multiple elements in a
> vector to have the same name. (For a data frame, columns can have
> the same name --- although R tries to avoid this --- but row names
> must be unique.) Consider these examples:
>
>
>~~~
> x <- 1:3
> x
>~~~
>{: .r}
>
>
>
>~~~
>[1] 1 2 3
>~~~
>{: .output}
>
>
>
>~~~
> names(x) <- c('a', 'a', 'a')
> x
>~~~
>{: .r}
>
>
>
>~~~
>a a a 
>1 2 3 
>~~~
>{: .output}
>
>
>
>~~~
> x['a']  # only returns first value
>~~~
>{: .r}
>
>
>
>~~~
>a 
>1 
>~~~
>{: .output}
>
>
>
>~~~
> x[which(names(x) == 'a')]  # returns all three values
>~~~
>{: .r}
>
>
>
>~~~
>a a a 
>1 2 3 
>~~~
>{: .output}
{: .callout}


> ## Tip: Getting help for operators
>
> Remember you can search for help on operators by wrapping them in quotes:
> `help("%in%")` or `?"%in%"`.
>
{: .callout}


So why can't we use `==` like before? That's an excellent question.

Let's take a look at the comparison component of this code:


~~~
names(x) == c('a', 'c')
~~~
{: .r}



~~~
Warning in names(x) == c("a", "c"): longer object length is not a multiple
of shorter object length
~~~
{: .error}



~~~
[1]  TRUE FALSE  TRUE
~~~
{: .output}

Obviously "c" is in the names of `x`, so why didn't this work? `==` works
slightly differently than `%in%`. It will compare each element of its left argument
to the corresponding element of its right argument.

Here's a mock illustration:


~~~
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c")
~~~
{: .r}

When one vector is shorter than the other, it gets *recycled*:


~~~
c("a", "b", "c", "e")  # names of x
   |    |    |    |    # The elements == is comparing
c("a", "c", "a", "c")
~~~
{: .r}

In this case R simply repeats `c("a", "c")` twice. If the longer
vector length isn't a multiple of the shorter vector length, then
R will also print out a warning message:


~~~
names(x) == c('a', 'c', 'e')
~~~
{: .r}



~~~
[1]  TRUE FALSE FALSE
~~~
{: .output}

This difference between `==` and `%in%` is important to remember,
because it can introduce hard to find and subtle bugs!

## Subsetting through other logical operations

We can also more simply subset through logical operations:


~~~
x[c(TRUE, TRUE, FALSE, FALSE)]
~~~
{: .r}



~~~
a a 
1 2 
~~~
{: .output}

Note that in this case, the logical vector is also recycled to the
length of the vector we're subsetting!


~~~
x[c(TRUE, FALSE)]
~~~
{: .r}



~~~
a a 
1 3 
~~~
{: .output}

Since comparison operators evaluate to logical vectors, we can also
use them to succinctly subset vectors:


~~~
x[x > 7]
~~~
{: .r}



~~~
named integer(0)
~~~
{: .output}

> ## Tip: Combining logical conditions
>
> There are many situations in which you will wish to combine multiple logical
> criteria. For example, we might want to find all the countries that are
> located in Asia **or** Europe **and** have life expectancies within a certain
> range. Several operations for combining logical vectors exist in R:
>
>  * `&`, the "logical AND" operator: returns `TRUE` if both the left and right
>    are `TRUE`.
>  * `|`, the "logical OR" operator: returns `TRUE`, if either the left or right
>    (or both) are `TRUE`.
>
> The recycling rule applies with both of these, so `TRUE & c(TRUE, FALSE, TRUE)`
> will compare the first `TRUE` on the left of the `&` sign with each of the
> three conditions on the right.
>
> You may sometimes see `&&` and `||` instead of `&` and `|`. These operators
> do not use the recycling rule: they only look at the first element of each
> vector and ignore the remaining elements. The longer operators are mainly used
> in programming, rather than data analysis.
>
>  * `!`, the "logical NOT" operator: converts `TRUE` to `FALSE` and `FALSE` to
>    `TRUE`. It can negate a single logical condition (eg `!TRUE` becomes
>    `FALSE`), or a whole vector of conditions(eg `!c(TRUE, FALSE)` becomes
>    `c(FALSE, TRUE)`).
>
> Additionally, you can compare the elements within a single vector using the
> `all` function (which returns `TRUE` if every element of the vector is `TRUE`)
> and the `any` function (which returns `TRUE` if one or more elements of the
> vector are `TRUE`).
{: .callout}

> ## Challenge 3
>
> Given the following code:
>
> 
> ~~~
> x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> names(x) <- c('a', 'b', 'c', 'd', 'e')
> print(x)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>   a   b   c   d   e 
> 5.4 6.2 7.1 4.8 7.5 
> ~~~
> {: .output}
>
> 1. Write a subsetting command to return the values in x that are greater than 4 and less than 7.
>
> > ## Solution to challenge 3
> > Given the following code:
> >
> > 
> > ~~~
> > x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
> > names(x) <- c('a', 'b', 'c', 'd', 'e')
> > print(x)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >   a   b   c   d   e 
> > 5.4 6.2 7.1 4.8 7.5 
> > ~~~
> > {: .output}
> >
> > 1. Write a subsetting command to return the values in x that are greater than 4 and less than 7.
> >
> > 
> > ~~~
> > x_subset <- x[x<7 & x>4]
> > print(x_subset)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >   a   b   d 
> > 5.4 6.2 4.8 
> > ~~~
> > {: .output}
> {: .solution}
{: .challenge}

## Handling special values

At some point you will encounter functions in R which cannot handle missing, infinite,
or undefined data.

There are a number of special functions you can use to filter out this data:

 * `is.na` will return all positions in a vector, matrix, or data.frame
   containing `NA`.
 * likewise, `is.nan`, and `is.infinite` will do the same for `NaN` and `Inf`.
 * `is.finite` will return all positions in a vector, matrix, or data.frame
   that do not contain `NA`, `NaN` or `Inf`.
 * `na.omit` will filter out all missing values from a vector

## Factor subsetting

Now that we've explored the different ways to subset vectors, how
do we subset the other data structures?

Factor subsetting works the same way as vector subsetting.


~~~
f <- factor(c("a", "a", "b", "c", "c", "d"))
f[f == "a"]
~~~
{: .r}



~~~
[1] a a
Levels: a b c d
~~~
{: .output}



~~~
f[f %in% c("b", "c")]
~~~
{: .r}



~~~
[1] b c c
Levels: a b c d
~~~
{: .output}



~~~
f[1:3]
~~~
{: .r}



~~~
[1] a a b
Levels: a b c d
~~~
{: .output}

An important note is that skipping elements will not remove the level
even if no more of that category exists in the factor:


~~~
f[-3]
~~~
{: .r}



~~~
[1] a a c c d
Levels: a b c d
~~~
{: .output}

## Matrix subsetting

Matrices are also subsetted using the `[` function. In this case
it takes two arguments: the first applying to the rows, the second
to its columns:


~~~
set.seed(1)
m <- matrix(rnorm(6*4), ncol=4, nrow=6)
m[3:4, c(3,1)]
~~~
{: .r}



~~~
            [,1]       [,2]
[1,]  1.12493092 -0.8356286
[2,] -0.04493361  1.5952808
~~~
{: .output}

You can leave the first or second arguments blank to retrieve all the
rows or columns respectively:


~~~
m[, c(3,4)]
~~~
{: .r}



~~~
            [,1]        [,2]
[1,] -0.62124058  0.82122120
[2,] -2.21469989  0.59390132
[3,]  1.12493092  0.91897737
[4,] -0.04493361  0.78213630
[5,] -0.01619026  0.07456498
[6,]  0.94383621 -1.98935170
~~~
{: .output}

If we only access one row or column, R will automatically convert the result
to a vector:


~~~
m[3,]
~~~
{: .r}



~~~
[1] -0.8356286  0.5757814  1.1249309  0.9189774
~~~
{: .output}

If you want to keep the output as a matrix, you need to specify a *third* argument;
`drop = FALSE`:


~~~
m[3, , drop=FALSE]
~~~
{: .r}



~~~
           [,1]      [,2]     [,3]      [,4]
[1,] -0.8356286 0.5757814 1.124931 0.9189774
~~~
{: .output}

Unlike vectors, if we try to access a row or column outside of the matrix,
R will throw an error:


~~~
m[, c(3,6)]
~~~
{: .r}



~~~
Error in m[, c(3, 6)]: subscript out of bounds
~~~
{: .error}

> ## Tip: Higher dimensional arrays
>
> when dealing with multi-dimensional arrays, each argument to `[`
> corresponds to a dimension. For example, a 3D array, the first three
> arguments correspond to the rows, columns, and depth dimension.
>
{: .callout}

Because matrices are vectors, we can
also subset using only one argument:


~~~
m[5]
~~~
{: .r}



~~~
[1] 0.3295078
~~~
{: .output}


This usually isn't useful, and often confusing to read. However it is useful to note that matrices
are laid out in *column-major format* by default. That is the elements of the
vector are arranged column-wise:


~~~
matrix(1:6, nrow=2, ncol=3)
~~~
{: .r}



~~~
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
~~~
{: .output}

If you wish to populate the matrix by row, use `byrow=TRUE`:


~~~
matrix(1:6, nrow=2, ncol=3, byrow=TRUE)
~~~
{: .r}



~~~
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
~~~
{: .output}

Matrices can also be subsetted using their rownames and column names
instead of their row and column indices.

> ## Challenge 4
>
> Given the following code:
>
> 
> ~~~
> m <- matrix(1:18, nrow=3, ncol=6)
> print(m)
> ~~~
> {: .r}
> 
> 
> 
> ~~~
>      [,1] [,2] [,3] [,4] [,5] [,6]
> [1,]    1    4    7   10   13   16
> [2,]    2    5    8   11   14   17
> [3,]    3    6    9   12   15   18
> ~~~
> {: .output}
>
> 1. Which of the following commands will extract the values 11 and 14?
>
> A. `m[2,4,2,5]`
>
> B. `m[2:5]`
>
> C. `m[4:5,2]`
>
> D. `m[2,c(4,5)]`
>
> > ## Solution to challenge 4
> >
> > Given the following code:
> >
> > 
> > ~~~
> > m <- matrix(1:18, nrow=3, ncol=6)
> > print(m)
> > ~~~
> > {: .r}
> > 
> > 
> > 
> > ~~~
> >      [,1] [,2] [,3] [,4] [,5] [,6]
> > [1,]    1    4    7   10   13   16
> > [2,]    2    5    8   11   14   17
> > [3,]    3    6    9   12   15   18
> > ~~~
> > {: .output}
> >
> > 1. Which of the following commands will extract the values 11 and 14?
> >
> > A. `m[2,4,2,5]`
> >
> > B. `m[2:5]`
> >
> > C. `m[4:5,2]`
> >
> > D. `m[2,c(4,5)]`
> >
> > Answer: D
> {: .solution}
{: .challenge}


## List subsetting

Now we'll introduce some new subsetting operators. There are three functions
used to subset lists. `[`, as we've seen for atomic vectors and matrices,
as well as `[[` and `$`.

Using `[` will always return a list. If you want to *subset* a list, but not
*extract* an element, then you will likely use `[`.


~~~
xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris))
xlist[1]
~~~
{: .r}



~~~
$a
[1] "Software Carpentry"
~~~
{: .output}

This returns a *list with one element*.

We can subset elements of a list exactly the same was as atomic
vectors using `[`. Comparison operations however won't work as
they're not recursive, they will try to condition on the data structures
in each element of the list, not the individual elements within those
data structures.


~~~
xlist[1:2]
~~~
{: .r}



~~~
$a
[1] "Software Carpentry"

$b
 [1]  1  2  3  4  5  6  7  8  9 10
~~~
{: .output}

To extract individual elements of a list, you need to use the double-square
bracket function: `[[`.


~~~
xlist[[1]]
~~~
{: .r}



~~~
[1] "Software Carpentry"
~~~
{: .output}

Notice that now the result is a vector, not a list.

You can't extract more than one element at once:


~~~
xlist[[1:2]]
~~~
{: .r}



~~~
Error in xlist[[1:2]]: subscript out of bounds
~~~
{: .error}

Nor use it to skip elements:


~~~
xlist[[-1]]
~~~
{: .r}



~~~
Error in xlist[[-1]]: attempt to select more than one element
~~~
{: .error}

But you can use names to both subset and extract elements:


~~~
xlist[["a"]]
~~~
{: .r}



~~~
[1] "Software Carpentry"
~~~
{: .output}

The `$` function is a shorthand way for extracting elements by name:


~~~
xlist$data
~~~
{: .r}



~~~
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
~~~
{: .output}

> ## Challenge 5
> Given the following list:
>
> 
> ~~~
> xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris))
> ~~~
> {: .r}
>
> Using your knowledge of both list and vector subsetting, extract the number 2 from xlist.
> Hint: the number 2 is contained within the "b" item in the list.
>
> > ## Solution to challenge 5
> > Given the following list:
> >
> > 
> > ~~~
> > xlist <- list(a = "Software Carpentry", b = 1:10, data = head(iris))
> > ~~~
> > {: .r}
> >
> > Using your knowledge of both list and vector subsetting, extract the number 2 from xlist.
> > Hint: the number 2 is contained within the "b" item in the list.
> >
> > 
> > ~~~
> > xlist$b[2]
> > xlist[[2]][2]
> > xlist[["b"]][2]
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


> ## Challenge 6
> Given a linear model:
>
> 
> ~~~
> mod <- aov(pop ~ lifeExp, data=gapminder)
> ~~~
> {: .r}
>
> Extract the residual degrees of freedom (hint: `attributes()` will help you)
>
> > ## Solution to challenge 6
> > Given a linear model:
> >
> > 
> > ~~~
> > mod <- aov(pop ~ lifeExp, data=gapminder)
> > ~~~
> > {: .r}
> >
> > Extract the residual degrees of freedom (hint: `attributes()` will help you)
> >
> > 
> > ~~~
> > attributes(mod) ## `df.residual` is one of the names of `mod`
> > mod$df.residual
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


## Data frames

Remember the data frames are lists underneath the hood, so similar rules
apply. However they are also two dimensional objects:

`[` with one argument will act the same was as for lists, where each list
element corresponds to a column. The resulting object will be a data frame:


~~~
head(gapminder[3])
~~~
{: .r}



~~~
       pop
1  8425333
2  9240934
3 10267083
4 11537966
5 13079460
6 14880372
~~~
{: .output}

Similarly, `[[` will act to extract *a single column*:


~~~
head(gapminder[["lifeExp"]])
~~~
{: .r}



~~~
[1] 28.801 30.332 31.997 34.020 36.088 38.438
~~~
{: .output}

And `$` provides a convenient shorthand to extract columns by name:


~~~
head(gapminder$year)
~~~
{: .r}



~~~
[1] 1952 1957 1962 1967 1972 1977
~~~
{: .output}

With two arguments, `[` behaves the same way as for matrices:


~~~
gapminder[1:3,]
~~~
{: .r}



~~~
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~
{: .output}

If we subset a single row, the result will be a data frame (because
the elements are mixed types):


~~~
gapminder[3,]
~~~
{: .r}



~~~
      country year      pop continent lifeExp gdpPercap
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
~~~
{: .output}

But for a single column the result will be a vector (this can
be changed with the third argument, `drop = FALSE`).

> ## Challenge 7
>
> Fix each of the following common data frame subsetting errors:
>
> 1. Extract observations collected for the year 1957
>
> 
> ~~~
> gapminder[gapminder$year = 1957,]
> ~~~
> {: .r}
>
> 2. Extract all columns except 1 through to 4
>
> 
> ~~~
> gapminder[,-1:4]
> ~~~
> {: .r}
>
> 3. Extract the rows where the life expectancy is longer the 80 years
>
> 
> ~~~
> gapminder[gapminder$lifeExp > 80]
> ~~~
> {: .r}
>
> 4. Extract the first row, and the fourth and fifth columns
>   (`lifeExp` and `gdpPercap`).
>
> 
> ~~~
> gapminder[1, 4, 5]
> ~~~
> {: .r}
>
> 5. Advanced: extract rows that contain information for the years 2002
>    and 2007
>
> 
> ~~~
> gapminder[gapminder$year == 2002 | 2007,]
> ~~~
> {: .r}
>
> > ## Solution to challenge 7
> >
> > Fix each of the following common data frame subsetting errors:
> >
> > 1. Extract observations collected for the year 1957
> >
> > 
> > ~~~
> > # gapminder[gapminder$year = 1957,]
> > gapminder[gapminder$year == 1957,]
> > ~~~
> > {: .r}
> >
> > 2. Extract all columns except 1 through to 4
> >
> > 
> > ~~~
> > # gapminder[,-1:4]
> > gapminder[,-c(1:4)]
> > ~~~
> > {: .r}
> >
> > 3. Extract the rows where the life expectancy is longer the 80 years
> >
> > 
> > ~~~
> > # gapminder[gapminder$lifeExp > 80]
> > gapminder[gapminder$lifeExp > 80,]
> > ~~~
> > {: .r}
> >
> > 4. Extract the first row, and the fourth and fifth columns
> >   (`lifeExp` and `gdpPercap`).
> >
> > 
> > ~~~
> > # gapminder[1, 4, 5]
> > gapminder[1, c(4, 5)]
> > ~~~
> > {: .r}
> >
> > 5. Advanced: extract rows that contain information for the years 2002
> >    and 2007
> >
> > 
> > ~~~
> > # gapminder[gapminder$year == 2002 | 2007,]
> > gapminder[gapminder$year == 2002 | gapminder$year == 2007,]
> > gapminder[gapminder$year %in% c(2002, 2007),]
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 8
>
> 1. Why does `gapminder[1:20]` return an error? How does it differ from `gapminder[1:20, ]`?
>
>
> 2. Create a new `data.frame` called `gapminder_small` that only contains rows 1 through 9
> and 19 through 23. You can do this in one or two steps.
>
> > ## Solution to challenge 8
> >
> > 1. Why does `gapminder[1:20]` return an error? How does it differ from `gapminder[1:20, ]`?
> >
> > Answer: `gapminder` is a data.frame so needs to be subsetted on two dimensions. `gapminder[1:20, ]` subsets the data to give the first 20 rows and all columns.
> >
> > 2. Create a new `data.frame` called `gapminder_small` that only contains rows 1 through 9
> > and 19 through 23. You can do this in one or two steps.
> >
> > 
> > ~~~
> > gapminder_small <- gapminder[c(1:9, 19:23),]
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}
