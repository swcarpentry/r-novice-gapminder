---
layout: page
title: R for reproducible scientific analysis
subtitle: Split-apply-combine
minutes: 45
---



> ## Learning objectives {.objectives}
>
> * To be able to use the split-apply-combine strategy for data analysis
>

Previously we looked at how you can use functions to simplify your code.
We defined the `calcGDP` function, which takes the gapminder dataset,
and multiplies the population and GDP per capita column. We also defined
additional arguments so we could filter by `year` and `country`:


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

A common task you'll encounter when working with data, is that you'll want to
run calculations on different groups within the data. In the above, we were
simply calculating the GDP by multiplying two columns together. But what if
we wanted to calculated the mean GDP per continent?

We could run `calcGPD` and then take the mean of each continent:


~~~{.r}
withGDP <- calcGDP(gapminder)
mean(withGDP[withGDP$continent == "Africa", "gdp"])
~~~



~~~{.output}
[1] 2.09e+10

~~~



~~~{.r}
mean(withGDP[withGDP$continent == "Americas", "gdp"])
~~~



~~~{.output}
[1] 3.793e+11

~~~



~~~{.r}
mean(withGDP[withGDP$continent == "Asia", "gdp"])
~~~



~~~{.output}
[1] 2.272e+11

~~~

But this isn't very *nice*. Yes, by using a function, you have reduced a
substantial amount of repetition. That **is** nice. But there is still
repetition. Repeating yourself will cost you time, both now and later, and
potentially introduce some nasty bugs.

We could write a new function that is flexible like `calcGDP`, but this
also takes a substantial amount of effort and testing to get right.

The abstract problem we're encountering here is know as "split-apply-combine":

![Split apply combine](fig/splitapply.png)

We want to *split* our data into groups, in this case continents, *apply*
some calculations on that group, then optionally *combine* the results
together afterwards.

#### The `plyr` package

For those of you who have used R before, you might be familiar with the
`apply` family of functions. While R's built in functions do work, we're
going to introduce you to another method for solving the "split-apply-combine"
problem. The [plyr](http://had.co.nz/plyr/) package provides a set of
functions that we find more user friendly for solving this problem.

We installed this package in an earlier challenge. Let's load it now:


~~~{.r}
library(plyr)
~~~

Plyr has functions for operating on `lists`, `data.frames` and `arrays`
(matrices, or n-dimensional vectors). Each function performs:

1. A **split**ting operation
2. **Apply** a function on each split in turn.
3. Re**combine** output data as a single data object.

The functions are named based on the data structure they expect as input,
and the data structure you want returned as output: [a]rray, [l]ist, or
[d]ata.frame. The first letter corresponds to the input data structure,
the second letter to the output data structure, and then the rest of the
function is named "ply".

This gives us 9 core functions **ply.  There are an additional three functions
which will only perform the split and apply steps, and not any combine step.
They're named by their input data type and represent null output by a `_` (see
table)

Note here that plyr's use of "array" is different to R's,
an array in ply can include a vector or matrix.

![Full apply suite](fig/full_apply_suite.png)


Each of the xxply functions (`daply`, `ddply`, `llply`, `laply`, ...) has the
same structure and has 4 key features and structure:


~~~{.r}
xxply(.data, .variables, .fun)
~~~

* The first letter of the function name gives the input type and the second gives the output type.
* .data - gives the data object to be processed
* .variables - identifies the splitting variables
* .fun - gives the function to be called on each piece

Now we can quickly calculate the mean GDP per continent:


~~~{.r}
ddply(
 .data = calcGDP(gapminder),
 .variables = "continent",
 .fun = function(x) mean(x$gdp)
)
~~~



~~~{.output}
  continent        V1
1    Africa 2.090e+10
2  Americas 3.793e+11
3      Asia 2.272e+11
4    Europe 2.694e+11
5   Oceania 1.882e+11

~~~

Let's walk through what just happened:

