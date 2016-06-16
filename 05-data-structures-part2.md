---
layout: page
title: R for reproducible scientific analysis
subtitle: Exploring Data Frames
minutes: 45
---



> ## Learning Objectives {.objectives}
>
> - To learn how to manipulate a data.frame in memory
> - To tour some best practices of exploring and understanding a data.frame when it is first loaded.
>

At this point, you've see it all - in the last lesson, we toured all the basic data types and data structures in R. Everything you do will be a manipulation of those tools. But a whole lot of the time, the star of the show is going to be the data.frame - that table that we started with that information from a CSV gets dumped into when we load it. In this lesson, we'll learn a few more things about working with data.frame.

We learned last time that the columns in a data.frame were vectors, so that our data are consistent in type throughout the column. As such, if we want to add a new column, we need to start by making a new vector:




~~~{.r}
age <- c(2,3,5,12)
cats
~~~



~~~{.output}
    coat weight likes_string
1 calico    2.1         TRUE
2  black    5.0        FALSE
3  tabby    3.2         TRUE

~~~

We can then add this as a column via:


~~~{.r}
cats <- cbind(cats, age)
~~~



~~~{.error}
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4

~~~

Why didn't this work? Of course, R wants to see one element in our new column for every row in the table:


~~~{.r}
cats
~~~



~~~{.output}
    coat weight likes_string
1 calico    2.1         TRUE
2  black    5.0        FALSE
3  tabby    3.2         TRUE

~~~



~~~{.r}
age <- c(4,5,8)
cats <- cbind(cats, age)
cats
~~~



~~~{.output}
    coat weight likes_string age
1 calico    2.1         TRUE   4
2  black    5.0        FALSE   5
3  tabby    3.2         TRUE   8

~~~

Now how about adding rows - in this case, we saw last time that the rows of a data.frame are made of lists:


~~~{.r}
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
~~~



~~~{.error}
Warning in `[<-.factor`(`*tmp*`, ri, value = "tortoiseshell"): invalid
factor level, NA generated

~~~

Another thing to look out for has emerged - when R creates a factor, it only allows whatever is originally there when our data was first loaded, which was 'black', 'calico' and 'tabby' in our case. Anything new that doesn't fit into one of its categories is rejected as nonsense, until we explicitly add that as a *level* in the factor:


~~~{.r}
levels(cats$coat)
~~~



~~~{.output}
[1] "black"  "calico" "tabby" 

~~~



~~~{.r}
levels(cats$coat) <- c(levels(cats$coat), 'tortoiseshell')
cats <- rbind(cats, list("tortoiseshell", 3.3, TRUE, 9))
~~~

Alternatively, we can change a factor column to a character vector; we lose the handy categories of the factor, but can subsequently add any word we want to the column without babysitting the factor levels:


~~~{.r}
str(cats)
~~~



~~~{.output}
'data.frame':	5 obs. of  4 variables:
 $ coat        : Factor w/ 4 levels "black","calico",..: 2 1 3 NA 4
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: logi  TRUE FALSE TRUE TRUE TRUE
 $ age         : num  4 5 8 9 9

~~~



~~~{.r}
cats$coat <- as.character(cats$coat)
str(cats)
~~~



~~~{.output}
'data.frame':	5 obs. of  4 variables:
 $ coat        : chr  "calico" "black" "tabby" NA ...
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: logi  TRUE FALSE TRUE TRUE TRUE
 $ age         : num  4 5 8 9 9

~~~

We now know how to add rows and columns to our data.frame in R - but in our work we've accidentally added a garbage row:


~~~{.r}
cats
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
4          <NA>    3.3         TRUE   9
5 tortoiseshell    3.3         TRUE   9

~~~

We can ask for a data.frame minus this offending row:


~~~{.r}
cats[-4,]
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
5 tortoiseshell    3.3         TRUE   9

~~~

Notice the comma with nothing after it to indicate we want to drop the entire fourth row. 

Note: We could also remove both new rows at once by putting the row numbers inside of a vector: `cats[c(4,5),]`

Alternatively, we can drop all rows with `NA` values:


~~~{.r}
na.omit(cats)
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
5 tortoiseshell    3.3         TRUE   9

~~~

Let's reassign the output to `cats`, so that our changes will be permanent:


~~~{.r}
cats <- na.omit(cats)
~~~

The key to remember when adding data to a data.frame is that *columns are vectors or factors, and rows are lists.*
We can also glue two dataframes together with `rbind`:


~~~{.r}
cats <- rbind(cats, cats)
cats
~~~



~~~{.output}
            coat weight likes_string age
1         calico    2.1         TRUE   4
2          black    5.0        FALSE   5
3          tabby    3.2         TRUE   8
5  tortoiseshell    3.3         TRUE   9
11        calico    2.1         TRUE   4
21         black    5.0        FALSE   5
31         tabby    3.2         TRUE   8
51 tortoiseshell    3.3         TRUE   9

~~~
But now the row names are unnecessarily complicated. We can remove the rownames, and R will automatically re-name them sequentially:


~~~{.r}
rownames(cats) <- NULL
cats
~~~



~~~{.output}
           coat weight likes_string age
1        calico    2.1         TRUE   4
2         black    5.0        FALSE   5
3         tabby    3.2         TRUE   8
4 tortoiseshell    3.3         TRUE   9
5        calico    2.1         TRUE   4
6         black    5.0        FALSE   5
7         tabby    3.2         TRUE   8
8 tortoiseshell    3.3         TRUE   9

