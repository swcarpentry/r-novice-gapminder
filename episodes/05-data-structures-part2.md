---
title: "Exploring Data Frames"
teaching: 20
exercises: 10
questions:
- "How can I manipulate a data frame?"
objectives:
- "Be able to add and remove rows and columns."
- "Be able to remove rows with `NA` values."
- "Be able to append two data frames"
- "Be able to articulate what a `factor` is and how to convert between `factor` and `character`."
- "Be able to find basic properties of a data frames including size, class or type of the columns, names, and first few rows."
keypoints:
- "Use `cbind()` to add a new column to a data frame."
- "Use `rbind()` to add a new row to a data frame."
- "Remove rows from a data frame."
- "Use `na.omit()` to remove rows from a data frame with `NA` values."
- "Use `levels()` and `as.character()` to explore and manipulate factors"
- "Use `str()`, `nrow()`, `ncol()`, `dim()`, `colnames()`, `rownames()`, `head()` and `typeof()` to understand structure of the data frame"
- "Read in a csv file using `read.csv()`"
- "Understand `length()` of a data frame"
source: Rmd
---




At this point, you've see it all - in the last lesson, we toured all the basic
data types and data structures in R. Everything you do will be a manipulation of
those tools. But a whole lot of the time, the star of the show is going to be
the data frame - the table that we created by loading information from a csv file. In this lesson, we'll learn a few more things
about working with data frames.

## Adding columns and rows in data frame

We learned last time that the columns in a data frame were vectors, so that our
data are consistent in type throughout the column. As such, if we want to add a
new column, we need to start by making a new vector:




~~~
age <- c(2, 3, 5)
cats
~~~
{: .language-r}



~~~
    coat weight likes_string
1 calico    2.1            1
2  black    5.0            0
3  tabby    3.2            1
~~~
{: .output}

We can then add this as a column via:


~~~
cbind(cats, age)
~~~
{: .language-r}



~~~
    coat weight likes_string age
1 calico    2.1            1   2
2  black    5.0            0   3
3  tabby    3.2            1   5
~~~
{: .output}
Note that if we tried to add a vector of ages with a different number of entries than the number of rows in the dataframe, it would fail:

~~~
age <- c(2, 3, 5, 12)
cbind(cats, age)
~~~
{: .language-r}



~~~
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4
~~~
{: .error}



~~~
age <- c(2, 3)
cbind(cats, age)
~~~
{: .language-r}



~~~
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 2
~~~
{: .error}

Why didn't this work? Of course, R wants to see one element in our new column
for every row in the table:


~~~
nrow(cats)
~~~
{: .language-r}



~~~
[1] 3
~~~
{: .output}



~~~
length(age)
~~~
{: .language-r}



~~~
[1] 2
~~~
{: .output}

So for it to work we have to have `nrow(cats)` = `length(age)`. Let's store it into cats and overwite the contents of that data frame.


~~~
age <- c(2, 3, 5)
cats <- cbind(cats, age)
~~~
{: .language-r}

Now how about adding rows - in this case, we saw last time that the rows of a
data frame are made of lists:


~~~
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
~~~
{: .language-r}



~~~
Warning in `[<-.factor`(`*tmp*`, ri, value = "tortoiseshell"): invalid
factor level, NA generated
~~~
{: .error}

## Factors

Another thing to look out for has emerged - when R creates a factor, it only
allows whatever is originally there when our data was first loaded, which was
'black', 'calico' and 'tabby' in our case. Anything new that doesn't fit into
one of these categories is rejected as nonsense (becomes NA).

The warning is telling us that we unsuccessfully added 'tortoiseshell' to our
*coat* factor, but 3.3 (a numeric), TRUE (a logical), and 9 (a numeric) were
successfully added to *weight*, *likes_string*, and *age*, respectively, since
those values are not factors. To successfully add a cat with a
'tortoiseshell' *coat*, explicitly add 'tortoiseshell' as a *level* in the factor:


