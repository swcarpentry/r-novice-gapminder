---
layout: page
title: R for reproducible scientific analysis
subtitle: Seeking help
minutes: 15
---

> ### Learning Objectives {.objectives}
>
> * To be able read R helpfiles for functions and special operators.
> * To be able to use CRAN taskviews to identify packages to solve a problem.
> * To be able to seek help from your peers

### Reading Help files

There are various ways to seek help on R.

To search for help on a function from a specific function that is in a
package loaded into your namespace (your interactive R session):

~~~ {.r}
?function_name
help(function_name)
~~~

This will load up a help page in RStudio (or as plain text in R by itself).

Each help page is broken down into sections:

 - Description: An extended description of what the function does. 
 - Usage: The arguments of the function and their default values.
 - Arguments: An explanation of the data each argument is expecting.
 - Details: Any important details to be aware of.
 - Value: The data the function returns
 - See Also: Any related functions you might find useful
 - Examples: Some examples for how to use the function

Different functions might have different sections, but these are the main ones you should be aware of.

> #### Tip: Reading help files {.callout}
>
> One of the most daunting aspects of R is the large number of functions 
> available. It would be prohibitive, if not impossible to remember the
> correct usage for every function you use. Luckily, the help files 
> mean you don't have to!
>

### Special Operators

To seek help on special operators, use quotes:

~~~ {.r}
?"+"
~~~

### When you kind of remember the function

If you're not sure what package a function is in, or how its specifically spelled you can do a fuzzy search:

~~~ {.r}
??function_name
~~~

### When you have no idea where to begin

If you don't know what function or package you need to use 
[CRAN Task Views](http://cran.at.r-project.org/web/views) 
is a specially maintained list of packages grouped into
fields. This can be a good starting point

### When your code doesn't work: seeking help from your peers

If you're having trouble using a function, 9 times out of 10, 
the answers you are seeking have already been answered on 
[stackoverflow](http://stackoverflow.com/). You can search using
the `[r]` tag.

If you can't find the answer, there are a few useful functions to
help you ask a question from your peers:

~~~ {.r}
?dput
~~~

Will dump the data your working with into a format so that it can
be copy and pasted by anyone else into their R session.

~~~ {.r}
sessionInfo()
~~~

Will print out your current version of R, as well as any packages you
have loaded. This can be useful for others to help reproduce and debug
your issue.