- The `ddply` function feeds in a `data.frame` (function starts with **d**) and
returns another `data.frame` (2nd letter is a **d**) i
- the first argument we gave was the data.frame we wanted to operate on: in this
  case the gapminder data. We called `calcGDP` on it first so that it would have
  the additional `gdp` column added to it.
- The second argument indicated our split criteria: in this case the "continent"
  column. Note that we just gave the name of the column, not the actual column
  itself like we've done previously with subsetting. Plyr takes care of these
  implementation details for you.
- The third argument is the function we want to apply to each grouping of the
  data. We had to define our own short function here: each subset of the data
  gets stored in `x`, the first argument of our function. This is an anonymous
  function: we haven't defined it elsewhere, and it has no name. It only exists
  in the scope of our call to `ddply`.

What if we want a different type of output data structure?:


~~~{.r}
dlply(
 .data = calcGDP(gapminder),
 .variables = "continent",
 .fun = function(x) mean(x$gdp)
)
~~~



~~~{.output}
$Africa
[1] 2.09e+10

$Americas
[1] 3.793e+11

$Asia
[1] 2.272e+11

$Europe
[1] 2.694e+11

$Oceania
[1] 1.882e+11

attr(,"split_type")
[1] "data.frame"
attr(,"split_labels")
  continent
1    Africa
2  Americas
3      Asia
4    Europe
5   Oceania

~~~

We called the same function again, but changed the second letter to an `l`, so
the output was returned as a list.

We can specify multiple columns to group by:


~~~{.r}
ddply(
 .data = calcGDP(gapminder),
 .variables = c("continent", "year"),
 .fun = function(x) mean(x$gdp)
)
~~~



~~~{.output}
   continent year        V1
1     Africa 1952 5.992e+09
2     Africa 1957 7.359e+09
3     Africa 1962 8.785e+09
4     Africa 1967 1.144e+10
5     Africa 1972 1.507e+10
6     Africa 1977 1.869e+10
7     Africa 1982 2.204e+10
8     Africa 1987 2.411e+10
9     Africa 1992 2.626e+10
10    Africa 1997 3.002e+10
11    Africa 2002 3.530e+10
12    Africa 2007 4.578e+10
13  Americas 1952 1.177e+11
14  Americas 1957 1.408e+11
15  Americas 1962 1.692e+11
16  Americas 1967 2.179e+11
17  Americas 1972 2.682e+11
18  Americas 1977 3.241e+11
19  Americas 1982 3.633e+11
20  Americas 1987 4.394e+11
21  Americas 1992 4.899e+11
22  Americas 1997 5.827e+11
23  Americas 2002 6.612e+11
24  Americas 2007 7.767e+11
25      Asia 1952 3.410e+10
26      Asia 1957 4.727e+10
27      Asia 1962 6.014e+10
28      Asia 1967 8.465e+10
29      Asia 1972 1.244e+11
30      Asia 1977 1.598e+11
31      Asia 1982 1.944e+11
32      Asia 1987 2.418e+11
33      Asia 1992 3.071e+11
34      Asia 1997 3.876e+11
35      Asia 2002 4.580e+11
36      Asia 2007 6.275e+11
37    Europe 1952 8.497e+10
38    Europe 1957 1.100e+11
39    Europe 1962 1.390e+11
40    Europe 1967 1.734e+11
41    Europe 1972 2.187e+11
42    Europe 1977 2.554e+11
43    Europe 1982 2.795e+11
44    Europe 1987 3.165e+11
45    Europe 1992 3.427e+11
46    Europe 1997 3.836e+11
47    Europe 2002 4.364e+11
48    Europe 2007 4.932e+11
49   Oceania 1952 5.416e+10
50   Oceania 1957 6.683e+10
51   Oceania 1962 8.234e+10
52   Oceania 1967 1.060e+11
53   Oceania 1972 1.341e+11
54   Oceania 1977 1.547e+11
55   Oceania 1982 1.762e+11
56   Oceania 1987 2.095e+11
57   Oceania 1992 2.363e+11
58   Oceania 1997 2.893e+11
59   Oceania 2002 3.452e+11
60   Oceania 2007 4.037e+11

