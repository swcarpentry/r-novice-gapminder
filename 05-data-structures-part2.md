---
title: Exploring Data Frames
teaching: 20
exercises: 10
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Add and remove rows or columns.
- Append two data frames.
- Display basic properties of data frames including size and class of the columns, names, and first few rows.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I manipulate a data frame?

::::::::::::::::::::::::::::::::::::::::::::::::::



At this point, you've seen it all: in the last lesson, we toured all the basic
data types and data structures in R. Everything you do will be a manipulation of
those tools. But most of the time, the star of the show is the data frame—the table that we created by loading information from a csv file. In this lesson, we'll learn a few more things
about working with data frames.

## Adding columns and rows in data frames

We already learned that the columns of a data frame are vectors, so that our
data are consistent in type throughout the columns. As such, if we want to add a
new column, we can start by making a new vector:




```r
age <- c(2, 3, 5)
cats
```

```{.output}
    coat weight likes_string
1 calico    2.1            1
2  black    5.0            0
3  tabby    3.2            1
```

We can then add this as a column via:


```r
cbind(cats, age)
```

```{.output}
    coat weight likes_string age
1 calico    2.1            1   2
2  black    5.0            0   3
3  tabby    3.2            1   5
```

Note that if we tried to add a vector of ages with a different number of entries than the number of rows in the data frame, it would fail:


```r
age <- c(2, 3, 5, 12)
cbind(cats, age)
```

```{.error}
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 4
```

```r
age <- c(2, 3)
cbind(cats, age)
```

```{.error}
Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 3, 2
```

Why didn't this work? Of course, R wants to see one element in our new column
for every row in the table:


```r
nrow(cats)
```

```{.output}
[1] 3
```

```r
length(age)
```

```{.output}
[1] 2
```

So for it to work we need to have `nrow(cats)` = `length(age)`. Let's overwrite the content of cats with our new data frame.


```r
age <- c(2, 3, 5)
cats <- cbind(cats, age)
```

Now how about adding rows? We already know that the rows of a
data frame are lists:


```r
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
```

Let's confirm that our new row was added correctly. 


```r
cats
```

```{.output}
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
4 tortoiseshell    3.3            1   9
```


## Removing rows

We now know how to add rows and columns to our data frame in R. Now let's learn to remove rows. 


```r
cats
```

```{.output}
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
4 tortoiseshell    3.3            1   9
```

We can ask for a data frame minus the last row:


```r
cats[-4, ]
```

```{.output}
    coat weight likes_string age
1 calico    2.1            1   2
2  black    5.0            0   3
3  tabby    3.2            1   5
```

Notice the comma with nothing after it to indicate that we want to drop the entire fourth row.

Note: we could also remove several rows at once by putting the row numbers
inside of a vector, for example: `cats[c(-3,-4), ]`


## Removing columns

We can also remove columns in our data frame. What if we want to remove the column "age". We can remove it in two ways, by variable number or by index.


```r
cats[,-4]
```

```{.output}
           coat weight likes_string
1        calico    2.1            1
2         black    5.0            0
3         tabby    3.2            1
4 tortoiseshell    3.3            1
```

Notice the comma with nothing before it, indicating we want to keep all of the rows.

Alternatively, we can drop the column by using the index name and the `%in%` operator. The `%in%` operator goes through each element of its left argument, in this case the names of `cats`, and asks, "Does this element occur in the second argument?"


```r
drop <- names(cats) %in% c("age")
cats[,!drop]
```

```{.output}
           coat weight likes_string
1        calico    2.1            1
2         black    5.0            0
3         tabby    3.2            1
4 tortoiseshell    3.3            1
```

We will cover subsetting with logical operators like `%in%` in more detail in the next episode. See the section [Subsetting through other logical operations](06-data-subsetting.Rmd)

## Appending to a data frame

The key to remember when adding data to a data frame is that *columns are
vectors and rows are lists.* We can also glue two data frames
together with `rbind`:


```r
cats <- rbind(cats, cats)
cats
```

