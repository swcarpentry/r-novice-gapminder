---
layout: page
title: R for reproducible scientific analysis
subtitle: Control flow
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * Write conditional statements with `if` and `else`.
> * Correctly evaluate expressions containing `&` ("and") and `|` ("or").
>

Often when we're coding we want to control the flow of our actions. Control
flow (or flow of control) is simply the order in which we code and have our
statements evaluated. That can be done by setting things to happen only if a
condition or a set of conditions are met. Alternatively, we can also set an
action to be computed for a particular number of times.

There are many ways these can be achieved in R. For conditional statements, the
most commonly used approaches are the constructs: 

~~~ {.r}
if (and else)
while
~~~

Say, for example, that we want R to print a message depending on how a number x relates to 5:

~~~ {.r}
set.seed(10)
x <- rpois(1, lambda=8)
if (x >= 10) {
    print("x is greater than or equals 10")
} else if (x > 5) {
    print("x is greater than 5")
} else {
    print("x is smaller than 5")
}
~~~

~~~ {.output}
[1] "x is greater or equal than 5"
~~~


> #### Tip: pseudo-random numbers {.callout}
>
> In the above case, the function `rpois` generates a random number following a
> Poisson distribution with a mean (i.e. lambda) of 8. The function `set.seed`
> guarantees that all machines that use the seed 10 as an input, will generate
> the exact same 'pseudo-random' number ([more about pseudo-random
> numbers](http://en.wikibooks.org/wiki/R_Programming/Random_Number_Generation)).
> Now, looking at x we see that it takes the value 8 (you should get the exact
> same number).
>


**Important:** when R evaluates the condition inside `if` statements, it is
looking for a logical element, i.e., `TRUE` or `FALSE`. This can cause some
headaches for beginners. For example:

~~~ {.r}
x  <-  4 == 3
if (x) {
    "4 equals 3"
}
~~~

As we can see, the message was not printed because the vector x is `FALSE` 

~~~ {.r}
x  <-  4 == 3
x
~~~

~~~ {.output}
[1] FALSE
~~~

Also, be careful if you have a vector with more than one logical element.
The function `if` will still run, but will only evaluate the condition in the first
element.

~~~ {.r}
set.seed(1)
x  <-  round(rnorm(30, mean=15, sd=15))
y  <-  x %in% c(3, 5, 16)

if(y) {
  stop('at least one number in x was found within the sequence c(3, 5, 16)')
}
~~~

You can see that R does not return any result but instead prints a warning message. 

~~~ {.output}
Warning message:
In if (y) { :
  the condition has length > 1 and only the first element will be used
~~~

The reason for that is because the first element in `y`, `y[1]` is `FALSE`
(i.e. `x[1]` is 6 and therefore is not contained within `c(3, 5, 16)`), so the
action within the condition is not evaluated. Such cases where multiple
comparisons/logical statements are contained within one single vector are not
uncommon, and I suspect you are probably looking for the functions `any` or
`all` before running an `if` statement.
The `any` function will return TRUE if at least one
TRUE value is found within a vector, otherwise it will return `FALSE`. The
function `all`, as the name suggests, will only return `TRUE` if all values in
the vector are `TRUE`. We can build on the above example to make this clear ---
suppose that we want to make sure that we avoid the warning message, and, on
top of that, print a more informative message:

~~~ {.r}
if(any(y)) {
  stop(paste0(paste0(x[y], collapse=' and '), ' found in x'))
}
~~~

Notice that now returns an Error message:

~~~ {.r}
Error: 3 and 16 found in x
~~~

The reason for that is because the function `stop` was evaluated. This function
is widely used in what's known as *defensive programming* - if you anticipate a
potential problem in your data manipulation/analysis within a function, the
function can stop if this certain problem occurs and print an informative error
message. The same idea works for the function `warning`. We could have also
created the different statements with the function `all` instead of `any`. Try
that by yourself. 

### Repeating operations

Just as we saw in the shell lessons earlier, you can repeat operations in `R`
using `for` loops. This is the most flexible of looping operations, but therefore
also the hardest to use correctly. Avoid using `for` loops unless the order
of iteration is important: i.e. the calculation at each iteration depends on
the results of previous iterations.

When the order of iteration *is* important, we can use loops. The basic
structure of a `for` loop is:

~~~ {.r}
for(iterator in set of values){
  do a thing
}
~~~

For example:

~~~ {.r}
for(i in 1:10){
  print(i)
}
~~~ 

The `1:10` bit is basically just creating a vector on the fly; you can iterate
over any other vector as well.

We can use a `for` loop within another for loop to iterate over two things at
once (e.g., rows and columns of a matrix).

~~~ {.r}
for(i in 1:5){
  for(j in 1:5){
    print(paste(i,j))
  }
}
~~~ 

> #### Tip: don't grow your results {.callout}
>
> One of the biggest things that trips up novices and
> even experienced R users alike, is building a results object
> (vector, list, matrix, data frame) as your for loop progresses.
> Computers are very bad at handling this, so your calculations
> can very quickly slow to a crawl. It's much better to define
> an empty results object before hand of the appropriate dimensions.
> So if you know the end result will be stored in a matrix like above,
> create an empty matrix with 5 row and 5 columns, then at each iteration
> store the results in the appropriate location.
>

Sometimes you will find yourself needing to repeat an operation until a certain
condition is met, rather than doing it for a specific number of times.  In some
cases you might be able to hack something together using a `for` loop, but
usually you'd be much better off using a `while` loop instead.  `While` loops
look and act a lot like `for` loops, but instead of saying: 

~~~ {.r}
for(iterator in set of values){
  do a thing
}
~~~

You instead say:

~~~ {.r}
while(this condition is true){
  do a thing
} 
~~~

Let's try an example, shall we?  We'll try to come up with some simple code
that generates random numbers between 0 and 1 until it gets one that's less
than 0.1.  

~~~ {.r}
while(z > 0.1){
  z <- runif(1)
  print(z)
}
~~~

~~~ {.output}
Error: object 'z' not found
~~~

But wait, that doesn't work!  What's the problem?

The problem is that we haven't defined `z`, and so the very first time the
while loop's condition is checked (`z > 0.1`), `while` just says "Okay, that's
not true so I'm not going to execute this block of code".  The same thing would
have happened if we defined `z` to be anything less than 0.1.  Let's fix it.

~~~ {.r}
z <- 1
while(z > 0.1){
  z <- runif(1)
  print(z)
}
~~~

> #### Challenge 1 {.challenge}
>
> Write a script that loops through the `gapfinder` data by continent and prints out
> whether the mean life expectancy is smaller or larger than 50
> years.
>

> #### Challenge 2 {.challenge}
>
> Modify the script from challenge 1 to also loop over each 
> country. This time print out whether the life expectancy is
> smaller than 50, between 50 and 70, or greater than 70.
>

