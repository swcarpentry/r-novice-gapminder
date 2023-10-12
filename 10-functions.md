---
title: Functions Explained
teaching: 45
exercises: 15
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Define a function that takes arguments.
- Return a value from a function.
- Check argument conditions with `stopifnot()` in functions.
- Test a function.
- Set default values for function arguments.
- Explain why we should divide programs into small, single-purpose functions.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I write a new function in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



If we only had one data set to analyze, it would probably be faster to load the
file into a spreadsheet and use that to plot simple statistics. However, the
gapminder data is updated periodically, and we may want to pull in that new
information later and re-run our analysis again. We may also obtain similar data
from a different source in the future.

In this lesson, we'll learn how to write a function so that we can repeat
several operations with a single command.

:::::::::::::::::::::::::::::::::::::::::  callout

## What is a function?

Functions gather a sequence of operations into a whole, preserving it for
ongoing use. Functions provide:

- a name we can remember and invoke it by
- relief from the need to remember the individual operations
- a defined set of inputs and expected outputs
- rich connections to the larger programming environment

As the basic building block of most programming languages, user-defined
functions constitute "programming" as much as any single abstraction can. If
you have written a function, you are a computer programmer.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Defining a function

Let's open a new R script file in the `functions/` directory and call it
functions-lesson.R.

The general structure of a function is:


```r
my_function <- function(parameters) {
  # perform action
  # return value
}
```

Let's define a function `fahr_to_kelvin()` that converts temperatures from
Fahrenheit to Kelvin:


```r
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```

