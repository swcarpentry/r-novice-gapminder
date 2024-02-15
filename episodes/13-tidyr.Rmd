---
title: Data Frame Manipulation with tidyr
teaching: 30
exercises: 15
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To understand the concepts of 'longer' and 'wider' data frame formats and be able to convert between them with `tidyr`.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I change the layout of a data frame?

::::::::::::::::::::::::::::::::::::::::::::::::::

```{r, include=FALSE}
gapminder <- read.csv("data/gapminder_data.csv", header = TRUE, stringsAsFactors = FALSE)
gap_wide <- read.csv("data/gapminder_wide.csv", header = TRUE, stringsAsFactors = FALSE)
```

Researchers often want to reshape their data frames from 'wide' to 'longer'
layouts, or vice-versa. The 'long' layout or format is where:

- each column is a variable
- each row is an observation

In the purely 'long' (or 'longest') format, you usually have 1 column for the observed variable and the other columns are ID variables.

For the 'wide' format each row is often a site/subject/patient and you have
multiple observation variables containing the same type of data. These can be
either repeated observations over time, or observation of multiple variables (or
a mix of both). You may find data input may be simpler or some other
applications may prefer the 'wide' format. However, many of `R`'s functions have
been designed assuming you have 'longer' formatted data. This tutorial will help you
efficiently transform your data shape regardless of original format.

![](fig/14-tidyr-fig1.png){alt='Diagram illustrating the difference between a wide versus long layout of a data frame'}

Long and wide data frame layouts mainly affect readability. For humans, the wide format is often more intuitive since we can often see more of the data on the screen due
to its shape. However, the long format is more machine readable and is closer
to the formatting of databases. The ID variables in our data frames are similar to
the fields in a database and observed variables are like the database values.

## Getting started

First install the packages if you haven't already done so (you probably
installed dplyr in the previous lesson):

```{r, eval=FALSE}
#install.packages("tidyr")
#install.packages("dplyr")
```

Load the packages

```{r, message=FALSE}
library("tidyr")
library("dplyr")
```

First, lets look at the structure of our original gapminder data frame:

```{r}
str(gapminder)
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Is gapminder a purely long, purely wide, or some intermediate format?

:::::::::::::::  solution

## Solution to Challenge 1

The original gapminder data.frame is in an intermediate format. It is not
purely long since it had multiple observation variables
(`pop`,`lifeExp`,`gdpPercap`).

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

Sometimes, as with the gapminder dataset, we have multiple types of observed
data. It is somewhere in between the purely 'long' and 'wide' data formats. We
have 3 "ID variables" (`continent`, `country`, `year`) and 3 "Observation
variables" (`pop`,`lifeExp`,`gdpPercap`). This intermediate format can be
preferred despite not having ALL observations in 1 column given that all 3
observation variables have different units. There are few operations that would
need us to make this data frame any longer (i.e. 4 ID variables and 1
Observation variable).

While using many of the functions in R, which are often vector based, you
usually do not want to do mathematical operations on values with different
units. For example, using the purely long format, a single mean for all of the
values of population, life expectancy, and GDP would not be meaningful since it
would return the mean of values with 3 incompatible units. The solution is that
we first manipulate the data either by grouping (see the lesson on `dplyr`), or
we change the structure of the data frame.  **Note:** Some plotting functions in
R actually work better in the wide format data.

## From wide to long format with pivot\_longer()

Until now, we've been using the nicely formatted original gapminder dataset, but
'real' data (i.e. our own research data) will never be so well organized. Here
let's start with the wide formatted version of the gapminder dataset.

> Download the wide version of the gapminder data from [this link to a csv file](data/gapminder_wide.csv)
> and save it in your data folder.

We'll load the data file and look at it. Note: we don't want our continent and
country columns to be factors, so we use the stringsAsFactors argument for
`read.csv()` to disable that.

```{r}
gap_wide <- read.csv("data/gapminder_wide.csv", stringsAsFactors = FALSE)
str(gap_wide)
```

![](fig/14-tidyr-fig2.png){alt='Diagram illustrating the wide format of the gapminder data frame'}

To change this very wide data frame layout back to our nice, intermediate (or longer) layout, we will use one of the two available `pivot`  functions from the `tidyr` package. To convert from wide to a longer format, we will use the `pivot_longer()` function. `pivot_longer()` makes datasets longer by increasing the number of rows and decreasing the number of columns, or 'lengthening' your observation variables into a single variable.

![](fig/14-tidyr-fig3.png){alt='Diagram illustrating how pivot longer reorganizes a data frame from a wide to long format'}

```{r}
gap_long <- gap_wide %>%
  pivot_longer(
    cols = c(starts_with('pop'), starts_with('lifeExp'), starts_with('gdpPercap')),
    names_to = "obstype_year", values_to = "obs_values"
  )
str(gap_long)
```

Here we have used piping syntax which is similar to what we were doing in the
previous lesson with dplyr. In fact, these are compatible and you can use a mix
of tidyr and dplyr functions by piping them together.

We first provide to `pivot_longer()` a vector of column names that will be
pivoted into longer format. We could type out all the observation variables, but
as in the `select()` function (see `dplyr` lesson), we can use the `starts_with()`
argument to select all variables that start with the desired character string.
`pivot_longer()` also allows the alternative syntax of using the `-` symbol to
identify which variables are not to be pivoted (i.e. ID variables).

The next arguments to `pivot_longer()` are `names_to` for naming the column that
will contain the new ID variable (`obstype_year`) and `values_to` for naming the
new amalgamated observation variable (`obs_value`). We supply these new column
names as strings.

![](fig/14-tidyr-fig4.png){alt='Diagram illustrating the long format of the gapminder data'}

```{r}
gap_long <- gap_wide %>%
  pivot_longer(
    cols = c(-continent, -country),
    names_to = "obstype_year", values_to = "obs_values"
  )
