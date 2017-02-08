---
title: "Seeking Help"
teaching: 10
exercises: 10
questions:
- "How can I get help in R?"
objectives:
- "To be able read R help files for functions and special operators."
- "To be able to use CRAN task views to identify packages to solve a problem."
- "To be able to seek help from your peers."
keypoints:
- "Use `help()` to get online help in R."
---



## Reading Help files

R, and every package, provide help files for functions. To search for help on a
function from a specific function that is in a package loaded into your
namespace (your interactive R session):


~~~
?function_name
help(function_name)
~~~
{: .r}

This will load up a help page in RStudio (or as plain text in R by itself).

Each help page is broken down into sections:

 - Description: An extended description of what the function does.
 - Usage: The arguments of the function and their default values.
 - Arguments: An explanation of the data each argument is expecting.
 - Details: Any important details to be aware of.
 - Value: The data the function returns.
 - See Also: Any related functions you might find useful.
 - Examples: Some examples for how to use the function.

Different functions might have different sections, but these are the main ones you should be aware of.

> ## Tip: Reading help files
>
> One of the most daunting aspects of R is the large number of functions
> available. It would be prohibitive, if not impossible to remember the
> correct usage for every function you use. Luckily, the help files
> mean you don't have to!
{: .callout}

## Special Operators

To seek help on special operators, use quotes:


~~~
?"+"
~~~
{: .r}

## Getting help on packages

Many packages come with "vignettes": tutorials and extended example documentation.
Without any arguments, `vignette()` will list all vignettes for all installed packages;
`vignette(package="package-name")` will list all available vignettes for
`package-name`, and `vignette("vignette-name")` will open the specified vignette.

If a package doesn't have any vignettes, you can usually find help by typing
`help("package-name")`.

## When you kind of remember the function

If you're not sure what package a function is in, or how it's specifically spelled you can do a fuzzy search:


~~~
??function_name
~~~
{: .r}

## When you have no idea where to begin

If you don't know what function or package you need to use
[CRAN Task Views](http://cran.at.r-project.org/web/views)
is a specially maintained list of packages grouped into
fields. This can be a good starting point.

## When your code doesn't work: seeking help from your peers

If you're having trouble using a function, 9 times out of 10,
the answers you are seeking have already been answered on
[Stack Overflow](http://stackoverflow.com/). You can search using
the `[r]` tag.

If you can't find the answer, there are a few useful functions to
help you ask a question from your peers:


~~~
?dput
~~~
{: .r}

Will dump the data you're working with into a format so that it can
be copy and pasted by anyone else into their R session.


~~~
sessionInfo()
~~~
{: .r}



~~~
R version 3.2.3 (2015-12-10)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Linux Mint 18

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  base     

other attached packages:
[1] checkpoint_0.3.18 stringr_1.1.0     knitr_1.15.1     

loaded via a namespace (and not attached):
[1] magrittr_1.5  tools_3.2.3   stringi_1.1.1 methods_3.2.3 evaluate_0.10
~~~
{: .output}

Will print out your current version of R, as well as any packages you
have loaded. This can be useful for others to help reproduce and debug
your issue.

> ## Challenge 1
>
> Look at the help for the `c` function. What kind of vector do you
> expect you will create if you evaluate the following:
> 
> ~~~
> c(1, 2, 3)
> c('d', 'e', 'f')
> c(1, 2, 'f')
> ~~~
> {: .r}
> > ## Solution to Challenge 1
> >
> > The `c()` function creates a vector, in which all elements are the
> > same type. In the first case, the elements are numeric, in the
> > second, they are characters, and in the third they are characters:
> > the numeric values "coerced" to be characters.
> {: .solution}
{: .challenge}

> ## Challenge 2
>
> Look at the help for the `paste` function. You'll need to use this later.
> What is the difference between the `sep` and `collapse` arguments?
>
> > ## Solution to Challenge 2
> >
> > Look at the help for the `paste` function. You'll need to use this later.
> >
> > 
> > ~~~
> > help("paste")
> > ?paste
> > ~~~
> > {: .r}
> {: .solution}
{: .challenge}

> ## Challenge 3
> Use help to find a function (and its associated parameters) that you could
> use to load data from a csv file in which columns are delimited with "\t"
> (tab) and the decimal point is a "." (period). This check for decimal
> separator is important, especially if you are working with international
> colleagues, because different countries have different conventions for the
> decimal point (i.e. comma vs period).
> hint: use `??csv` to lookup csv related functions.
{: .challenge}

## Other ports of call

* [Quick R](http://www.statmethods.net/)
* [RStudio cheat sheets](http://www.rstudio.com/resources/cheatsheets/)
* [Cookbook for R](http://www.cookbook-r.com/)