```{.output}
           coat weight likes_string age
1        calico    2.1            1   2
2         black    5.0            0   3
3         tabby    3.2            1   5
4 tortoiseshell    3.3            1   9
5        calico    2.1            1   2
6         black    5.0            0   3
7         tabby    3.2            1   5
8 tortoiseshell    3.3            1   9
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

You can create a new data frame right from within R with the following syntax:


```r
df <- data.frame(id = c("a", "b", "c"),
                 x = 1:3,
                 y = c(TRUE, TRUE, FALSE))
```

Make a data frame that holds the following information for yourself:

- first name
- last name
- lucky number

Then use `rbind` to add an entry for the people sitting beside you.
Finally, use `cbind` to add a column with each person's answer to the question, "Is it time for coffee break?"

:::::::::::::::  solution

## Solution to Challenge 1


```r
df <- data.frame(first = c("Grace"),
                 last = c("Hopper"),
                 lucky_number = c(0))
df <- rbind(df, list("Marie", "Curie", 238) )
df <- cbind(df, coffeetime = c(TRUE,TRUE))
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Realistic example

So far, you have seen the basics of manipulating data frames with our cat data;
now let's use those skills to digest a more realistic dataset. Let's read in the
`gapminder` dataset that we downloaded previously:


```r
gapminder <- read.csv("data/gapminder_data.csv")
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Miscellaneous Tips

- Another type of file you might encounter are tab-separated value files (.tsv). To specify a tab as a separator, use `"\\t"` or `read.delim()`.

- Files can also be downloaded directly from the Internet into a local
  folder of your choice onto your computer using the `download.file` function.
  The `read.csv` function can then be executed to read the downloaded file from the download location, for example,


```r
download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv", destfile = "data/gapminder_data.csv")
gapminder <- read.csv("data/gapminder_data.csv")
```

- Alternatively, you can also read in files directly into R from the Internet by replacing the file paths with a web address in `read.csv`. One should note that in doing this no local copy of the csv file is first saved onto your computer. For example,


```r
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv")
```

- You can read directly from excel spreadsheets without
  converting them to plain text first by using the [readxl](https://cran.r-project.org/package=readxl) package.
  
- The argument "stringsAsFactors" can be useful to tell R how to read strings either as factors or as character strings. In R versions after 4.0, all strings are read-in as characters by default, but in earlier versions of R, strings are read-in as factors by default. For more information, see the call-out in [the previous episode](https://swcarpentry.github.io/r-novice-gapminder/04-data-structures-part1.html#check-your-data-for-factors). 
  
::::::::::::::::::::::::::::::::::::::::::::::::::

Let's investigate gapminder a bit; the first thing we should always do is check
out what the data looks like with `str`:


```r
str(gapminder)
```

```{.output}
'data.frame':	1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
```

An additional method for examining the structure of gapminder is to use the `summary` function. This function can be used on various objects in R. For data frames, `summary` yields a numeric, tabular, or descriptive summary of each column. Numeric or integer columns are described by the descriptive statistics (quartiles and mean), and character columns by its length, class, and mode.


```r
summary(gapminder)
```

```{.output}
   country               year           pop             continent        
 Length:1704        Min.   :1952   Min.   :6.001e+04   Length:1704       
 Class :character   1st Qu.:1966   1st Qu.:2.794e+06   Class :character  
 Mode  :character   Median :1980   Median :7.024e+06   Mode  :character  
                    Mean   :1980   Mean   :2.960e+07                     
                    3rd Qu.:1993   3rd Qu.:1.959e+07                     
                    Max.   :2007   Max.   :1.319e+09                     
    lifeExp        gdpPercap       
 Min.   :23.60   Min.   :   241.2  
 1st Qu.:48.20   1st Qu.:  1202.1  
 Median :60.71   Median :  3531.8  
 Mean   :59.47   Mean   :  7215.3  
 3rd Qu.:70.85   3rd Qu.:  9325.5  
 Max.   :82.60   Max.   :113523.1  
```

Along with the `str` and `summary` functions, we can examine individual columns of the data frame with our `typeof` function:


```r
typeof(gapminder$year)
```

```{.output}
[1] "integer"
```

```r
typeof(gapminder$country)
```

```{.output}
[1] "character"
```

```r
str(gapminder$country)
```

```{.output}
 chr [1:1704] "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
