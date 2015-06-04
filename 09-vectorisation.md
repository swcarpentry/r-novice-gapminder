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



~~~{.r}
x <- 1:4
x * 2
~~~



~~~{.output}
[1] 2 4 6 8

~~~

The multiplication happened to each element of the vector.

We can also add two vectors together:


~~~{.r}
y <- 6:9
x + y
~~~



~~~{.output}
[1]  7  9 11 13

~~~

Each element of `x` was added to its corresponding element of `y`:


~~~{.r}
x:  1  2  3  4
    +  +  +  +
y:  6  7  8  9
---------------
    7  9 11 13
~~~


> #### Challenge 1 {.challenge}
>
> Let's try this on the `pop` column of the `gapminder` dataset. 
>
> Make a new column in the `gapminder` dataframe that
> contains population in units of millions of people.
> Check the head or tail of the dataframe to make sure
> it worked.
>

> #### Challenge 2 {.challenge}
> 
> Refresh your ggplot skils by plotting population in millions against year. 
>

Comparison operators also apply element-wise, as we saw in the
subsetting lesson:


~~~{.r}
x > 2
~~~



~~~{.output}
[1] FALSE FALSE  TRUE  TRUE

~~~

Logical operations are also vectorised:


~~~{.r}
a <- x > 3
a
~~~



~~~{.output}
[1] FALSE FALSE FALSE  TRUE

~~~

> #### Tip: some useful functions for logical vectors {.callout}
>
> `any()` will return `TRUE` if any element of a vector is `TRUE`
> `all()` will return `TRUE` if *all* elements of a vector are `TRUE`
>

Many functions also operate on element-wise on vectors:


~~~{.r}
x <- 1:4
log(x)
~~~



~~~{.output}
[1] 0.0000 0.6931 1.0986 1.3863

~~~

Vectorised operations also work element wise on matrices:


~~~{.r}
m <- matrix(1:12, nrow=3, ncol=4)
m * -1
~~~



~~~{.output}
     [,1] [,2] [,3] [,4]
[1,]   -1   -4   -7  -10
[2,]   -2   -5   -8  -11
[3,]   -3   -6   -9  -12

~~~

> #### Tip: element-wise vs. matrix multiplication {.callout}
>
> Note that `*` gives you element-wise multiplication!
> To do matrix multiplication, we need to use the `%*%` operator:
>
> For more on matrix algebra, see the [Quick-R reference
> guide](http://www.statmethods.net/advstats/matrix.html)

> #### Challenge 3 {.challenge}
> 
> Given the following matrix:
> 
> ~~~ {.r}
> m <- matrix(1:12, nrow=3, ncol=4)
> m
> ~~~
>
> ~~~ {.output}
> ##      [,1] [,2] [,3] [,4]
> ## [1,]    1    4    7   10
> ## [2,]    2    5    8   11
> ## [3,]    3    6    9   12
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

> #### Bonus Challenge {.challenge}
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

