---
layout: page
title: R for reproducible scientific analysis
subtitle: Dataframe manipulation with dplyr
minutes: 90
---



> ## Learning Objectives {.objectives}
>
> * To be able to use the 6 main dataframe manipulation 'verbs' with pipes in `dplyr`
>

Manipulation of dataframes means many things to many researchers, we often select certain observations (rows) or variables (columns), we often group the data by a certain variable(s), or we even calculate summary statistics. We can do these operations using the normal base R operations:


~~~{.r}
mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])
~~~



~~~{.output}
[1] 2193.755

~~~



~~~{.r}
mean(gapminder[gapminder$continent == "Americas", "gdpPercap"])
~~~



~~~{.output}
[1] 7136.11

~~~



~~~{.r}
mean(gapminder[gapminder$continent == "Asia", "gdpPercap"])
~~~



~~~{.output}
[1] 7902.15

~~~

But this isn't very *nice* because there is a fair bit of repetition. Repeating yourself will cost you time, both now and later, and potentially introduce some nasty bugs.

## The `dplyr` package

Luckily, the [`dplyr`](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) package provides a number of very useful functions for manipulating dataframes in a way that will reduce the above repetition, reduce the probability of making errors, and probably even save you some typing. As an added bonus, you might even find the `dplyr` grammar easier to read.

Here we're going to cover 6 of the most commonly used functions as well as using pipes (`%>%`) to combine them. 

1. `select()`
2. `filter()`
3. `group_by()`
4. `summarize()`
5. `mutate()`

If you have have not installed this package earlier, please do so:


~~~{.r}
install.packages('dplyr')
~~~

Now let's load the package:


~~~{.r}
library(dplyr)
~~~

## Using select()

If, for example, we wanted to move forward with only a few of the variables in our dataframe we could use the `select()` function. This will keep only the variables you select.


~~~{.r}
year_country_gdp <- select(gapminder,year,country,gdpPercap)
~~~

<!--html_preserve--><div id="htmlwidget-3388" style="width:504px;height:504px;" class="grViz"></div>
<script type="application/json" data-for="htmlwidget-3388">{"x":{"diagram":"digraph html {\n    table1 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD PORT=\"f0\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD PORT=\"f1\" BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\n\n    table2 [shape=none, margin=0, label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD PORT=\"f0\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD PORT=\"f1\" BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n        </TR>\n    </TABLE>>];\n   \n    table1:f1 -> table2:f1 \n    table1:f0 -> table2:f0\n\n    subgraph {\n        rank = same; table1; table2;\n    }\n    \n\n    labelloc=\"t\";\n    label=\"select(data.frame,a,c)\";\n}\n","config":{"engine":"dot","options":null}},"evals":[]}</script><!--/html_preserve-->

If we open up `year_country_gdp` we'll see that it only contains the year, country and gdpPercap. Above we used 'normal' grammar, but the strengths of `dplyr` lie in combining several functions using pipes. Since the pipes grammar is unlike anything we've seen in R before, let's repeat what we've done above using pipes.


~~~{.r}
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)
~~~

To help you understand why we wrote that in that way, let's walk through it step by step. First we summon the gapminder dataframe and pass it on, using the pipe symbol `%>%`, to the next step, which is the `select()` function. In this case we don't specify which data object we use in the `select()` function since in gets that from the previous pipe. **Fun Fact**: There is a good chance you have encountered pipes before in the shell. In R, a pipe symbol is `%>%` while in the shell it is `|` but the concept is the same!

## Using filter()

If we now wanted to move forward with the above, but only with European countries, we can combine `select` and `filter`


~~~{.r}
year_country_gdp_euro <- gapminder %>%
    filter(continent=="Europe") %>%
    select(year,country,gdpPercap)
~~~

> ## Challenge 1 {.challenge}
>
> Write a single command (which can span multiple lines and includes pipes) that will produce a dataframe that has the African values for `lifeExp`, `country` and `year`, but not for other Continents. 
>How many rows does your dataframe have and why?
>


