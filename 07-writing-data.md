---
layout: page
title: R for reproducible scientific analysis
subtitle: Reading data
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * To be able to write out data from R
>

### Writing data

At some point, you'll want to write out data from R.

We can use the `write.table` function for this, which is
very similar to `read.table` from before.

Let's create a data-cleaning script, for this analysis, we
only want to focus on the gapminder data for Australia:

~~~ {.r}
write.table(
  gapminder[gapminder$country == "Australia",],
  file="cleaned-data/gapminder-aus.csv",
  sep=","
)
~~~

Let's switch back to the shell to take a look at the data to make sure it looks
ok:

~~~ {.shell}
cd ~/gapminder/cleaned-data/
head gapminder-aus.csv
~~~

~~~ {.output}
"country","year","pop","continent","lifeExp","gdpPercap"
"61","Australia",1952,8691212,"Oceania",69.12,10039.59564
"62","Australia",1957,9712569,"Oceania",70.33,10949.64959
"63","Australia",1962,10794968,"Oceania",70.93,12217.22686
"64","Australia",1967,11872264,"Oceania",71.1,14526.12465
"65","Australia",1972,13177000,"Oceania",71.93,16788.62948
"66","Australia",1977,14074100,"Oceania",73.49,18334.19751
"67","Australia",1982,15184200,"Oceania",74.74,19477.00928
"68","Australia",1987,16257249,"Oceania",76.32,21888.88903
"69","Australia",1992,17481977,"Oceania",77.56,23424.76683
~~~

Hmm, that's not quite what we wanted. Where did all these
quotation marks come from? Also the row numbers are 
meaningless.

Let's look at the help file to work out how to change this
behaviour.

~~~ {.r}
?write.table
~~~

By default R will wrap character vectors with quotation marks
when writing out to file. It will also write out the row and
column names.

Let's fix this:

~~~ {.r}
write.table(
  gapminder[gapminder$country == "Australia",],
  file="cleaned-data/gapminder-aus.csv",
  sep=",", quote=FALSE, row.names=FALSE
)
~~~

Now lets look at the data again using our shell skills:

~~~ {.shell}
head gapminder-aus.csv
~~~

~~~ {.output}
country,year,pop,continent,lifeExp,gdpPercap
Australia,1952,8691212,Oceania,69.12,10039.59564
Australia,1957,9712569,Oceania,70.33,10949.64959
Australia,1962,10794968,Oceania,70.93,12217.22686
Australia,1967,11872264,Oceania,71.1,14526.12465
Australia,1972,13177000,Oceania,71.93,16788.62948
Australia,1977,14074100,Oceania,73.49,18334.19751
Australia,1982,15184200,Oceania,74.74,19477.00928
Australia,1987,16257249,Oceania,76.32,21888.88903
Australia,1992,17481977,Oceania,77.56,23424.76683
~~~

That looks better!

> #### Challenge {.challenge}
>
> Write a data-cleaning script file that subsets the gapminder
> data to include only data points collected since 1990.
> 
> Use this script to write out the new subset to a file
> in the `cleaned-data/` directory. 
> 