~~~

> ## Challenge 1 {.challenge}
>
> You can create a new data.frame right from within R with the following syntax:
> 
> ~~~{.r}
> df <- data.frame(id = c('a', 'b', 'c'), x = 1:3, y = c(TRUE, TRUE, FALSE), stringsAsFactors = FALSE)
> ~~~
> Make a data.frame that holds the following information for yourself:
>
> - first name
> - last name
> - lucky number
>
> Then use `rbind` to add an entry for the people sitting beside you. 
> Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"
>

So far, you've seen the basics of manipulating data.frames with our cat data; now, let's use those skills to digest a more realistic dataset. Lets read in the gapminder dataset that we downloaded previously:


~~~{.r}
gapminder <- read.csv("data/gapminder-FiveYearData.csv")
~~~

> ## Miscellaneous Tips {.callout}
>
> 1. Another type of file you might encounter are tab-separated value files (.tsv). To specify a tab as a separator, use `"\\t"` or `read.delim()`.
>
> 2. You can also read in files from the Internet by replacing
> the file paths with a web address. For example,
> 
> 
> ~~~{.r}
> gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/data/gapminder-FiveYearData.csv")
> ~~~
>
> 3. You can read directly from excel spreadsheets without
> converting them to plain text first by using the [readxl](https://cran.r-project.org/web/packages/readxl/index.html) package.
>

Let's investigate gapminder a bit; the first thing we should always do is check out what the data looks like with `str`:


~~~{.r}
str(gapminder)
~~~



~~~{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...

~~~

We can also examine individual columns of the data.frame with our `typeof` function:


~~~{.r}
typeof(gapminder$year)
~~~



~~~{.output}
[1] "integer"

~~~



~~~{.r}
typeof(gapminder$lifeExp)
~~~



~~~{.output}
[1] "double"

~~~



~~~{.r}
typeof(gapminder$country)
~~~



~~~{.output}
[1] "integer"

~~~



~~~{.r}
str(gapminder$country)
~~~



~~~{.output}
 Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...

~~~

We can also interrogate the data.frame for information about its dimensions; remembering that `str(gapminder)` said there were 1704 observations of 6 variables in gapminder, what do you think the following will produce, and why?


~~~{.r}
length(gapminder)
~~~



~~~{.output}
[1] 6

~~~

A fair guess would have been to say that the length of a data.frame would be the number of rows it has (1704), but this is not the case; remember, a data.frame is a *list of vectors and factors*:


~~~{.r}
typeof(gapminder)
~~~



~~~{.output}
[1] "list"

~~~

When `length` gave us 6, it's because gapminder is built out of a list of 6 columns. To get the number of rows and columns in our dataset, try:


~~~{.r}
nrow(gapminder)
~~~



~~~{.output}
[1] 1704

~~~



~~~{.r}
ncol(gapminder)
~~~



~~~{.output}
[1] 6

~~~

Or, both at once:


~~~{.r}
dim(gapminder)
~~~



~~~{.output}
[1] 1704    6

~~~

We'll also likely want to know what the titles of all the columns are, so we can ask for them later:

~~~{.r}
colnames(gapminder)
~~~



~~~{.output}
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"

~~~

At this stage, it's important to ask ourselves if the structure R is reporting matches our intuition or expectations; do the basic data types reported for each column make sense? If not, we need to sort any problems out now before they turn into bad surprises down the road, using what we've learned about how R interprets data, and the importance of *strict consistency* in how we record our data.

Once we're happy that the data types and structures seem reasonable, it's time to start digging into our data proper. Check out the first few lines:


~~~{.r}
head(gapminder)
~~~



~~~{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134

~~~

To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later.

> ## Challenge 2 {.challenge}
>
> Go to file -> new file -> R script, and write an R script
> to load in the gapminder dataset. Put it in the `scripts/`
> directory and add it to version control.
>
> Run the script using the `source` function, using the file path
> as its argument (or by pressing the "source" button in RStudio).
>

> ## Challenge 3 {.challenge}
>
> Read the output of `str(gapminder)` again; 
> this time, use what you've learned about factors, lists and vectors,
> as well as the output of functions like `colnames` and `dim`
> to explain what everything that `str` prints out for gapminder means.
> If there are any parts you can't interpret, discuss with your neighbors!
>

## Challenge solutions

> ## Solution to Challenge 1 {.challenge}
> 
> ~~~{.r}
> df <- data.frame(first = c('Grace'), last = c('Hopper'), lucky_number = c(0), stringsAsFactors = FALSE)
> df <- rbind(df, list('Marie', 'Curie', 238) )
> df <- cbind(df, coffeetime = c(TRUE,TRUE))
> ~~~
>

> ## Solution to Challenge 2 {.challenge}
> The contents of `script/load-gapminder.R`:
> 
> ~~~{.r}
> gapminder <- read.csv(file = "data/gapminder-FiveYearData.csv")
> ~~~
> To run the script and load the data into the `gapminder` variable:
> 
> ~~~{.r}
> source(file = "scripts/load-gapminder.R")
> ~~~
>

> ## Solution to Challenge 3 {.challenge}
> 
> The object `gapminder` is a data frame with columns
> - `country` and `continent` are factors.
> - `year` is an integer vector.
> - `pop`, `lifeExp`, and `gdpPercap` are numeric vectors.
> 