As with last time, first we pass the gapminder dataframe to the `filter()` function, then we pass the filtered version of the gapminder dataframe to the `select()` function. **Note:** The order of operations is very important in this case. If we used 'select' first, filter would not be able to find the variable continent since we would have removed it in the previous step.

## Using group_by() and summarize()

Now, we were supposed to be reducing the error prone repetitiveness of what can be done with base R, but up to now we haven't done that since we would have to repeat the above for each continent. Instead of `filter()`, which will only pass observations that meet your criteria (in the above: `continent=="Europe"`), we can use `group_by()`, which will essentially use every unique criteria that you could have used in filter.


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



~~~{.r}
str(gapminder %>% group_by(continent))
~~~



~~~{.output}
Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
 - attr(*, "vars")=List of 1
  ..$ : symbol continent
 - attr(*, "drop")= logi TRUE
 - attr(*, "indices")=List of 5
  ..$ : int  24 25 26 27 28 29 30 31 32 33 ...
  ..$ : int  48 49 50 51 52 53 54 55 56 57 ...
  ..$ : int  0 1 2 3 4 5 6 7 8 9 ...
  ..$ : int  12 13 14 15 16 17 18 19 20 21 ...
  ..$ : int  60 61 62 63 64 65 66 67 68 69 ...
 - attr(*, "group_sizes")= int  624 300 396 360 24
 - attr(*, "biggest_group_size")= int 624
 - attr(*, "labels")='data.frame':	5 obs. of  1 variable:
  ..$ continent: Factor w/ 5 levels "Africa","Americas",..: 1 2 3 4 5
  ..- attr(*, "vars")=List of 1
  .. ..$ : symbol continent
  ..- attr(*, "drop")= logi TRUE

~~~
You will notice that the structure of the dataframe where we used `group_by()` (`grouped_df`) is not the same as the original `gapminder` (`data.frame`). A `grouped_df` can be thought of as a `list` where each item in the `list`is a `data.frame` which contains only the rows that correspond to the a particular value `continent` (at least in the example above).

<!--html_preserve--><div id="htmlwidget-1400" style="width:504px;height:504px;" class="grViz"></div>
<script type="application/json" data-for="htmlwidget-1400">{"x":{"diagram":"digraph html {\n    table1 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f0\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f1\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f2\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\ntable2 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f0\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n\n    </TABLE>>];\ntable3 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n\n        <TR>\n            <TD PORT=\"f1\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\ntable4 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f2\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\n\n   \n   \n    table1:f0 -> table2:f0 \n    table1:f1 -> table3:f1\n    table1:f2 -> table4:f2\n\n    subgraph {\n        rank = same; table1; table2; table3 ;table4;\n    }\n    subgraph {\n        table2\n        table3\n        table4\n    }\n\n    labelloc=\"t\";\n    label=\"gapminder %>% group_by(a)\";\n}\n","config":{"engine":"dot","options":null}},"evals":[]}</script><!--/html_preserve-->
## Using summarize()

The above was a bit on the uneventful side because `group_by()` much more exciting in conjunction with `summarize()`. This will allow use to create new variable(s) by using functions that repeat for each of the continent-specific data frames. That is to say, using the `group_by()` function, we split our original dataframe into multiple pieces, then we can run functions (e.g. `mean()` or `sd()`) within `summarize()`.


~~~{.r}
gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
~~~

