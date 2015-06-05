---
title: "Subsetting and Summarizing"
author: "Kara Woo"
date: "04/14/2015"
output: html_document
---



*Much of this lesson was copied or adapted from Jeff Hollister's [materials](http://usepa.github.io/introR/2015/01/14/03-Clean/)*

> ### Learning Objectives {.objectives}
>
> * Understand bracket subsetting in R.
> * Learn how to use key `dplyr` verbs to summarize data: `select()`,
>   `filter()`, `mutate()`, `group_by()`, and `summarize()`.
> * Create analysis pipelines with `%>%`

## Bracket Subsetting

To pull out one or multiple values from an object, we'll often use square
brackets. For subsetting a vector, you place the brackets right next to the name
of the object, and inside the brackets type the indices you want to extract.
Indexing begins at 1 in R, so `weights[1]` will give you the first element of
`weights`. You can also specify a range of values, such as `weights[1:3]`.

The same approach can be applied to data frames. Data frames have two dimensions
(rows and columns), so the subsetting follows a slightly different pattern:
`dataframe[rows, columns]`. For example:

(The "142 Levels" that appear mean this is a categorical variable and those are
the categories.)


~~~{.r}
gapminder[1, 1] ## First row, first column.
~~~



~~~{.output}
[1] Afghanistan
142 Levels: Afghanistan Albania Algeria Angola Argentina ... Zimbabwe

~~~



~~~{.r}
gapminder[1, 3] ## First row, third column
~~~



~~~{.output}
[1] 1952

~~~



~~~{.r}
gapminder[500, 5:6] ## 500th row, 5th and 6th columns
~~~



~~~{.output}
        pop gdpPercap
500 2915959  521.1341

~~~

To pull out single columns you can also use the `$` sign. `gapminder$pop` will
give you a vector of all values in the `pop` column. This is equivalent to doing
`gapminder[, 5]` or `gapminder[, "pop"]`.

Finally, you can set conditions for which data to return. For example:


~~~{.r}
### Countries and years when populations were less than or equal to 100000
gapminder[gapminder$pop <= 100000, c("country", "year")]
~~~



~~~{.output}
                   country year
421               Djibouti 1952
422               Djibouti 1957
423               Djibouti 1962
1297 Sao Tome and Principe 1952
1298 Sao Tome and Principe 1957
1299 Sao Tome and Principe 1962
1300 Sao Tome and Principe 1967
1301 Sao Tome and Principe 1972
1302 Sao Tome and Principe 1977
1303 Sao Tome and Principe 1982

~~~



~~~{.r}
### All data for Finland
gapminder[gapminder$country == "Finland", ]
~~~



~~~{.output}
    country continent year lifeExp     pop gdpPercap
517 Finland    Europe 1952  66.550 4090500  6424.519
518 Finland    Europe 1957  67.490 4324000  7545.415
519 Finland    Europe 1962  68.750 4491443  9371.843
520 Finland    Europe 1967  69.830 4605744 10921.636
521 Finland    Europe 1972  70.870 4639657 14358.876
522 Finland    Europe 1977  72.520 4738902 15605.423
523 Finland    Europe 1982  74.550 4826933 18533.158
524 Finland    Europe 1987  74.830 4931729 21141.012
525 Finland    Europe 1992  75.700 5041039 20647.165
526 Finland    Europe 1997  77.130 5134406 23723.950
527 Finland    Europe 2002  78.370 5193039 28204.591
528 Finland    Europe 2007  79.313 5238460 33207.084

~~~

> ### Challenge {.challenge}
>
> Which of the following are NOT equivalent?
>
> a) `gapminder[50, 4]` and `gapminder[50, "lifeExp"]`
>
> b) `gapminder[50, 4]` and `gapminder[4, 50]`
>
> c) `gapminder[50, 4]` and `gapminder$lifeExp[50]`

> ### Challenge {.challenge}
>
> Which countries in the data have life expectancies greater than 80?

## Data manipulation using dplyr

Bracket subsetting is handy, but it can be cumbersome and difficult to read,
especially for complicated operations. Enter `dplyr`. `dplyr` is a package for
making data manipulation easier.

Packages in R are basically sets of additional functions that let you do more
stuff in R. The functions we've been using, like `str()`, come built into R;
packages give you access to more functions. You need to install a package and
then load it to be able to use it.