~~~
levels(cats$coat)
~~~
{: .language-r}



~~~
[1] "black"  "calico" "tabby" 
~~~
{: .output}



~~~
levels(cats$coat) <- c(levels(cats$coat), 'tortoiseshell')
cats <- rbind(cats, list("tortoiseshell", 3.3, TRUE, 9))
~~~
{: .language-r}

Alternatively, we can change a factor column to a character vector; we lose the
handy categories of the factor, but can subsequently add any word we want to the
column without babysitting the factor levels:


~~~
str(cats)
~~~
{: .language-r}



~~~
'data.frame':	5 obs. of  4 variables:
 $ coat        : Factor w/ 4 levels "black","calico",..: 2 1 3 NA 4
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: int  1 0 1 1 1
 $ age         : num  2 3 5 9 9
~~~
{: .output}



~~~
cats$coat <- as.character(cats$coat)
str(cats)
~~~
{: .language-r}



~~~
'data.frame':	5 obs. of  4 variables:
 $ coat        : chr  "calico" "black" "tabby" NA ...
 $ weight      : num  2.1 5 3.2 3.3 3.3
 $ likes_string: int  1 0 1 1 1
 $ age         : num  2 3 5 9 9
~~~
{: .output}

> ## Challenge 1
> Let's imagine that, like dogs, 1 human year is equivalent to 7 cat years. (The Purina company uses a [more sophisticated alogrithm](https://www.purina.co.uk/cats/key-life-stages/ageing/cats-age-in-human-years)). 
> 1. Create a vector called `human.age` by multiplying `cats$age` by 7.
> 2. Convert `human.age` to a factor.
> 3. Convert `human.age` back to a numeric vector using the `as.numeric()` function. Now divide it by 7 to get back the original ages. Explain what happened.
>
> > ## Solution to Challenge 1
> > 1. `human.age <- cats$age * 7`
> > 2. `human.age <- factor(human.age)`. `as.factor(human.age)` works just as well.
> > 3. `as.numeric(human.age)` yields `1 2 3 4 4` because factors are stored as integers (here, 1:4), each of which is associated with a label (here, 28, 35, 56, and 63). Converting the factor to a numeric vector gives us the underlying integers, not the labels. If we want the original numbers, we need to convert `human.age` to a character vector and then to a numeric vector (why does this work?). This comes up in real life when we accidentally include a character somewhere in a column of a .csv file that is supposed to only contain numbers, and forget to set `stringsAsFactors=FALSE` when we read in the data.
> {: .solution}
{: .challenge}

## Removing rows

We now know how to add rows and columns to our data frame in R - but in our
first attempt to add a 'tortoiseshell' cat to the data frame we've accidentally
added a garbage row:


~~~
cats
~~~
{: .language-r}



~~~
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
4          <NA>    3.3            1   9
5 tortoiseshell    3.3            1   9
~~~
{: .output}

We can ask for a data frame minus this offending row:


~~~
cats[-4,]
~~~
{: .language-r}



~~~
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
5 tortoiseshell    3.3            1   9
~~~
{: .output}

Notice the comma with nothing after it to indicate we want to drop the entire fourth row.

Note: We could also remove both new rows at once by putting the row numbers
inside of a vector: `cats[c(-4,-5),]`

Alternatively, we can drop all rows with `NA` values:


~~~
na.omit(cats)
~~~
{: .language-r}



~~~
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
5 tortoiseshell    3.3            1   9
~~~
{: .output}

Let's reassign the output to `cats`, so that our changes will be permanent:


~~~
cats <- na.omit(cats)
~~~
{: .language-r}

## Appending to a data frame

The key to remember when adding data to a data frame is that *columns are
vectors or factors, and rows are lists.* We can also glue two data frames
together with `rbind`:


~~~
cats <- rbind(cats, cats)
cats
~~~
{: .language-r}



