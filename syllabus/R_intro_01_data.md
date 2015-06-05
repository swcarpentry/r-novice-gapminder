---
title: "Working with data"
author: "Kara Woo"
date: "03/26/2015"
output: html_document
---



> ### Learning Objectives {.objectives}
>
> * Understand the concept of a working directory
> * Understand the concept of a data frame
> * Learn how to load data into R
> * Examine data in R

We're now going to work with some actual data. The data we'll be using is the
[gapminder](https://github.com/jennybc/gapminder) dataset which contains
information on life expectancy, population, and GDP over time for 142 countries.
You should have downloaded this data and placed it on your desktop for now.

### A word about working directories

To load data, R needs to know where to find it. We can use the `getwd()`
function to figure out what our current *working directory* is.


~~~{.r}
getwd()
~~~

To view the files in the current working directory, use `list.files()`:


~~~{.r}
list.files()
~~~

If we want to move to a different working directory, use `setwd()`:

~~~{.r}
setwd("~/Desktop")    ## ~/ is a shortcut for the "home" directory
~~~

However beware that if you write a script that uses `setwd()`, others may not be
able to run that script on their computers if they have organized their
directories differently from you.

For now, let's set the working directory back to our project directory since
that is where the data is.

To load the data into R, we use a function called `read.csv()`.




~~~{.r}
gapminder <- read.csv("gapminder.csv")
~~~

A very useful function for examining the first few rows of your data is
`head()`:


~~~{.r}
head(gapminder)
~~~



~~~{.output}
      country continent year lifeExp      pop gdpPercap
1 Afghanistan      Asia 1952  28.801  8425333  779.4453
2 Afghanistan      Asia 1957  30.332  9240934  820.8530
3 Afghanistan      Asia 1962  31.997 10267083  853.1007
4 Afghanistan      Asia 1967  34.020 11537966  836.1971
5 Afghanistan      Asia 1972  36.088 13079460  739.9811
6 Afghanistan      Asia 1977  38.438 14880372  786.1134

~~~

Many of the functions we used to examine vectors can also be applied to data
frames.

> ### Challenge {.challenge}
>
> Based on the output of `str(gapminder)`, can you answer the following questions?
>
> * What is the class of the object gapminder?
> * How many rows and how many columns are in this object?
> * How many countries are represented in this data?