<!--html_preserve--><div id="htmlwidget-6380" style="width:504px;height:504px;" class="grViz"></div>
<script type="application/json" data-for="htmlwidget-6380">{"x":{"diagram":"digraph html {\n    table1 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f0\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f1\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD PORT=\"f2\" BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\n\ntable2 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD PORT=\"f0\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f3\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n\n    </TABLE>>];\n\ntable3 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD PORT=\"f1\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f3\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\n\ntable4 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD PORT=\"f2\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">b</TD>\n            <TD BGCOLOR=\"#009999\" CELLPADDING=\"0\">c</TD>\n            <TD BGCOLOR=\"#00CC00\" CELLPADDING=\"0\">d</TD>\n        </TR>\n        \n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f3\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n            <TD BGCOLOR=\"#009999\"></TD>\n            <TD BGCOLOR=\"#00CC00\"></TD>\n        </TR>\n    </TABLE>>];\n\n    table5 [shape=none, margin=0,label=<\n    <TABLE BORDER=\"0\" CELLBORDER=\"0\" CELLSPACING=\"1\" CELLPADDING=\"6\">\n        <TR>\n            <TD BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">a</TD>\n            <TD BGCOLOR=\"#FF7400\" CELLPADDING=\"0\">mean_b</TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f0\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">1</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n        </TR>\n       \n        <TR>\n            <TD PORT=\"f1\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">2</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n        </TR>\n        \n        <TR>\n            <TD PORT=\"f2\" BGCOLOR=\"#FF0000\" CELLPADDING=\"0\">3</TD>\n            <TD BGCOLOR=\"#FF7400\"></TD>\n        </TR>\n        \n    </TABLE>>];\n   \n   \n    table1:f0 -> table2:f0 \n    table1:f1 -> table3:f1\n    table1:f2 -> table4:f2\n    table2:f3 -> table5:f0 \n    table3:f3 -> table5:f1\n    table4:f3 -> table5:f2\n    subgraph {\n        rank = same; table1; table2; table3 ; table4;\n    }\n    subgraph {\n        table2\n        table3\n        table4\n    }\n\n    labelloc=\"t\";\n    label=\"gapminder %>% group_by(a) %>% summarize(mean_b=mean(b))\";\n}\n","config":{"engine":"dot","options":null}},"evals":[]}</script><!--/html_preserve-->

That allowed us to calculate the mean gdpPercap for each continent, but it gets even better.

> ## Challenge 2 {.challenge}
>
> Calculate the average life expectancy per country. Which had the longest life expectancy and which had the shortest life expectancy?
>

The function `group_by()` allows us to group by multiple variables. Let's group by `year` and `continent`.



~~~{.r}
gdp_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap))
~~~

That is already quite powerful, but it gets even better! You're not limited to defining 1 new variable in `summarize()`.


~~~{.r}
gdp_pop_bycontinents_byyear <- gapminder %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop))
~~~

## Using mutate()

We can also create new variables prior to (or even after) summarizing information using `mutate()`.

~~~{.r}
gdp_pop_bycontinents_byyear <- gapminder %>%
    mutate(gdp_billion=gdpPercap*pop/10^9) %>%
    group_by(continent,year) %>%
    summarize(mean_gdpPercap=mean(gdpPercap),
              sd_gdpPercap=sd(gdpPercap),
              mean_pop=mean(pop),
              sd_pop=sd(pop),
              mean_pop=mean(pop),
              sd_pop=sd(pop))
~~~






> ## Advanced Challenge {.challenge}
> Calculate the average life expectancy in 2002 of 2 randomly selected countries for each continent. Then arrange the continent names in reverse order.
> **Hint:** Use the `dplyr` functions `arrange()` and `sample_n()`, they have similar syntax to other dplyr functions.
>

> ## Solution to Challenge 1 {.challenge}
>
>~~~{.r}
>year_country_lifeExp_Africa <- gapminder %>%
>                            filter(continent=="Africa") %>%
>                            select(year,country,lifeExp)
>~~~

> ## Solution to Challenge 2 {.challenge}
>
>~~~{.r}
>lifeExp_bycountry <- gapminder %>%
>    group_by(country) %>%
>    summarize(mean_lifeExp=mean(lifeExp))
>~~~

> ## Solution to Advanced Challenge {.challenge}
>
>~~~{.r}
>lifeExp_2countries_bycontinents <- gapminder %>% 
>    filter(year==2002) %>%
>    group_by(continent) %>%
>    sample_n(2) %>%
>    summarize(mean_lifeExp=mean(lifeExp)) %>%
>    arrange(desc(mean_lifeExp))
>~~~

## Other great resources
[Data Wrangling Cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
[Introduction to dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