~~~{.r}
install.packages("dplyr") ## install
~~~

You might get asked to choose a CRAN mirror -- this is basically asking you to
choose a site to download the package from. The choice doesn't matter too much;
I'd recommend choosing the RStudio mirror or one of the mirrors located in WA.


~~~{.r}
library("dplyr")          ## load
~~~

You only need to install a package once per computer, but you need to load it
every time you open a new R session and want to use that package.

## What is dplyr?

The package `dplyr` is a fairly new (2014) package that tries to provide easy
tools for the most common data manipulation tasks. It is built to work directly
with data frames. The thinking behind it was largely inspired by the package
`plyr` which has been in use for some time but suffered from being slow in some
cases.` dplyr` addresses this by porting much of the computation to C++. An
additional feature is the ability to work with data stored directly in an
external database. The benefits of doing this are that the data can be managed
natively in a relational database, queries can be conducted on that database,
and only the results of the query returned.

This addresses a common problem with R in that all operations are conducted in
memory and thus the amount of data you can work with is limited by available
memory. The database connections essentially remove that limitation in that you
can have a database of many 100s GB, conduct queries on it directly and pull
back just what you need for analysis in R. There is a lot of great info on
`dplyr`. If you have an interest, I'd encourage you to look more. The vignettes
are particularly good.

### Selecting columns and filtering rows

We're going to learn some of the most common `dplyr` functions: `select()`,
`filter()`, `mutate()`, `group_by()`, and `summarize()`. To select columns of a
data frame, use `select()`. The first argument to this function is the data
frame (`gapminder`), and the subsequent arguments are the columns to keep.


~~~{.r}
## Keep columns "country", "year", and "pop"
select(gapminder, country, year, pop)
~~~

To choose rows, use `filter()`:


~~~{.r}
## All data for Finland
filter(gapminder, country == "Finland")
~~~



~~~{.output}
   country continent year lifeExp     pop gdpPercap
1  Finland    Europe 1952  66.550 4090500  6424.519
2  Finland    Europe 1957  67.490 4324000  7545.415
3  Finland    Europe 1962  68.750 4491443  9371.843
4  Finland    Europe 1967  69.830 4605744 10921.636
5  Finland    Europe 1972  70.870 4639657 14358.876
6  Finland    Europe 1977  72.520 4738902 15605.423
7  Finland    Europe 1982  74.550 4826933 18533.158
8  Finland    Europe 1987  74.830 4931729 21141.012
9  Finland    Europe 1992  75.700 5041039 20647.165
10 Finland    Europe 1997  77.130 5134406 23723.950
11 Finland    Europe 2002  78.370 5193039 28204.591
12 Finland    Europe 2007  79.313 5238460 33207.084

~~~

### Pipes

But what if you wanted to select and filter? There are three ways to do this:
use intermediate steps, nested functions, or pipes. With the intermediate steps,
you essentially create a temporary data frame and use that as input to the next
function. This can clutter up your workspace with lots of objects. You can also
nest functions (i.e. one function inside of another).  This is handy, but can be
difficult to read if too many functions are nested as the process from inside
out. The last option, pipes, are a fairly recent addition to R. Pipes let you
take the output of one function and send it directly to the next, which is
useful when you need to many things to the same data set.  Pipes in R look like
`%>%` and are made available via the `magrittr` package installed as
part of `dplyr`.


~~~{.r}
### Countries and years when populations were less than or equal to 10000
gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)
~~~



~~~{.output}
                 country year
1               Djibouti 1952
2               Djibouti 1957
3               Djibouti 1962
4  Sao Tome and Principe 1952
5  Sao Tome and Principe 1957
6  Sao Tome and Principe 1962
7  Sao Tome and Principe 1967
8  Sao Tome and Principe 1972
9  Sao Tome and Principe 1977
10 Sao Tome and Principe 1982

~~~

In the above we use the pipe to send the `gapminder` data set first through
`filter`, to keep rows where `pop` was less than 100000, and then through
`select` to keep the `country` and `year` columns. When the data frame is being
passed to the `filter()` and `select()` functions through a pipe, we don't need
to include it as an argument to these functions anymore.

If we wanted to create a new object with this smaller version of the data we
could do so by assigning it a new name:


~~~{.r}
gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)

gapminder_sml
~~~



~~~{.output}
                 country year