~~~
            coat weight likes_string age
1         calico    2.1            1   2
2          black    5.0            0   3
3          tabby    3.2            1   5
5  tortoiseshell    3.3            1   9
11        calico    2.1            1   2
21         black    5.0            0   3
31         tabby    3.2            1   5
51 tortoiseshell    3.3            1   9
~~~
{: .output}
But now the row names are unnecessarily complicated. We can remove the rownames,
and R will automatically re-name them sequentially:


~~~
rownames(cats) <- NULL
cats
~~~
{: .language-r}



~~~
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
4 tortoiseshell    3.3            1   9
5        calico    2.1            1   2
6         black    5.0            0   3
7         tabby    3.2            1   5
8 tortoiseshell    3.3            1   9
~~~
{: .output}

> ## Challenge 2
>
> You can create a new data frame right from within R with the following syntax:
> 
> ~~~
> df <- data.frame(id = c('a', 'b', 'c'),
>                  x = 1:3,
>                  y = c(TRUE, TRUE, FALSE),
>                  stringsAsFactors = FALSE)
> ~~~
> {: .language-r}
> Make a data frame that holds the following information for yourself:
>
> - first name
> - last name
> - lucky number
>
> Then use `rbind` to add an entry for the people sitting beside you.
> Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"
>
> > ## Solution to Challenge 2
> > 
> > ~~~
> > df <- data.frame(first = c('Grace'),
> >                  last = c('Hopper'),
> >                  lucky_number = c(0),
> >                  stringsAsFactors = FALSE)
> > df <- rbind(df, list('Marie', 'Curie', 238) )
> > df <- cbind(df, coffeetime = c(TRUE,TRUE))
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

## Realistic example
So far, you've seen the basics of manipulating data frames with our cat data;
now, let's use those skills to digest a more realistic dataset. Let's read in the
gapminder dataset that we downloaded previously:


~~~
gapminder <- read.csv("data/gapminder-FiveYearData.csv")
~~~
{: .language-r}