```

We can also interrogate the data frame for information about its dimensions;
remembering that `str(gapminder)` said there were 1704 observations of 6
variables in gapminder, what do you think the following will produce, and why?


```r
length(gapminder)
```

```{.output}
[1] 6
```

A fair guess would have been to say that the length of a data frame would be the
number of rows it has (1704), but this is not the case; remember, a data frame
is a *list of vectors and factors*:


```r
typeof(gapminder)
```

```{.output}
[1] "list"
```

When `length` gave us 6, it's because gapminder is built out of a list of 6
columns. To get the number of rows and columns in our dataset, try:


```r
nrow(gapminder)
```

```{.output}
[1] 1704
```

```r
ncol(gapminder)
```

```{.output}
[1] 6
```

Or, both at once:


```r
dim(gapminder)
```

```{.output}
[1] 1704    6
```

We'll also likely want to know what the titles of all the columns are, so we can
ask for them later:


```r
colnames(gapminder)
```

```{.output}
[1] "country"   "year"      "pop"       "continent" "lifeExp"   "gdpPercap"
```

At this stage, it's important to ask ourselves if the structure R is reporting
matches our intuition or expectations; do the basic data types reported for each
column make sense? If not, we need to sort any problems out now before they turn
into bad surprises down the road, using what we've learned about how R
interprets data, and the importance of *strict consistency* in how we record our
data.

Once we're happy that the data types and structures seem reasonable, it's time
to start digging into our data proper. Check out the first few lines:


```r
head(gapminder)
```

```{.output}
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

It's good practice to also check the last few lines of your data and some in the middle. How would you do this?

Searching for ones specifically in the middle isn't too hard, but we could ask for a few lines at random. How would you code this?

:::::::::::::::  solution

## Solution to Challenge 2

To check the last few lines it's relatively simple as R already has a function for this:

```r
tail(gapminder)
tail(gapminder, n = 15)
```

What about a few arbitrary rows just in case something is odd in the middle?

## Tip: There are several ways to achieve this.

The solution here presents one form of using nested functions, i.e. a function passed as an argument to another function. This might sound like a new concept, but you are already using it!
Remember my\_dataframe[rows, cols] will print to screen your data frame with the number of rows and columns you asked for (although you might have asked for a range or named columns for example). How would you get the last row if you don't know how many rows your data frame has? R has a function for this. What about getting a (pseudorandom) sample? R also has a function for this.

```r
gapminder[sample(nrow(gapminder), 5), ]
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

To make sure our analysis is reproducible, we should put the code
into a script file so we can come back to it later.

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Go to file -> new file -> R script, and write an R script
to load in the gapminder dataset. Put it in the `scripts/`
directory and add it to version control.

Run the script using the `source` function, using the file path
as its argument (or by pressing the "source" button in RStudio).

:::::::::::::::  solution

## Solution to Challenge 3

The `source` function can be used to use a script within a script.
Assume you would like to load the same type of file over and over
again and therefore you need to specify the arguments to fit the
needs of your file. Instead of writing the necessary argument again
and again you could just write it once and save it as a script. Then,
you can use `source("Your_Script_containing_the_load_function")` in a new
script to use the function of that script without writing everything again.
Check out `?source` to find out more.


```r
download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv", destfile = "data/gapminder_data.csv")
gapminder <- read.csv(file = "data/gapminder_data.csv")
```

To run the script and load the data into the `gapminder` variable:


```r
source(file = "scripts/load-gapminder.R")
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4

Read the output of `str(gapminder)` again;
this time, use what you've learned about lists and vectors,
as well as the output of functions like `colnames` and `dim`
to explain what everything that `str` prints out for gapminder means.
If there are any parts you can't interpret, discuss with your neighbors!

:::::::::::::::  solution

## Solution to Challenge 4

The object `gapminder` is a data frame with columns

- `country` and `continent` are character strings.
- `year` is an integer vector.
- `pop`, `lifeExp`, and `gdpPercap` are numeric vectors.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `cbind()` to add a new column to a data frame.
- Use `rbind()` to add a new row to a data frame.
- Remove rows from a data frame.
- Use `str()`, `summary()`, `nrow()`, `ncol()`, `dim()`, `colnames()`, `head()`, and `typeof()` to understand the structure of a data frame.
- Read in a csv file using `read.csv()`.
- Understand what `length()` of a data frame represents.

::::::::::::::::::::::::::::::::::::::::::::::::::


