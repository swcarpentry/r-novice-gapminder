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
writing core more concise, easy to read, and less error prone.


~~~ {.r}
x <- 1:4
x * 2
~~~ 

~~~ {.output}
[1] 2 4 6 8
~~~

The multiplication happened to each element of the vector.

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

Vectorised operations also work element wise on data.frames and matrices.

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

> #### Challenge 1 {.challenge}
> 
>  
 
