---
title: "Intro to R"
author: "Kara Woo"
date: "03/26/2015"
output: html_document
---



> ### Learning Objectives {.objectives}
>
> * Familiarize participants with R syntax
> * Understand the concepts of objects and assignment
> * Understand the concepts of vector and data types
> * Get exposed to a few functions


### What is R?

R is an open source language for statistics and visualization. R is free and
has a large (and growing) community, making it a popular choice for data
analysis.

Our real goal isn't to teach you R, but to teach you the basic concepts that all
programming depends on. We use R in our lessons because:

* we have to use something for examples;
* it's free, well-documented, and runs almost everywhere;
* it has a large (and growing) user base among scientists; and
* it has a large library of external packages available for performing diverse tasks.

RStudio is an IDE, or "integrated development environment" for R. You don't
need to use RStudio to use R, but it comes with a lot of handy features.

Let's start by creating a new RStudio
[project](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects)
on our desktop. RStudio helps you organize your work into discrete projects,
each with their own files and history. You can use RStudio projects to easily
pick up where you left off with a project or analysis.

Now that we're in our project, let's get familiar with RStudio's layout. First
there is the R console, which will evaluate the commands we give it. You can
type directly into the console. For example, R can do arithmetic:


~~~{.r}
2 + 2
~~~



~~~{.output}
[1] 4

~~~



~~~{.r}
5 * 6
~~~



~~~{.output}
[1] 30

~~~



~~~{.r}
10 / 4
~~~



~~~{.output}
[1] 2.5

~~~

The Files tab shows files that are in the directory we are currently in,
e.g. `Home/Desktop/swc-wsu` -- since we are using an RStudio project, that
directory should be the same directory that the project is in.

### Creating objects

While you can type commands directly in the console, usually you'll want to
create objects, using "assignment". You assign values, data, etc. to objects
using the `<-` ooperator. For example:


~~~{.r}
x <- 8
x
~~~



~~~{.output}
[1] 8

~~~

Here we have created an object called `x` and assigned it the value 8. We can
then use `x` in other calculations or other assignments.


~~~{.r}
x * 3
~~~



~~~{.output}
[1] 24

~~~



~~~{.r}
y <- x / 2
y
~~~



~~~{.output}
[1] 4

~~~

You can overwrite an object's value at any time.


~~~{.r}
x
~~~



~~~{.output}
[1] 8

~~~



~~~{.r}
x <- 15
x
~~~



~~~{.output}
[1] 15

~~~

Since `y` was defined as `x / 2`, has it changed now that we have changed `x`?
The answer is **no**. We assigned the value of `x / 2` to `y` when `x` was 8, so
the *value* that actually got assigned to `y` was 4. This will not change unless
we reassign `y`.

To view the objects that are in your current environment, use `ls()`.


~~~{.r}
ls()
~~~



~~~{.output}
[1] "x" "y"

~~~

RStudio also shows thee objects in the Environment panel.

### Writing scripts

One of the major reasons to write code is to keep a record of what you have done
so that you can repeat it. This way, if a reviewer asks you to slightly modify a
figure in a manuscript or to clarify how you found a particular result, you
don't need to remember and recreate every button click, you can just re-run the
script or modify it if necessary. So far we have been typing directly into the
console, but to save our work for future use we should write a script. Let's
create a new script and copy the commands we have already executed from the
History tab in RStudio.

To execute code in the console from a script you use Ctrl-Enter (or Cmd-Enter on
a Mac). If code is highlighted it will execute the entire selection; if nothing
is highlighted it will execute the current line.

From now on we'll be working in a script and executing the code from there. This
way you will have a record of everything we did in this lesson.

### Vectors and data types

*Adapted from Christie Bahlai's [materials](https://github.com/cbahlai/2015-01-05-wise-umich/) for the 2015-01-05 UMich workshop*

A vector is a group of values, mainly either numbers or characters. You can
assign this set of values to a variable, just like you would for one item. For
example we can create a vector of animal weights:


~~~{.r}
weights <- c(50, 60, 65, 82)
weights
~~~



~~~{.output}
[1] 50 60 65 82

~~~

The `c()` stands for "combine". A vector can also contain characters:


~~~{.r}
animals <- c("mouse", "rat", "dog")
animals
~~~



~~~{.output}
[1] "mouse" "rat"   "dog"  

~~~

The contents of a vector must all be the same type (i.e. all character or all
numeric).

Functions in R let you perform various operations, such as finding the mean of
a set of numbers, for example. Functions have a name followed by a set of
parentheses that contain arguments to the function. In many cases the first
argument to a function will be an object that you are working with.

If you want to learn more about a function you can look up the help file for it
by typing `?functionname`.

There are many functions that allow you to inspect the content of an
object. `length()` tells you how many elements are in a particular vector:


~~~{.r}
length(weights)
~~~



~~~{.output}
[1] 4

~~~



~~~{.r}
length(animals)
~~~



~~~{.output}
[1] 3

~~~

`class()` indicates the class (the type of element) of an object:


~~~{.r}
class(weights)
~~~



~~~{.output}
[1] "numeric"

~~~



~~~{.r}
class(animals)
~~~



~~~{.output}
[1] "character"

~~~

The function `str()` provides an overview of the object and the elements it
contains. It is a really useful function when working with large and complex
objects:


~~~{.r}
str(weights)
~~~



~~~{.output}
 num [1:4] 50 60 65 82

~~~



~~~{.r}
str(animals)
~~~



~~~{.output}
 chr [1:3] "mouse" "rat" "dog"

~~~

You can add elements to your vector simply by using the `c()` function:


~~~{.r}
weights <- c(weights, 90) # adding at the end
weights <- c(30, weights) # adding at the beginning
weights
~~~



~~~{.output}
[1] 30 50 60 65 82 90

~~~

What happens here is that we take the original vector `weights`, and we are
adding another item first to the end of the other ones, and then another item at
the beginning. We can do this over and over again to build a vector or a
dataset. As we program, this may be useful to auto-update results that we are
collecting or calculating.

We just saw 2 of the 6 **data types** that R uses: `"character"` and
`"numeric"`. The other 4 are:

* `"logical"` for `TRUE` and `FALSE` (the boolean data type)
* `"integer"` for integer numbers (e.g., `2L`, the `L` indicates to R that it's
an integer)
* `"complex"` to represent complex numbers with real and imaginary parts (e.g.,
  `1+4i`) and that's all we're going to say about them
* `"raw"` that we won't discuss further

Vectors are one of the many **data structures** that R uses. Other important
ones are lists (`list`), matrices (`matrix`), data frames (`data.frame`) and
factors (`factor`).

> ### Challenge {.challenge}
>
> * Combine objects `x`, `y`, and `weights` into a vector called `z`.
> * Find the mean of this set of numbers (hint: there is a function called
> `mean()`).
