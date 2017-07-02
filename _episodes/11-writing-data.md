---
title: Writing Data
teaching: 10
exercises: 10
questions:
- "How can I save plots and data created in R?"
objectives:
- "To be able to write out plots and data from R."
keypoints:
- "Save plots from RStudio using the 'Export' button."
- "Use `write.table` to save tabular data."
source: Rmd
---




## Saving plots

You have already seen how to save the most recent plot you create in `ggplot2`,
using the command `ggsave`. As a refresher:


~~~
ggsave("My_most_recent_plot.pdf")
~~~
{: .r}

You can save a plot from within RStudio using the 'Export' button
in the 'Plot' window. This will give you the option of saving as a
.pdf or as .png, .jpg or other image formats.

Sometimes you will want to save plots without creating them in the
'Plot' window first. Perhaps you want to make a pdf document with
multiple pages: each one a different plot, for example. Or perhaps
you're looping through multiple subsets of a file, plotting data from
each subset, and you want to save each plot, but obviously can't stop
the loop to click 'Export' for each one.

In this case you can use a more flexible approach. The function
`pdf` creates a new pdf device. You can control the size and resolution
using the arguments to this function.


~~~
pdf("Life_Exp_vs_time.pdf", width=12, height=4)
ggplot(data=gapminder, aes(x=year, y=lifeExp, colour=country)) +
  geom_line() +
  theme(legend.position="none")

# You then have to make sure to turn off the pdf device!

dev.off()
~~~
{: .r}

Open up this document and have a look.

> ## Challenge 1
>
> Rewrite your 'pdf' command to print a second
> page in the pdf, showing a facet plot (hint: use `facet_grid`)
> of the same data with one panel per continent.
> > ## Solution to challenge 1
> >
> > ~~~
> > pdf("Life_Exp_vs_time.pdf", width=12, height=4)
> > 
> > ggplot(data=gapminder, aes(x=year, y=lifeExp,, colour=country)) + 
> >   geom_line()+ 
> >   theme(legend.position="none")
> > 
> > p+facet_grid(. ~continent)
> > 
> > dev.off()
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}



The commands `jpeg`, `png` etc. are used similarly to produce
documents in different formats.

## Writing data

At some point, you'll also want to write out data from R.

We can use the `write.table` function for this, which is
very similar to `read.table` from before.

Let's create a data-cleaning script, for this analysis, we
only want to focus on the gapminder data for Australia:


~~~
aust_subset <- gapminder[gapminder$country == "Australia",]

write.table(aust_subset,
  file="cleaned-data/gapminder-aus.csv",
  sep=","
)
~~~
{: .r}

Let's switch back to the shell to take a look at the data to make sure it looks
OK:


~~~
head cleaned-data/gapminder-aus.csv
~~~
{: .r}




~~~
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
{: .output}

Hmm, that's not quite what we wanted. Where did all these
quotation marks come from? Also the row numbers are
meaningless.

Let's look at the help file to work out how to change this
behaviour.


~~~
?write.table
~~~
{: .r}

By default R will wrap character vectors with quotation marks
when writing out to file. It will also write out the row and
column names.

Let's fix this:


~~~
write.table(
  gapminder[gapminder$country == "Australia",],
  file="cleaned-data/gapminder-aus.csv",
  sep=",", quote=FALSE, row.names=FALSE
)
~~~
{: .r}

Now lets look at the data again using our shell skills:


~~~
head cleaned-data/gapminder-aus.csv
~~~
{: .r}




~~~
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
{: .output}

That looks better!

> ## Challenge 2
>
> Write a data-cleaning script file that subsets the gapminder
> data to include only data points collected since 1990.
>
> Use this script to write out the new subset to a file
> in the `cleaned-data/` directory.
{: .challenge}