~~~


~~~{.r}
daply(
 .data = calcGDP(gapminder),
 .variables = c("continent", "year"),
 .fun = function(x) mean(x$gdp)
)
~~~



~~~{.output}
          year
continent       1952      1957      1962      1967      1972      1977
  Africa   5.992e+09 7.359e+09 8.785e+09 1.144e+10 1.507e+10 1.869e+10
  Americas 1.177e+11 1.408e+11 1.692e+11 2.179e+11 2.682e+11 3.241e+11
  Asia     3.410e+10 4.727e+10 6.014e+10 8.465e+10 1.244e+11 1.598e+11
  Europe   8.497e+10 1.100e+11 1.390e+11 1.734e+11 2.187e+11 2.554e+11
  Oceania  5.416e+10 6.683e+10 8.234e+10 1.060e+11 1.341e+11 1.547e+11
          year
continent       1982      1987      1992      1997      2002      2007
  Africa   2.204e+10 2.411e+10 2.626e+10 3.002e+10 3.530e+10 4.578e+10
  Americas 3.633e+11 4.394e+11 4.899e+11 5.827e+11 6.612e+11 7.767e+11
  Asia     1.944e+11 2.418e+11 3.071e+11 3.876e+11 4.580e+11 6.275e+11
  Europe   2.795e+11 3.165e+11 3.427e+11 3.836e+11 4.364e+11 4.932e+11
  Oceania  1.762e+11 2.095e+11 2.363e+11 2.893e+11 3.452e+11 4.037e+11

~~~

You can use these functions in place of `for` loops (and its usually faster to
do so): just write the body of the for loop in the anonymous function:


~~~{.r}
d_ply(
  .data=gapminder,
  .variables = "continent",
  .fun = function(x) {
    meanGDPperCap <- mean(x$gdpPercap)
    print(paste(
      "The mean GDP per capita for", unique(x$continent),
      "is", format(meanGDPperCap, big.mark=",")
   ))
  }
)
~~~



~~~{.output}
[1] "The mean GDP per capita for Africa is 2,194"
[1] "The mean GDP per capita for Americas is 7,136"
[1] "The mean GDP per capita for Asia is 7,902"
[1] "The mean GDP per capita for Europe is 14,469"
[1] "The mean GDP per capita for Oceania is 18,622"

~~~

> #### Tip: printing numbers {.callout}
>
> The `format` function can be used to make numeric
> values "pretty" for printing out in messages.
>


> #### Challenge 1 {.challenge}
>
> Calculate the average life expectancy per continent. Which has the longest?
> Which had the shortest?
>

> #### Challenge 2 {.challenge}
>
> Calculate the average life expectancy per continent and year. Which had the
> longest and shortest in 2007? Which had the greatest change in between 1952
> and 2007?
>

> #### Advanced Challenge {.challenge}
>
> Calculate the difference in mean life expectancy between
> the years 1952 and 2007 from the output of challenge 2
> using one of the `plyr` functions.
>

> #### Alternate Challenge if class seems lost {.challenge}
>
> Without running them, which of the following will calculate the average
> life expectancy per continent:
>
> 1.
> ~~~ {.r}
> ddply(
>   .data = gapminder,
>   .variables = gapminder$continent,
>   .fun = function(dataGroup) {
>      mean(dataGroup$lifeExp)
>   }
> )
> ~~~
>
> 2.
> ~~~ {.r}
> ddply(
>   .data = gapminder,
>   .variables = "continent",
>   .fun = mean(dataGroup$lifeExp)
> )
> ~~~
>
> 3.
> ~~~ {.r}
> ddply(
>   .data = gapminder,
>   .variables = "continent",
>   .fun = function(dataGroup) {
>      mean(dataGroup$lifeExp)
>   }
> )
> ~~~
>
> 4.
> ~~~ {.r}
> adply(
>   .data = gapminder,
>   .variables = "continent",
>   .fun = function(dataGroup) {
>      mean(dataGroup$lifeExp)
>   }
> )
> ~~~
>
