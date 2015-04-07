---
layout: page
title: R for reproducible scientific analysis
subtitle: Creating functions
minutes: 15
---


> ## Objectives {.objectives}
>
> * Define a function that takes arguments.
> * Return a value from a function.
> * Test a function.
> * Set default values for function arguments.
> * Explain why we should divide programs into small, single-purpose functions.
>

If we only had one data set to analyze, it would probably be faster to load the
file into a spreadsheet and use that to plot simple statistics. However, the 
gapminder data is updated periodically, and we may want to pull in that new 
information later and re-run our analysis again. We may also obtain similar data
from a different source in the future.

In this lesson, we'll learn how to write a function so that we can repeat
several operations with a single command.


### Defining a function

Let's open a new R script file in the `functions/` directory and call it functions-lesson.R.
We're going to define
a function that calculates the Gross Domestic Product of a nation from the data
available in our dataset:

~~~{.r}
# Takes a dataset and multiplies the population column
# with the GDP per capita column.
calcGDP <- function(dat) {
  gdp <- dat$pop * dat$gdpPercap
  return(gdp)
}
~~~

We define `calcGDP` by assigning it to the output of `function`.
The list of argument names are containted within parentheses.
Next, the body of the function -- the statements executed when you
call the function -- is contained within curly braces (`{}`). 

We've indented the statements in the body by two spaces. This makes
the code easier to read but does not affect how it operates.

When we call the function, the values we pass to it are assigned 
to the arguments, which become variables inside the body of the 
function.

Inside the function, we use the `return` function to send back the 
result. This return function is optional: R will automatically 
return the results of whatever command is executed on the last line
of the function.

Let's `source` our script of function definitions and check that it
works on the gapminder data:

~~~{.r}
source("functions/functions-lesson.R")
calcGDP(head(gapminder))
~~~

~~~ {.output}
[1]  6567086330  7585448670  8758855797  9648014150  9678553274 11697659231
~~~

That's not very informative. Let's add some more arguments so we can extract 
that per year and country. 

~~~{.r}
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
~~~

~~~{.r}
source("functions/functions-lesson.R")
~~~

Ok, so there's a lot going on in this function now. In plain english,
the function now subsets the provided data by year if the year argument isn't 
empty, then subsets the result by country if the country argument isn't empty.
Then it calculates the GDP for whatever subset emerges from the previous two steps.
The function then adds the GDP as a new column to the subsetted data and returns
this as the final result.
You can see that the output is much more informative than just getting a vector of numbers.

Let's take a look at what happens when we specify the year:

~~~ {.r}
head(calcGDP(gapminder, year=2007))
~~~

~~~ {.output}
       country year      pop continent lifeExp  gdpPercap          gdp
12 Afghanistan 2007 31889923      Asia  43.828   974.5803  31079291949
24     Albania 2007  3600523    Europe  76.423  5937.0295  21376411360
36     Algeria 2007 33333216    Africa  72.301  6223.3675 207444851958
48      Angola 2007 12420476    Africa  42.731  4797.2313  59583895818
60   Argentina 2007 40301927  Americas  75.320 12779.3796 515033625357
72   Australia 2007 20434176   Oceania  81.235 34435.3674 703658358894
~~~

Or for a specific country:

~~~ {.r}
calcGDP(gapminder, country="Australia")
~~~

~~~ {.output}
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
~~~

Or both:

~~~ {.r}
calcGDP(gapminder, year=2007, country="Australia")
~~~

~~~ {.output}
     country year      pop continent lifeExp gdpPercap          gdp
72 Australia 2007 20434176   Oceania  81.235  34435.37 70365835889
~~~

Let's walk through the body of the function:

~~~ {.r}
calcGDP <- function(dat, year=NULL, country=NULL) {
~~~

Here we've added two argumets, `year`, and `country`. We've set 
*default arguments* for both as `NULL` using the `=` operator
in the function definition. This means that those arguments will
take on those values unless the user specifies otherwise.

~~~ {.r}
  if(!is.null(year)) {
    dat <- dat[dat$year %in% year, ] 
  }
  if (!is.null(country)) {
    dat <- dat[dat$country %in% country,]
  }
~~~

Here, we check whether each additional argument is set to `null`,
and whenever they're not `null` overwrite the dataset stored in `dat` with 
a subset given by the non-`null` argument.

I did this so that our function is more flexible for later. We 
can ask it to calculate the GDP for:

 * The whole dataset;
 * A single year;
 * A single country;
 * A single combination of year and country.

By using `%in%` instead, we can also give multiple years or countries
to those arguments.

> #### Tip: Pass by value {.callout}
>
> Functions in R almost always make copies of the data to operate on
> inside of a function body. When we modify `dat` inside the function
> we are modifying the copy of the gapminder dataset stored in `dat`,
> not the original variable we gave as the first argument. 
>
> This is called "pass-by-value" and it makes writing code much safer:
> you can always be sure that whatever changes you make within the 
> body of the function, stay inside the body of the function. 
>

> #### Tip: Function scope {.callout}
>
> Another important concept is scoping: any variables (or functions!) you
> create or modify inside the body of a function only exist for the lifetime
> of the function's execution. When we call `calcGDP`, the variables `dat`,
> `gdp` and `new` only exist inside the body of the function. Even if we 
> have variables of the same name in our interactive R session, they are 
> not modified in any way when executing a function.
>

~~~ {.r}
  gdp <- dat$pop * dat$gdpPercap
  new <- cbind(dat, gdp=gdp)   
  return(new)
}
~~~

Finally, we calculated the GDP on our new subset, and created a new 
data frame with that column added. This means when we call the function
later we can see the context for the returned GDP values,
which is much better than in our first attempt where we just got a vector of numbers.

> #### Challenge 1 {.challenge}
>
> The `paste` function can be used to combine text together, e.g:
> 
> ~~~ {.r}
> best_practice <- c("Write", "programs", "for", "people", "not", "computers")
> paste(best_practice, collapse=" ")
> ~~~
>
> ~~~ {.output}
> [1] "Write programs for people not computers"
> ~~~
>
>  Write a function called `fence` that takes two vectors as arguments, called
> `text` and `wrapper`, and prints out the text wrapped with the `wrapper`:
>
> ~~~ {.r}
> fence(text=best_practice, wrapper="***")
> ~~~
> 
> ~~~ {.output}
> [1] "*** Write programs for people not computers ***"
> ~~~
> 
> *Note:* the `paste` function has an argument called `sep`, which specifies the
> separator between text. The default is a space: " ". The default for `paste0`
> is no space "".
>

#### Composing functions

The real power of functions comes from mixing, matching and combining them
into ever large chunks to get the effect we want.

Let's define two functions that will convert temparature from Fahrenheit to
Kelvin, and Kelvin to Celsius:

~~~ {.r}
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5 / 9)) + 273.15
  return(kelvin)
}

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}
~~~

Now, when we define the function to convert directly from Fahrenheit to Celsius,
we can simply reuse these two functions:

~~~ {.r}
fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}
~~~

> ## Tip {.callout} 
> 
> R has some unique aspects that can be exploited when performing 
> more complicated operations. We will not be writing anything that requires 
> knowledge of these more advanced concepts. In the future when you are 
> comfortable writing functions in R, you can learn more by reading the 
> [R Language Manual][man] or this [chapter][] from 
> [Advanced R Programming][adv-r] by Hadley Wickham. For context, R uses the 
> terminology "environments" instead of frames.

[man]: http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Environment-objects
[chapter]: http://adv-r.had.co.nz/Environments.html
[adv-r]: http://adv-r.had.co.nz/


> #### Tip: Testing and documenting {.callout}
>
> It's important to both test functions and document them:
> Documentation helps you, and others, understand what the 
> purpose of your function is, and how to use it, and its
> important to make sure that your function actually does
> what you think.
>
> When you first start out, your workflow will probably look a lot
> like this:
>   
>  1. Write a function
>  2. Comment parts of the function to document its behaviour
>  3. Load in the source file
>  4. Experiment with it in the console to make sure it behaves
>     as you expect
>  5. Make any necessary bug fixes
>  6. Rinse and repeat.
> 
> Formal documentation for functions, written in separate `.Rd`
> files, gets turned into the documentation you see in help
> files. The [roxygen2][] package allows R coders to write documentation alongside 
> the function code and then process it into the appropriate `.Rd` files.
> You will want to switch to this more formal method of writing documentation 
> when you start writing more complicated R projects.
>
> Formal automated tests can be written using the [testthat][] package.

[roxygen2]: http://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html
[testthat]: http://r-pkgs.had.co.nz/tests.html


