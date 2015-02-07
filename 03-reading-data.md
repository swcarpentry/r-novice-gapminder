---
layout: page
title: R for reproducible scientific analysis
subtitle: Reading data
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * To be able to read in regular data into R
>

### Reading in data

Now that we've obtained the gapminder dataset, we want to load it into R. 
Before reading in data, it's a good idea to have a look at its structure.
Let's take a look using our newly-learned shell skills:

~~~ {.shell}
cd gapminder/data/ # navigate to the data directory of the project folder
head gapminder-FiveYearData.csv 
~~~

~~~ {.output}
country,year,pop,continent,lifeExp,gdpPercap
Afghanistan,1952,8425333,Asia,28.801,779.4453145
Afghanistan,1957,9240934,Asia,30.332,820.8530296
Afghanistan,1962,10267083,Asia,31.997,853.10071
Afghanistan,1967,11537966,Asia,34.02,836.1971382
Afghanistan,1972,13079460,Asia,36.088,739.9811058
Afghanistan,1977,14880372,Asia,38.438,786.11336
Afghanistan,1982,12881816,Asia,39.854,978.0114388
Afghanistan,1987,13867957,Asia,40.822,852.3959448
Afghanistan,1992,16317921,Asia,41.674,649.3413952
~~~

As its file extension would suggest, the file contains comma-separated 
values, and seems to contain a header row.

We can use `read.table` to read this into R

~~~ {.r}
gapminder <- read.table(
  file="data/gapminder-FiveYearData.csv",
  header=TRUE, sep=","
)
head(gapminder)
~~~

~~~ {.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~

Because we know the structure of the data, we're able
to specify the appropriate arguments to `read.table`.
Without these arguments, `read.table` will do its 
best to do something sensible, but it is always more
reliable to explicitly tell `read.table` the structure
of the data. `read.csv` function provides a convenient shortcut
for loading in CSV files.

> #### Miscellaneous Tips {.callout}
>
> 1. You can also read in files from the internet by replacing
> the file paths with a web address.
>
> 2. You can read directly from excel spreadsheets without 
> converting them to plain text by using the `xlsx` package.
>

> #### Challenge {.challenge}
>
> Go to file -> new file -> R script, and write an R script 
> to load in the gapminder dataset. Put it in the `scripts/`
> directory and add it to version control.
>
> Run the script using the `source` function, using the file path 
> as its argument (or by pressing the "source" button in RStudio).
>