str(gap_long)
```

That may seem trivial with this particular data frame, but sometimes you have 1
ID variable and 40 observation variables with irregular variable names. The
flexibility is a huge time saver!

Now `obstype_year` actually contains 2 pieces of information, the observation
type (`pop`,`lifeExp`, or `gdpPercap`) and the `year`. We can use the
`separate()` function to split the character strings into multiple variables

```{r}
gap_long <- gap_long %>% separate(obstype_year, into = c('obs_type', 'year'), sep = "_")
gap_long$year <- as.integer(gap_long$year)
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Using `gap_long`, calculate the mean life expectancy, population, and gdpPercap for each continent.
**Hint:** use the `group_by()` and `summarize()` functions we learned in the `dplyr` lesson

:::::::::::::::  solution

## Solution to Challenge 2

```{r}
gap_long %>% group_by(continent, obs_type) %>%
   summarize(means=mean(obs_values))
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## From long to intermediate format with pivot\_wider()

It is always good to check work. So, let's use the second `pivot` function, `pivot_wider()`, to 'widen' our observation variables back out.  `pivot_wider()` is the opposite of `pivot_longer()`, making a dataset wider by increasing the number of columns and decreasing the number of rows. We can use `pivot_wider()` to pivot or reshape our `gap_long` to the original intermediate format or the widest format. Let's start with the intermediate format.

The `pivot_wider()` function takes `names_from` and `values_from` arguments.

To `names_from` we supply the column name whose contents will be pivoted into new
output columns in the widened data frame. The corresponding values will be added
from the column named in the `values_from` argument.

```{r}
gap_normal <- gap_long %>%
  pivot_wider(names_from = obs_type, values_from = obs_values)
dim(gap_normal)
dim(gapminder)
names(gap_normal)
names(gapminder)
```

Now we've got an intermediate data frame `gap_normal` with the same dimensions as
the original `gapminder`, but the order of the variables is different. Let's fix
that before checking if they are `all.equal()`.

```{r}
gap_normal <- gap_normal[, names(gapminder)]
all.equal(gap_normal, gapminder)
head(gap_normal)
head(gapminder)
```

We're almost there, the original was sorted by `country`, then
`year`.

```{r}
gap_normal <- gap_normal %>% arrange(country, year)
all.equal(gap_normal, gapminder)
```

That's great! We've gone from the longest format back to the intermediate and we
didn't introduce any errors in our code.

Now let's convert the long all the way back to the wide. In the wide format, we
will keep country and continent as ID variables and pivot the observations
across the 3 metrics (`pop`,`lifeExp`,`gdpPercap`) and time (`year`). First we
need to create appropriate labels for all our new variables (time\*metric
combinations) and we also need to unify our ID variables to simplify the process
of defining `gap_wide`.

```{r}
gap_temp <- gap_long %>% unite(var_ID, continent, country, sep = "_")
str(gap_temp)

gap_temp <- gap_long %>%
    unite(ID_var, continent, country, sep = "_") %>%
    unite(var_names, obs_type, year, sep = "_")
str(gap_temp)
```

Using `unite()` we now have a single ID variable which is a combination of
`continent`,`country`,and we have defined variable names. We're now ready to
pipe in `pivot_wider()`

```{r}
gap_wide_new <- gap_long %>%
  unite(ID_var, continent, country, sep = "_") %>%
  unite(var_names, obs_type, year, sep = "_") %>%
  pivot_wider(names_from = var_names, values_from = obs_values)
str(gap_wide_new)
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Take this 1 step further and create a `gap_ludicrously_wide` format data by pivoting over countries, year and the 3 metrics?
**Hint** this new data frame should only have 5 rows.

:::::::::::::::  solution

## Solution to Challenge 3

```{r}
gap_ludicrously_wide <- gap_long %>%
   unite(var_names, obs_type, year, country, sep = "_") %>%
   pivot_wider(names_from = var_names, values_from = obs_values)
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

Now we have a great 'wide' format data frame, but the `ID_var` could be more
usable, let's separate it into 2 variables with `separate()`

```{r}
gap_wide_betterID <- separate(gap_wide_new, ID_var, c("continent", "country"), sep="_")
gap_wide_betterID <- gap_long %>%
    unite(ID_var, continent, country, sep = "_") %>%
    unite(var_names, obs_type, year, sep = "_") %>%
    pivot_wider(names_from = var_names, values_from = obs_values) %>%
    separate(ID_var, c("continent","country"), sep = "_")
str(gap_wide_betterID)

all.equal(gap_wide, gap_wide_betterID)
```

There and back again!

## Other great resources

- [R for Data Science](https://r4ds.hadley.nz/) (online book)
- [Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) (pdf file)
- [Introduction to tidyr](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html) (online documentation)
- [Data wrangling with R and RStudio](https://www.rstudio.com/resources/webinars/data-wrangling-with-r-and-rstudio/) (online video)

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use the `tidyr` package to change the layout of data frames.
- Use `pivot_longer()` to go from wide to longer layout.
- Use `pivot_wider()` to go from long to wider layout.

::::::::::::::::::::::::::::::::::::::::::::::::::


