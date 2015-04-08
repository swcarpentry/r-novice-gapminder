---
layout: page
title: R for reproducible scientific analysis
subtitle: Vectorisation
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * To understand vectorised operations in R.
>

One of the nice features of R is that most of its functions are vectorized,
that is the function will operate on all elements of a vector without 
needing to loop through and act on each element one at a time. This makes
writing code more concise, easy to read, and less error prone.


~~~ {.r}
x <- 1:4
x * 2
~~~ 

~~~ {.output}
[1] 2 4 6 8
~~~

The multiplication happened to each element of the vector.

Let's try this on the `pop` column of the `gapminder` dataset. 

> #### Challenge 1 {.challenge}
>
> Make a new column in the `gapminder` dataframe that
> contains population in units of millions of people.
> Check the head or tail of the dataframe to make sure
> it worked.
>

> #### Challenge 2 {.challenge}
> 
> Create a subset of the `gapminder` dataset countaining entries
> only for Australia.
> 
> Calculate the mean GDP (GDP per capita multiplied by total population) 
> for Australia over all years on record.
>
> Refresh your ggplot skils by plotting mean GDP against year. 
>

We can also add two vectors together:

~~~ {.r}
y <- 6:9
x + y
~~~

~~~ {.output}
[1]  7  9 11 13
~~~

Each element of `x` was added to its corresponding element of `y`:

~~~ {.output}
x:  1  2  3  4
    +  +  +  +
y:  6  7  8  9
---------------
    7  9 11 13
~~~

> #### Challenge 3 {.challenge}
> 
> What do you think will happen if you add (or subtract,
> multiply, divide etc.) vectors of different lengths?
> 
> Try it.
> What does `x + c(1,3)` give you? Why?
>

Just as we saw in the previous lesson, vectors will recycle:

~~~ {.r}
x + c(1,3)
~~~

~~~ {.output}
[1] 2 5 4 7
~~~

Like so:

~~~ {.output}
x:  1  2  3  4
    +  +  +  +
y:  1  3  1  3
---------------
    2  5  4  7
~~~

Comparison operators also apply element-wise, as we saw in the
subsetting lesson:

~~~ {.r}
x > 2
~~~ 

~~~ {.output}
[1] FALSE FALSE  TRUE  TRUE
~~~

Logical operations are also vectorised:

~~~ {.r}
a <- x > 3
b <- x < 3
~~~

~~~ {.r}
a
~~~ 

~~~ {.output}
[1] FALSE FALSE FALSE  TRUE
~~~

~~~ {.r}
b
~~~ 

~~~ {.output}
[1]  TRUE  TRUE FALSE FALSE
~~~

~~~ {.r}
a | b 
~~~

~~~ {.output}
[1]  TRUE  TRUE FALSE  TRUE
~~~

~~~ {.r}
a & b
~~~

> #### Tip: some useful functions for logical vectors {.callout}
>
> `any()` will return `TRUE` if any element of a vector is `TRUE`
> `all()` will return `TRUE` if *all* elements of a vector are `TRUE`
>

~~~ {.output}
[1] FALSE FALSE FALSE FALSE
~~~

Many functions also operate on element-wise on vectors:

~~~ {.r}
x <- 1:4
sin(x)
~~~

~~~ {.output}
[1]  0.8414710  0.9092974  0.1411200 -0.7568025
~~~

Vectorised operations also work element wise on matrices:

~~~ {.r}
m <- matrix(1:12, nrow=3, ncol=4)
m * -1
~~~

~~~ {.output}
     [,1] [,2] [,3] [,4]
[1,]   -1   -4   -7  -10
[2,]   -2   -5   -8  -11
[3,]   -3   -6   -9  -12
~~~

Note that `*` gives you element-wise multiplication!

~~~ {.r}
m * m
~~~

~~~ {.output}
     [,1] [,2] [,3] [,4]
[1,]    1   16   49  100
[2,]    4   25   64  121
[3,]    9   36   81  144
~~~

To do matrix multiplication, we need to use the `%*%` operator:

~~~ {.r}
m %*% t(m)   # The t() function returns the transpose of a matrix
~~~

~~~ {.ouput}
     [,1] [,2] [,3]
[1,]  166  188  210
[2,]  188  214  240
[3,]  210  240  270
~~~

For more on matrix algebra, see the [Quick-R reference
guide](http://www.statmethods.net/advstats/matrix.html)



> #### Challenge 4 {.challenge}
> 
> We're interested in looking at the sum of the
> following sequence of fractions:
>
> ~~~ {.output}
>  x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
> ~~~
>
> This would be tedious to type out, and impossible for
> high values of n.
> Can you use vectorisation to solve for x, when n=100?
> How about when n=10,000?
>

> #### Challenge 5 {.challenge}
> 
> Given the following matrix:
> 
> ~~~ {.r}
> m <- matrix(1:12, nrow=3, ncol=4)
> m
> ~~~
>
> ~~~ {.output}
>      [,1] [,2] [,3] [,4]
> [1,]    1    4    7   10
> [2,]    2    5    8   11
> [3,]    3    6    9   12
> ~~~
>
> Write down what you think will happen when you run:
>
> 1. `m ^ -1`
> 2. `m * c(1, 0, -1)`
> 3. `m > c(0, 20)`
>
> Did you get the output expected? If not, ask a helper!
>

