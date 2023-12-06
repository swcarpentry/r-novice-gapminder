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

```{r, include=FALSE}
```

At this point, you've seen it all: in the last lesson, we toured all the basic
data types and data structures in R. Everything you do will be a manipulation of
those tools. But most of the time, the star of the show is the data frame—the table that we created by loading information from a csv file. In this lesson, we'll learn a few more things
about working with data frames.

## Adding columns and rows in data frames

We already learned that the columns of a data frame are vectors, so that our
data are consistent in type throughout the columns. As such, if we want to add a
new column, we can start by making a new vector:

```{r, echo=FALSE}
cats <- read.csv("data/feline-data.csv")
```

```{r}
age <- c(2, 3, 5)
cats
```

We can then add this as a column via:

```{r}
cbind(cats, age)
```

Note that if we tried to add a vector of ages with a different number of entries than the number of rows in the data frame, it would fail:

```{r, error=TRUE}
age <- c(2, 3, 5, 12)
cbind(cats, age)

age <- c(2, 3)
cbind(cats, age)
```

Why didn't this work? Of course, R wants to see one element in our new column
for every row in the table:

```{r}
nrow(cats)
length(age)
```

So for it to work we need to have `nrow(cats)` = `length(age)`. Let's overwrite the content of cats with our new data frame.

```{r}
age <- c(2, 3, 5)
cats <- cbind(cats, age)
```

Now how about adding rows? We already know that the rows of a
data frame are lists:

```{r}
newRow <- list("tortoiseshell", 3.3, TRUE, 9)
cats <- rbind(cats, newRow)
```

Let's confirm that our new row was added correctly. 

```{r}
cats
```


## Removing rows

We now know how to add rows and columns to our data frame in R. Now let's learn to remove rows. 

```{r}
cats
```

We can ask for a data frame minus the last row:

```{r}
cats[-4, ]
```

Notice the comma with nothing after it to indicate that we want to drop the entire fourth row.

Note: we could also remove several rows at once by putting the row numbers
inside of a vector, for example: `cats[c(-3,-4), ]`


## Removing columns

We can also remove columns in our data frame. What if we want to remove the column "age". We can remove it in two ways, by variable number or by index.

```{r}
cats[,-4]
```

Notice the comma with nothing before it, indicating we want to keep all of the rows.

Alternatively, we can drop the column by using the index name and the `%in%` operator. The `%in%` operator goes through each element of its left argument, in this case the names of `cats`, and asks, "Does this element occur in the second argument?"

```{r}
drop <- names(cats) %in% c("age")
cats[,!drop]
```

We will cover subsetting with logical operators like `%in%` in more detail in the next episode. See the section [Subsetting through other logical operations](06-data-subsetting.Rmd)

## Appending to a data frame

The key to remember when adding data to a data frame is that *columns are
vectors and rows are lists.* We can also glue two data frames
together with `rbind`:

```{r}
cats <- rbind(cats, cats)
cats
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

You can create a new data frame right from within R with the following syntax:

```{r}
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

```{r}
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

```{r}
gapminder <- read.csv("data/gapminder_data.csv")
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Miscellaneous Tips

- Another type of file you might encounter are tab-separated value files (.tsv). To specify a tab as a separator, use `"\\t"` or `read.delim()`.

- Files can also be downloaded directly from the Internet into a local
  folder of your choice onto your computer using the `download.file` function.
  The `read.csv` function can then be executed to read the downloaded file from the download location, for example,

```{r, eval=FALSE, echo=TRUE}
download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv", destfile = "data/gapminder_data.csv")
gapminder <- read.csv("data/gapminder_data.csv")
```

- Alternatively, you can also read in files directly into R from the Internet by replacing the file paths with a web address in `read.csv`. One should note that in doing this no local copy of the csv file is first saved onto your computer. For example,

```{r, eval=FALSE, echo=TRUE}
gapminder <- read.csv("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv")
```

- You can read directly from excel spreadsheets without
  converting them to plain text first by using the [readxl](https://cran.r-project.org/package=readxl) package.
  
- The argument "stringsAsFactors" can be useful to tell R how to read strings either as factors or as character strings. In R versions after 4.0, all strings are read-in as characters by default, but in earlier versions of R, strings are read-in as factors by default. For more information, see the call-out in [the previous episode](https://swcarpentry.github.io/r-novice-gapminder/04-data-structures-part1.html#check-your-data-for-factors). 
  
::::::::::::::::::::::::::::::::::::::::::::::::::

Let's investigate gapminder a bit; the first thing we should always do is check
out what the data looks like with `str`:

```{r}
str(gapminder)
```

An additional method for examining the structure of gapminder is to use the `summary` function. This function can be used on various objects in R. For data frames, `summary` yields a numeric, tabular, or descriptive summary of each column. Numeric or integer columns are described by the descriptive statistics (quartiles and mean), and character columns by its length, class, and mode.

```{r}
summary(gapminder)
```

Along with the `str` and `summary` functions, we can examine individual columns of the data frame with our `typeof` function:

```{r}
typeof(gapminder$year)
typeof(gapminder$country)
str(gapminder$country)
```

We can also interrogate the data frame for information about its dimensions;
remembering that `str(gapminder)` said there were 1704 observations of 6
variables in gapminder, what do you think the following will produce, and why?

```{r}
length(gapminder)
```

A fair guess would have been to say that the length of a data frame would be the
number of rows it has (1704), but this is not the case; remember, a data frame
is a *list of vectors and factors*:

```{r}
typeof(gapminder)
```

When `length` gave us 6, it's because gapminder is built out of a list of 6
columns. To get the number of rows and columns in our dataset, try:

```{r}
nrow(gapminder)
ncol(gapminder)
```

Or, both at once:

```{r}
dim(gapminder)
```

We'll also likely want to know what the titles of all the columns are, so we can
ask for them later:

```{r}
colnames(gapminder)
```

At this stage, it's important to ask ourselves if the structure R is reporting
matches our intuition or expectations; do the basic data types reported for each
column make sense? If not, we need to sort any problems out now before they turn
into bad surprises down the road, using what we've learned about how R
interprets data, and the importance of *strict consistency* in how we record our
data.

Once we're happy that the data types and structures seem reasonable, it's time
to start digging into our data proper. Check out the first few lines:

```{r}
head(gapminder)
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

```{r, eval=FALSE}
download.file("https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv", destfile = "data/gapminder_data.csv")
gapminder <- read.csv(file = "data/gapminder_data.csv")
```

To run the script and load the data into the `gapminder` variable:

```{r, eval=FALSE}
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