> ## Miscellaneous Tips
>
> * Another type of file you might encounter are tab-separated value files (.tsv). To specify a tab as a separator, use `"\\t"` or `read.delim()`.
>
> * Files can also be downloaded directly from the Internet into a local
> folder of your choice onto your computer using the `download.file` function.
> The `read.csv` function can then be executed to read the downloaded file from the download location, for example,
> 
> ~~~
> download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
> gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> ~~~
> {: .language-r}
>
> * Alternatively, you can also read in files directly into R from the Internet by replacing the file paths with a web address in `read.csv`. One should note that in doing this no local copy of the csv file is first saved onto your computer. For example,
> 
> ~~~
> gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv")
> ~~~
> {: .language-r}
>
> * You can read directly from excel spreadsheets without
> converting them to plain text first by using the [readxl](https://cran.r-project.org/web/packages/readxl/index.html) package.
{: .callout}

Let's investigate gapminder a bit; the first thing we should always do is check
out what the data looks like with `str`:


~~~
str(gapminder)
~~~
{: .language-r}



~~~
'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
~~~
{: .output}

We can also examine individual columns of the data frame with our `typeof` function:


~~~
typeof(gapminder$year)
~~~
{: .language-r}



~~~
[1] "integer"
~~~
{: .output}



~~~
typeof(gapminder$country)
~~~
{: .language-r}



~~~
[1] "integer"
~~~
{: .output}



~~~
str(gapminder$country)
~~~
{: .language-r}



~~~
 Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
~~~
{: .output}

We can also interrogate the data frame for information about its dimensions;
remembering that `str(gapminder)` said there were 1704 observations of 6
variables in gapminder, what do you think the following will produce, and why?


~~~
length(gapminder)
~~~
{: .language-r}



~~~
[1] 6
~~~
{: .output}

A fair guess would have been to say that the length of a data frame would be the
number of rows it has (1704), but this is not the case; remember, a data frame
is a *list of vectors and factors*:


~~~
typeof(gapminder)
~~~
{: .language-r}



~~~
[1] "list"
~~~
{: .output}

When `length` gave us 6, it's because gapminder is built out of a list of 6
columns. To get the number of rows and columns in our dataset, try:


~~~
nrow(gapminder)
~~~
{: .language-r}



~~~
[1] 1704
~~~
{: .output}



~~~
ncol(gapminder)
~~~
{: .language-r}



~~~
[1] 6
~~~
{: .output}

Or, both at once:


~~~
dim(gapminder)
~~~
{: .language-r}



~~~
[1] 1704    6
~~~
{: .output}

We'll also likely want to know what the titles of all the columns are, so we can
ask for them later:


~~~
colnames(gapminder)
~~~
{: .language-r}



~~~
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"
~~~
{: .output}

At this stage, it's important to ask ourselves if the structure R is reporting
matches our intuition or expectations; do the basic data types reported for each
column make sense? If not, we need to sort any problems out now before they turn
into bad surprises down the road, using what we've learned about how R
interprets data, and the importance of *strict consistency* in how we record our
data.

Once we're happy that the data types and structures seem reasonable, it's time
to start digging into our data proper. Check out the first few lines:


~~~
head(gapminder)
~~~
{: .language-r}



~~~
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
~~~
{: .output}

> ## Challenge 3
>
> It's good practice to also check the last few lines of your data and some in the middle. How would you do this?
>
> Searching for ones specifically in the middle isn't too hard but we could simply ask for a few lines at random. How would you code this?
>
> > ## Solution to Challenge 3
> > To check the last few lines it's relatively simple as R already has a function for this:
> > 
> > ~~~
> > tail(gapminder)
> > tail(gapminder, n = 15)
> > ~~~
> > {: .r}
> > 
> > What about a few arbitrary rows just for sanity (or insanity depending on your view)?
> > ## Tip: There are several ways to achieve this.
> > The solution here presents one form using nested functions. i.e. a function passed as an argument to another function. This might sound like a new concept but you are already using it in fact.
> > Remember my_dataframe[rows, cols] will print to screen your data frame with the number of rows and columns you asked for (although you might have asked for a range or named columns for example). How would you get the last row if you don't know how many rows your data frame has? R has a function for this. What about getting a (pseudorandom) sample? R also has a function for this.
> > ~~~
> > gapminder[sample(nrow(gapminder), 5), ]
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}


To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later.

> ## Challenge 4
>
> Go to file -> new file -> R script, and write an R script
> to load in the gapminder dataset. Put it in the `scripts/`
> directory and add it to version control.
>
> Run the script using the `source` function, using the file path
> as its argument (or by pressing the "source" button in RStudio).
>
> > ## Solution to Challenge 4
> > The contents of `scripts/load-gapminder.R`:
> > 
> > ~~~
> > download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder-FiveYearData.csv", destfile = "data/gapminder-FiveYearData.csv")
> > gapminder <- read.csv(file = "data/gapminder-FiveYearData.csv")
> > ~~~
> > {: .language-r}
> > To run the script and load the data into the `gapminder` variable:
> > 
> > ~~~
> > source(file = "scripts/load-gapminder.R")
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

> ## Challenge 5
>
> Read the output of `str(gapminder)` again;
> this time, use what you've learned about factors, lists and vectors,
> as well as the output of functions like `colnames` and `dim`
> to explain what everything that `str` prints out for gapminder means.
> If there are any parts you can't interpret, discuss with your neighbors!
>
> > ## Solution to Challenge 5
> >
> > The object `gapminder` is a data frame with columns
> > - `country` and `continent` are factors.
> > - `year` is an integer vector.
> > - `pop`, `lifeExp`, and `gdpPercap` are numeric vectors.
> >
> {: .solution}
{: .challenge}