We define `fahr_to_kelvin()` by assigning it to the output of `function`. The
list of argument names are contained within parentheses.   Next, the
[body](../learners/reference.md#body) of the function--the
statements that are executed when it runs--is contained within curly braces
(`{}`). The statements in the body are indented by two spaces. This makes the
code easier to read but does not affect how the code operates.

It is useful to think of creating functions like writing a cookbook. First you define the "ingredients" that your function needs. In this case, we only need one ingredient to use our function: "temp". After we list our ingredients, we then say what we will do with them, in this case, we are taking our ingredient and applying a set of mathematical operators to it.

When we call the function, the values we pass to it as arguments are assigned to
those variables so that we can use them inside the function. Inside the
function, we use a [return
statement](../learners/reference.md#return-statement) to send a result back to
whoever asked for it.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip

One feature unique to R is that the return statement is not required.
R automatically returns whichever variable is on the last line of the body
of the function. But for clarity, we will explicitly define the
return statement.


::::::::::::::::::::::::::::::::::::::::::::::::::

Let's try running our function.
Calling our own function is no different from calling any other function:


```r
# freezing point of water
fahr_to_kelvin(32)
```

```{.output}
[1] 273.15
```


```r
# boiling point of water
fahr_to_kelvin(212)
```

```{.output}
[1] 373.15
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Write a function called `kelvin_to_celsius()` that takes a temperature in
Kelvin and returns that temperature in Celsius.

Hint: To convert from Kelvin to Celsius you subtract 273.15

:::::::::::::::  solution

## Solution to challenge 1

Write a function called `kelvin_to_celsius` that takes a temperature in Kelvin
and returns that temperature in Celsius


```r
kelvin_to_celsius <- function(temp) {
 celsius <- temp - 273.15
 return(celsius)
}
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Combining functions

The real power of functions comes from mixing, matching and combining them
into ever-larger chunks to get the effect we want.

Let's define two functions that will convert temperature from Fahrenheit to
Kelvin, and Kelvin to Celsius:


```r
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Define the function to convert directly from Fahrenheit to Celsius,
by reusing the two functions above (or using your own functions if you
prefer).

:::::::::::::::  solution

## Solution to challenge 2

Define the function to convert directly from Fahrenheit to Celsius,
by reusing these two functions above


```r
fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Interlude: Defensive Programming

Now that we've begun to appreciate how writing functions provides an efficient
way to make R code re-usable and modular, we should note that it is important
to ensure that functions only work in their intended use-cases. Checking
function parameters is related to the concept of *defensive programming*.
Defensive programming encourages us to frequently check conditions and throw an
error if something is wrong. These checks are referred to as assertion
statements because we want to assert some condition is `TRUE` before proceeding.
They make it easier to debug because they give us a better idea of where the
errors originate.

### Checking conditions with `stopifnot()`

Let's start by re-examining `fahr_to_kelvin()`, our function for converting
temperatures from Fahrenheit to Kelvin. It was defined like so:


```r
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```

For this function to work as intended, the argument `temp` must be a `numeric`
value; otherwise, the mathematical procedure for converting between the two
temperature scales will not work. To create an error, we can use the function
`stop()`. For example, since the argument `temp` must be a `numeric` vector, we
could check for this condition with an `if` statement and throw an error if the
condition was violated. We could augment our function above like so:


```r
fahr_to_kelvin <- function(temp) {
  if (!is.numeric(temp)) {
    stop("temp must be a numeric vector.")
  }
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```

If we had multiple conditions or arguments to check, it would take many lines
of code to check all of them. Luckily R provides the convenience function
`stopifnot()`. We can list as many requirements that should evaluate to `TRUE`;
`stopifnot()` throws an error if it finds one that is `FALSE`. Listing these
conditions also serves a secondary purpose as extra documentation for the
function.

Let's try out defensive programming with `stopifnot()` by adding assertions to
check the input to our function `fahr_to_kelvin()`.

We want to assert the following: `temp` is a numeric vector. We may do that like
so:


```r
fahr_to_kelvin <- function(temp) {
  stopifnot(is.numeric(temp))
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}
```

It still works when given proper input.


```r
# freezing point of water
fahr_to_kelvin(temp = 32)
```

```{.output}
[1] 273.15
```

But fails instantly if given improper input.


```r
# Metric is a factor instead of numeric
fahr_to_kelvin(temp = as.factor(32))
```

```{.error}
Error in fahr_to_kelvin(temp = as.factor(32)): is.numeric(temp) is not TRUE
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Use defensive programming to ensure that our `fahr_to_celsius()` function
throws an error immediately if the argument `temp` is specified
inappropriately.

:::::::::::::::  solution

## Solution to challenge 3

Extend our previous definition of the function by adding in an explicit call
to `stopifnot()`. Since `fahr_to_celsius()` is a composition of two other
functions, checking inside here makes adding checks to the two component
functions redundant.


```r
fahr_to_celsius <- function(temp) {
  stopifnot(is.numeric(temp))
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## More on combining functions

Now, we're going to define a function that calculates the Gross Domestic Product
of a nation from the data available in our dataset:


```r
# Takes a dataset and multiplies the population column
# with the GDP per capita column.
calcGDP <- function(dat) {
  gdp <- dat$pop * dat$gdpPercap
  return(gdp)
}
```

We define `calcGDP()` by assigning it to the output of `function`. The list of
argument names are contained within parentheses. Next, the body of the function
\-- the statements executed when you call the function -- is contained within
curly braces (`{}`).

We've indented the statements in the body by two spaces. This makes the code
easier to read but does not affect how it operates.

When we call the function, the values we pass to it are assigned to the
arguments, which become variables inside the body of the function.

Inside the function, we use the `return()` function to send back the result.
This `return()` function is optional: R will automatically return the results of
whatever command is executed on the last line of the function.


```r
calcGDP(head(gapminder))
```

```{.output}
[1]  6567086330  7585448670  8758855797  9648014150  9678553274 11697659231
```

That's not very informative. Let's add some more arguments so we can extract
that per year and country.


```r
# Takes a dataset and multiplies the population column
# with the GDP per capita column.
calcGDP <- function(dat, year=NULL, country=NULL) {
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
  gdp <- dat$pop * dat$gdpPercap

  new <- cbind(dat, gdp=gdp)
  return(new)
}
```

If you've been writing these functions down into a separate R script
(a good idea!), you can load in the functions into our R session by using the
`source()` function:


```r
source("functions/functions-lesson.R")
```

Ok, so there's a lot going on in this function now. In plain English, the
function now subsets the provided data by year if the year argument isn't empty,
then subsets the result by country if the country argument isn't empty. Then it
calculates the GDP for whatever subset emerges from the previous two steps. The
function then adds the GDP as a new column to the subsetted data and returns
this as the final result. You can see that the output is much more informative
than a vector of numbers.

Let's take a look at what happens when we specify the year:


```r
head(calcGDP(gapminder, year=2007))
```

```{.output}
       country year      pop continent lifeExp  gdpPercap          gdp
12 Afghanistan 2007 31889923      Asia  43.828   974.5803  31079291949
24     Albania 2007  3600523    Europe  76.423  5937.0295  21376411360
36     Algeria 2007 33333216    Africa  72.301  6223.3675 207444851958
48      Angola 2007 12420476    Africa  42.731  4797.2313  59583895818
60   Argentina 2007 40301927  Americas  75.320 12779.3796 515033625357
72   Australia 2007 20434176   Oceania  81.235 34435.3674 703658358894
```

Or for a specific country:


```r
calcGDP(gapminder, country="Australia")
```

```{.output}
     country year      pop continent lifeExp gdpPercap          gdp
61 Australia 1952  8691212   Oceania  69.120  10039.60  87256254102
62 Australia 1957  9712569   Oceania  70.330  10949.65 106349227169
63 Australia 1962 10794968   Oceania  70.930  12217.23 131884573002
64 Australia 1967 11872264   Oceania  71.100  14526.12 172457986742
65 Australia 1972 13177000   Oceania  71.930  16788.63 221223770658
66 Australia 1977 14074100   Oceania  73.490  18334.20 258037329175
67 Australia 1982 15184200   Oceania  74.740  19477.01 295742804309
68 Australia 1987 16257249   Oceania  76.320  21888.89 355853119294
69 Australia 1992 17481977   Oceania  77.560  23424.77 409511234952
70 Australia 1997 18565243   Oceania  78.830  26997.94 501223252921
71 Australia 2002 19546792   Oceania  80.370  30687.75 599847158654
72 Australia 2007 20434176   Oceania  81.235  34435.37 703658358894
```

Or both:


```r
calcGDP(gapminder, year=2007, country="Australia")
```

```{.output}
     country year      pop continent lifeExp gdpPercap          gdp
72 Australia 2007 20434176   Oceania  81.235  34435.37 703658358894
```

Let's walk through the body of the function:


```r
calcGDP <- function(dat, year=NULL, country=NULL) {
```

Here we've added two arguments, `year`, and `country`. We've set
*default arguments* for both as `NULL` using the `=` operator
in the function definition. This means that those arguments will
take on those values unless the user specifies otherwise.


```r
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ]
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
```

Here, we check whether each additional argument is set to `null`, and whenever
they're not `null` overwrite the dataset stored in `dat` with a subset given by
the non-`null` argument.

Building these conditionals into the function makes it more flexible for later.
Now, we can use it to calculate the GDP for:

- The whole dataset;
- A single year;
- A single country;
- A single combination of year and country.

By using `%in%` instead, we can also give multiple years or countries to those
arguments.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Pass by value

Functions in R almost always make copies of the data to operate on
inside of a function body. When we modify `dat` inside the function
we are modifying the copy of the gapminder dataset stored in `dat`,
not the original variable we gave as the first argument.

This is called "pass-by-value" and it makes writing code much safer:
you can always be sure that whatever changes you make within the
body of the function, stay inside the body of the function.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Function scope

Another important concept is scoping: any variables (or functions!) you
create or modify inside the body of a function only exist for the lifetime
of the function's execution. When we call `calcGDP()`, the variables `dat`,
`gdp` and `new` only exist inside the body of the function. Even if we
have variables of the same name in our interactive R session, they are
not modified in any way when executing a function.


::::::::::::::::::::::::::::::::::::::::::::::::::


```r
  gdp <- dat$pop * dat$gdpPercap
  new <- cbind(dat, gdp=gdp)
  return(new)
}
```

Finally, we calculated the GDP on our new subset, and created a new data frame
with that column added. This means when we call the function later we can see
the context for the returned GDP values, which is much better than in our first
attempt where we got a vector of numbers.

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4

Test out your GDP function by calculating the GDP for New Zealand in 1987. How
does this differ from New Zealand's GDP in 1952?

:::::::::::::::  solution

## Solution to challenge 4


```r
  calcGDP(gapminder, year = c(1952, 1987), country = "New Zealand")
```

GDP for New Zealand in 1987: 65050008703

GDP for New Zealand in 1952: 21058193787



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 5

The `paste()` function can be used to combine text together, e.g:


```r
best_practice <- c("Write", "programs", "for", "people", "not", "computers")
paste(best_practice, collapse=" ")
```

```{.output}
[1] "Write programs for people not computers"
```

Write a function called `fence()` that takes two vectors as arguments, called
`text` and `wrapper`, and prints out the text wrapped with the `wrapper`:


```r
fence(text=best_practice, wrapper="***")
```

*Note:* the `paste()` function has an argument called `sep`, which specifies
the separator between text. The default is a space: " ". The default for
`paste0()` is no space "".

:::::::::::::::  solution

## Solution to challenge 5

Write a function called `fence()` that takes two vectors as arguments,
called `text` and `wrapper`, and prints out the text wrapped with the
`wrapper`:


```r
fence <- function(text, wrapper){
  text <- c(wrapper, text, wrapper)
  result <- paste(text, collapse = " ")
  return(result)
}
best_practice <- c("Write", "programs", "for", "people", "not", "computers")
fence(text=best_practice, wrapper="***")
```

```{.output}
[1] "*** Write programs for people not computers ***"
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip

R has some unique aspects that can be exploited when performing more
complicated operations. We will not be writing anything that requires
knowledge of these more advanced concepts. In the future when you are
comfortable writing functions in R, you can learn more by reading the
[R Language Manual][man] or this [chapter] from
[Advanced R Programming][adv-r] by Hadley Wickham.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Testing and documenting

It's important to both test functions and document them:
Documentation helps you, and others, understand what the
purpose of your function is, and how to use it, and its
important to make sure that your function actually does
what you think.

When you first start out, your workflow will probably look a lot
like this:

1. Write a function
2. Comment parts of the function to document its behaviour
3. Load in the source file
4. Experiment with it in the console to make sure it behaves
  as you expect
5. Make any necessary bug fixes
6. Rinse and repeat.

Formal documentation for functions, written in separate `.Rd`
files, gets turned into the documentation you see in help
files. The [roxygen2] package allows R coders to write documentation
alongside the function code and then process it into the appropriate `.Rd`
files. You will want to switch to this more formal method of writing
documentation when you start writing more complicated R projects. In fact,
packages are, in essence, bundles of functions with this formal documentation.
Loading your own functions through `source("functions.R")` is equivalent to
loading someone else's functions (or your own one day!) through
`library("package")`.

Formal automated tests can be written using the [testthat] package.


::::::::::::::::::::::::::::::::::::::::::::::::::

[man]: https://cran.r-project.org/doc/manuals/r-release/R-lang.html#Environment-objects
[chapter]: https://adv-r.had.co.nz/Environments.html
[adv-r]: https://adv-r.had.co.nz/
[roxygen2]: https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html
[testthat]: https://r-pkgs.had.co.nz/tests.html


:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `function` to define a new function in R.
- Use parameters to pass values into functions.
- Use `stopifnot()` to flexibly check function arguments in R.
- Load functions into programs using `source()`.

::::::::::::::::::::::::::::::::::::::::::::::::::


