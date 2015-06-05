---
layout: page
title: R for reproducible scientific analysis
subtitle: Control flow
minutes: 30
---

> ### Learning Objectives {.objectives}
>
> * Write conditional statements with `if` and `else`.
> * Write and understand `while` and `for` loops.
>

Often when we're coding we want to control the flow of our actions. This can be done
by setting actions to occur only if a condition or a set of conditions are met.
Alternatively, we can also set an action to occur a particular number of times.

There are several ways you can control flow in R.
For conditional statements, the most commonly used approaches are the constructs:

~~~ {.r}
# if
if (condition is true) {
    perform action
}

# if ... else

if (condition is true) {
    perform action
}
else {                        # that is, if the condition is false,
    perform alternative action
}

~~~

Say, for example, that we want R to print a message if a variable `x` has a particular value:

~~~ {.r}
# sample a random number from a Poisson distribution
# with a mean (lambda) of 8

x <- rpois(1, lambda=8)

if (x >= 10) {
    print("x is greater than or equal to 10")
}

x
~~~

Note you may not get the same output as your neighbour because
you may be sampling different random numbers from the same distribution.

Let's set a seed so that we all generate the same 'pseudo-random'
number, and then print more information:

~~~ {.r}
set.seed(10)
x <- rpois(1, lambda=8)

if (x >= 10) {
    print("x is greater than or equal to 10")
} else if (x > 5) {
    print("x is greater than 5")
} else {
    print("x is less than 5")
}
~~~

~~~ {.output}
[1] "x is greater than 5"
~~~


> ### Tip: pseudo-random numbers {.callout}
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

> ### Challenge 1 {.challenge}
>
> Use an `if` statement to print a suitable message
> reporting whether there are any records from 2002 in
> the `gapminder` dataset.
> Now do the same for 2012.
>

Did anyone get a warning message like this?

~~~ {.output}
Warning message:
In if (gapminder$year == 2012) { :
  the condition has length > 1 and only the first element will be used
~~~

If your condition evaluates to a vector with more than one logical element,
the function `if` will still run, but will only evaluate the condition in the first
element. Here you need to make sure your condition is of length 1.

> ### Tip: `any` and `all` {.callout}
> The `any` function will return TRUE if at least one
> TRUE value is found within a vector, otherwise it will return `FALSE`.
> This can be used in a similar way to the `%in%` operator.
> The function `all`, as the name suggests, will only return `TRUE` if all values in
> the vector are `TRUE`.
>


### Repeating operations

Sometimes you will find yourself needing to repeat an operation until a certain
condition is met. You can do this with a `while` loop.

~~~ {.r}
while(this condition is true) {
    do a thing
}
~~~

Let's try an example, shall we?  We'll try to come up with some simple code
that generates random numbers from a uniform distribution (the `runif` function)
between 0 and 1 until it gets one that's less than 0.1.

~~~ {.r}
while(z > 0.1) {
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
while(z > 0.1) {
    z <- runif(1)
    print(z)
}
~~~

> ### Challenge 2 {.challenge}
>
> Use a `while` loop to construct a vector called 'pet_list'
> with the value:
> 'cat', 'dog', 'dog', 'dog', 'dog'
> (N.B. using a loop may not be the most efficient way
> to do this, but it illustrates the principle!)
>

`while` loops will not always be appropriate. If you want to iterate over
a set of values, when the order of iteration is important, and perform the
same operation on each, a `for` loop will do the job.
We saw `for` loops in the shell lessons earlier. This is the most
flexible of looping operations, but therefore also the hardest to use
correctly. Avoid using `for` loops unless the order of iteration is important:
i.e. the calculation at each iteration depends on the results of previous iterations.

The basic structure of a `for` loop is:

~~~ {.r}
for(iterator in set of values) {
    do a thing
}
~~~

For example:

~~~ {.r}
for(i in 1:10) {
    print(i)
}
~~~

The `1:10` bit creates a vector on the fly; you can iterate
over any other vector as well.

We can use a `for` loop nested within another `for` loop to iterate over two things at
once.

~~~ {.r}
for (i in 1:5) {
    for(j in c('a', 'b', 'c', 'd', 'e')) {
        print(paste(i,j))
    }
}
~~~

Rather than printing the results, we could write the loop output to a new object.

~~~ {.r}
output_vector <- c()
for (i in 1:5) {
  for(j in c('a', 'b', 'c', 'd', 'e')) {
    temp_output <- paste(i, j)
    output_vector <- c(output_vector, temp_output)
  }
}
output_vector
~~~

~~~ {.output}
 [1] "1 a" "1 b" "1 c" "1 d" "1 e" "2 a" "2 b" "2 c"
 [9] "2 d" "2 e" "3 a" "3 b" "3 c" "3 d" "3 e" "4 a"
[17] "4 b" "4 c" "4 d" "4 e" "5 a" "5 b" "5 c" "5 d"
[25] "5 e"
~~~

This approach can be useful, but 'growing your results' (building
the result object incrementally) is computationally inefficient, so avoid
it when you are iterating through a lot of values.

> ### Tip: don't grow your results {.callout}
>
> One of the biggest things that trips up novices and
> experienced R users alike, is building a results object
> (vector, list, matrix, data frame) as your for loop progresses.
> Computers are very bad at handling this, so your calculations
> can very quickly slow to a crawl. It's much better to define
> an empty results object before hand of the appropriate dimensions.
> So if you know the end result will be stored in a matrix like above,
> create an empty matrix with 5 row and 5 columns, then at each iteration
> store the results in the appropriate location.
>

A better way is to define your (empty) output object before filling in the values.
For this example, it looks more involved, but is still more efficient.

~~~ {.r}
output_matrix <- matrix(nrow=5, ncol=5)
j_vector <- c('a', 'b', 'c', 'd', 'e')
for (i in 1:5) {
    for(j in 1:5) {
        temp_j_value <- j_vector[j]
        temp_output <- paste(i, temp_j_value)
        output_matrix[i, j] <- temp_output
    }
}
output_vector2 <- as.vector(output_matrix)
output_vector2
~~~

> ### Challenge 3 {.challenge}
>
> Compare the objects output_vector and
> output_vector2. Are they the same? If not, why not?
> How would you change the last block of code to make output_vector2
> the same as output_vector?


> ### Challenge 4 {.challenge}
>
> Write a script that loops through the `gapminder` data by continent and prints out
> whether the mean life expectancy is smaller or larger than 50
> years.
>

> ### Challenge 5 {.challenge}
>
> Modify the script from Challenge 4 to also loop over each
> country. This time print out whether the life expectancy is
> smaller than 50, between 50 and 70, or greater than 70.
>

> ### Challenge 6 - Advanced {.challenge}
>
> Write a script that loops over each country in the `gapminder` dataset,
> tests whether the country starts with a 'B', and graphs life expectancy
> against time as a line graph if the mean life expectancy is under 50 years.
>