1               Djibouti 1952
2               Djibouti 1957
3               Djibouti 1962
4  Sao Tome and Principe 1952
5  Sao Tome and Principe 1957
6  Sao Tome and Principe 1962
7  Sao Tome and Principe 1967
8  Sao Tome and Principe 1972
9  Sao Tome and Principe 1977
10 Sao Tome and Principe 1982

~~~

> ### Challenge {.challenge}
>
> Using pipes, subset the gapminder data to include rows where `gdpPercap` was
> greater than or equal to 35,000. Retain columns `country`, `year`, and
> `gdpPercap.`

### Mutate

Frequently you'll want to create new columns based on the values in existing
columns, for example to do unit conversions or find the ratio of values in two
columns. For this we'll use `mutate()`.

To create a new column of `gdpPercap` * `pop`:


~~~{.r}
mutate(gapminder, totalgdp = gdpPercap * pop)
~~~

If this runs off your screen and you just want to see the first few rows, you
can use a pipe to view the `head()` of the data (pipes work with non-dplyr
functions too, as long as the `dplyr` or `magrittr` packages are loaded).


~~~{.r}
mutate(gapminder, totalgdp = gdpPercap * pop) %>%
  head
~~~



~~~{.output}
      country continent year lifeExp      pop gdpPercap    totalgdp
1 Afghanistan      Asia 1952  28.801  8425333  779.4453  6567086330
2 Afghanistan      Asia 1957  30.332  9240934  820.8530  7585448670
3 Afghanistan      Asia 1962  31.997 10267083  853.1007  8758855797
4 Afghanistan      Asia 1967  34.020 11537966  836.1971  9648014150
5 Afghanistan      Asia 1972  36.088 13079460  739.9811  9678553274
6 Afghanistan      Asia 1977  38.438 14880372  786.1134 11697659231

~~~

### Split-apply-combine data analysis and the summarize() function

Many data analysis tasks can be approached using the "split-apply-combine"
paradigm: split the data into groups, apply some analysis to each group, and
then combine the results. `dplyr` makes this very easy through the use of the
`group_by()` and `summarize()` functions. `group_by()` splits the data into
groups, and `summarize()` collapses each group into a single-row summary of that
group. For example, to view mean `totalgdp` by continent:


~~~{.r}
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent) %>%
  summarize(meangdp = mean(totalgdp))
~~~



~~~{.output}
Source: local data frame [5 x 2]

  continent      meangdp
1    Africa  20904782844
2  Americas 379262350210
3      Asia 227233738153
4    Europe 269442085301
5   Oceania 188187105354

~~~

You can group by multiple columns too:


~~~{.r}
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp))
~~~



~~~{.output}
Source: local data frame [60 x 3]
Groups: continent

   continent year     meangdp
1     Africa 1952  5992294608
2     Africa 1957  7359188796
3     Africa 1962  8784876958
4     Africa 1967 11443994101
5     Africa 1972 15072241974
6     Africa 1977 18694898732
7     Africa 1982 22040401045
8     Africa 1987 24107264108
9     Africa 1992 26256977719
10    Africa 1997 30023173824
..       ...  ...         ...

~~~

And summarize multiple variables at the same time:


~~~{.r}
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>%
  summarize(meangdp = mean(totalgdp),
            mingdp = min(totalgdp))
~~~



~~~{.output}
Source: local data frame [60 x 4]
Groups: continent

   continent year     meangdp    mingdp
1     Africa 1952  5992294608  52784691
2     Africa 1957  7359188796  52784691
3     Africa 1962  8784876958  70020508
4     Africa 1967 11443994101  98028711
5     Africa 1972 15072241974 117419006
6     Africa 1977 18694898732 150813402
7     Africa 1982 22040401045 186362275
8     Africa 1987 24107264108 168049219
9     Africa 1992 26256977719 179898843
10    Africa 1997 30023173824 194980183
..       ...  ...         ...       ...

~~~

> ### Challenge {.challenge}
>
> Use `group_by()` and `summarize()` to find the maximum life expectancy for
> each continent. Hint: there is a `max()` function.

> ### Challenge {.challenge}
>
> Use `group_by()` and `summarize()` to find the mean, min, and max life
> expectancy for each year.

> ### Challenge {.challenge}
>
> Pick a country and find the population for each year in the data prior to
> 1982. Return a data frame with the columns `country`, `year`, and `pop`.

[Handy dplyr cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
