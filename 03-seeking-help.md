---
title: Seeking Help
teaching: 10
exercises: 10
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- To be able to read R help files for functions and special operators.
- To be able to use CRAN task views to identify packages to solve a problem.
- To be able to seek help from your peers.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I get help in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



## Reading Help Files

R, and every package, provide help files for functions. The general syntax to search for help on any
function, "function\_name", from a specific function that is in a package loaded into your
namespace (your interactive R session) is:


``` r
?function_name
help(function_name)
```

For example take a look at the help file for `write.table()`, we will be using a similar function in an upcoming episode.


``` r
?write.table()
```

This will load up a help page in RStudio (or as plain text in R itself).

Each help page is broken down into sections:

- Description: An extended description of what the function does.
- Usage: The arguments of the function and their default values (which can be changed).
- Arguments: An explanation of the data each argument is expecting.
- Details: Any important details to be aware of.
- Value: The data the function returns.
- See Also: Any related functions you might find useful.
- Examples: Some examples for how to use the function.

Different functions might have different sections, but these are the main ones you should be aware of.

Notice how related functions might call for the same help file:


``` r
?write.table()
?write.csv()
```

This is because these functions have very similar applicability and often share the same arguments as inputs to the function, so package authors often choose to document them together in a single help file.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Running Examples

From within the function help page, you can highlight code in the
Examples and hit <kbd>Ctrl</kbd>\+<kbd>Return</kbd> to run it in
RStudio console. This gives you a quick way to get a feel for
how a function works.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Reading Help Files

One of the most daunting aspects of R is the large number of functions
available. It would be prohibitive, if not impossible to remember the
correct usage for every function you use. Luckily, using the help files
means you don't have to remember that!


::::::::::::::::::::::::::::::::::::::::::::::::::

## Special Operators

To seek help on special operators, use quotes or backticks:


``` r
?"<-"
?`<-`
```

## Getting Help with Packages

Many packages come with "vignettes": tutorials and extended example documentation.
Without any arguments, `vignette()` will list all vignettes for all installed packages;
`vignette(package="package-name")` will list all available vignettes for
`package-name`, and `vignette("vignette-name")` will open the specified vignette.

If a package doesn't have any vignettes, you can usually find help by typing
`help("package-name")`.

RStudio also has a set of excellent
[cheatsheets](https://rstudio.com/resources/cheatsheets/) for many packages.

## When You Remember Part of the Function Name

If you're not sure what package a function is in or how it's specifically spelled, you can do a fuzzy search:


``` r
??function_name
```

A fuzzy search is when you search for an approximate string match. For example, you may remember that the function
to set your working directory includes "set" in its name. You can do a fuzzy search to help you identify the function:


``` r
??set
```

## When You Have No Idea Where to Begin

If you don't know what function or package you need to use
[CRAN Task Views](https://cran.at.r-project.org/web/views)
is a specially maintained list of packages grouped into
fields. This can be a good starting point.

## Other ways to get help

There are several other ways that people often get help when they are stuck with their R code.

* Search the internet: paste the last line of your error message or “R” and a short description of what you want to do into your favourite search engine and you will usually find several examples where other people have encountered the same problem and came looking for help.
  * StackOverflow can be particularly helpful for this: answers to questions are presented as a ranked thread ordered according to how useful other users found them to be. You can search using the `[r]` tag. 
  * **Take care**: copying and pasting code written by somebody else is risky unless you understand exactly what it is doing!
* Ask somebody “in the real world”. If you have a colleague or friend with more expertise in R than you have, show them the problem you are having and ask them for help.
* Sometimes, the act of articulating your question can help you to identify what is going wrong. This is known as [“rubber duck debugging”](https://en.wikipedia.org/wiki/Rubber_duck_debugging) among programmers.

### Formulating your question

The StackOverflow page on [how to ask a good question](https://stackoverflow.com/help/how-to-ask) has tips on what information to include when posting a question on StackOverflow. Some of these are specific to StackOverflow but others are also relevant if you're asking a colleague or friend for help, or even if just articulating your question to yourself.

R has a few useful functions to help you formulate your question:


``` r
?dput
```

Will dump the data you're working with into a format that can
be copied and pasted by others into their own R session.


``` r
sessionInfo()
```

``` output
R version 4.5.1 (2025-06-13)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 22.04.5 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.10.0 
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0  LAPACK version 3.10.0

locale:
 [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
 [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
 [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
[10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   

time zone: UTC
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_4.5.1 tools_4.5.1    yaml_2.3.10    knitr_1.50     xfun_0.52     
[6] renv_1.1.4     evaluate_1.0.3
```

Will print out your current version of R, as well as any packages you
have loaded. This can be useful for others to help reproduce and debug
your issue.

### Generative AI

::::::::::::::::::::::::::::: instructor

### Choose how to teach this section

The section on generative AI is intended to be concise but Instructors may choose to devote more time to the topic in a workshop.

Depending on your own level of experience and comfort with talking about and using these tools, you could choose to do any of the following:

* Explain how large language models work and are trained, and/or the difference between generative AI, other forms of AI that currently exist, and the limits of what LLMs can do (e.g., they can't "reason").

* Demonstrate how you recommend that learners use generative AI.

* Discuss the ethical concerns listed below, as well as others that you are aware of, to help learners make an informed choice about whether or not to use generative AI tools.

This is a fast-moving technology. 
If you are preparing to teach this section and you feel it has become outdated, please open an issue on the lesson repository to let the Maintainers know and/or a pull request to suggest updates and improvements.

::::::::::::::::::::::::::::::::::::::::

It is increasingly common for people to use _generative AI_ chatbots such as ChatGPT to get help while coding.
You will probably receive some useful guidance by presenting your error message to the chatbot and asking it what went wrong. 
However, the way this help is provided by the chatbot is different.
Answers on StackOverflow have (probably) been given by a human as a direct response to the question asked.
But generative AI chatbots, which are based on an advanced statistical model, respond by generating the _most likely_ sequence of text that would follow the prompt they are given.

While responses from generative AI tools can often be helpful, they are not always reliable.
These tools sometimes generate plausible but incorrect or misleading information, so (just as with an answer found on the internet) it is essential to verify their accuracy.
You need the knowledge and skills to be able to understand these responses, to judge whether or not they are accurate, and to fix any errors in the code it offers you.

In addition to asking for help, programmers can use generative AI tools to generate code from scratch; extend, improve and reorganise existing code; translate code between programming languages; figure out what terms to use in a search of the internet; and more.
However, there are drawbacks that you should be aware of.

The models used by these tools have been “trained” on very large volumes of data, much of it taken from the internet, and the responses they produce reflect that training data, and may recapitulate its inaccuracies or biases.
The environmental costs (energy and water use) of LLMs are a lot higher than other technologies, both during development (known as training) and when an individual user uses one (also called inference).
For more information see the [AI Environmental Impact Primer](https://huggingface.co/blog/sasha/ai-environment-primer) developed by researchers at HuggingFace, an AI hosting platform.
Concerns also exist about the way the data for this training was obtained, with questions raised about whether the people developing the LLMs had permission to use it.
Other ethical concerns have also been raised, such as reports that workers were exploited during the training process.

**We recommend that you avoid getting help from generative AI during the workshop** for several reasons:

1. For most problems you will encounter at this stage, help and answers can be found among the first results returned by searching the internet.
2. The foundational knowledge and skills you will learn in this lesson by writing and fixing your own programs are essential to be able to evaluate the correctness and safety of any code you receive from online help or a generative AI chatbot.
  If you choose to use these tools in the future, the expertise you gain from learning and practising these fundamentals on your own will help you use them more effectively.
3. As you start out with programming, the mistakes you make will be the kinds that have also been made – and overcome! – by everybody else who learned to program before you.
   Since these mistakes and the questions you are likely to have at this stage are common, they are also better represented than other, more specialised problems and tasks in the data that was used to train generative AI tools.
  This means that a generative AI chatbot is _more likely to produce accurate responses_ to questions that novices ask, which could give you a false impression of how reliable they will be when you are ready to do things that are more advanced.



:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Look at the help page for the `c` function. What kind of vector do you
expect will be created if you evaluate the following:


``` r
c(1, 2, 3)
c('d', 'e', 'f')
c(1, 2, 'f')
```

:::::::::::::::  solution

## Solution to Challenge 1

The `c()` function creates a vector, in which all elements are of the
same type. In the first case, the elements are numeric, in the
second, they are characters, and in the third they are also characters:
the numeric values are "coerced" to be characters.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Look at the help for the `paste` function. You will need to use it later.
What's the difference between the `sep` and `collapse` arguments?

:::::::::::::::  solution

## Solution to Challenge 2

To look at the help for the `paste()` function, use:


``` r
help("paste")
?paste
```

The difference between `sep` and `collapse` is a little
tricky. The `paste` function accepts any number of arguments, each of which
can be a vector of any length. The `sep` argument specifies the string
used between concatenated terms — by default, a space. The result is a
vector as long as the longest argument supplied to `paste`. In contrast,
`collapse` specifies that after concatenation the elements are *collapsed*
together using the given separator, the result being a single string.

It is important to call the arguments explicitly by typing out the argument
name e.g `sep = ","` so the function understands to use the "," as a
separator and not a term to concatenate.
e.g.


``` r
paste(c("a","b"), "c")
```

``` output
[1] "a c" "b c"
```

``` r
paste(c("a","b"), "c", ",")
```

``` output
[1] "a c ," "b c ,"
```

``` r
paste(c("a","b"), "c", sep = ",")
```

``` output
[1] "a,c" "b,c"
```

``` r
paste(c("a","b"), "c", collapse = "|")
```

``` output
[1] "a c|b c"
```

``` r
paste(c("a","b"), "c", sep = ",", collapse = "|")
```

``` output
[1] "a,c|b,c"
```

(For more information,
scroll to the bottom of the `?paste` help page and look at the
examples, or try `example('paste')`.)



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Use help to find a function (and its associated parameters) that you could
use to load data from a tabular file in which columns are delimited with "\\t"
(tab) and the decimal point is a "." (period). This check for decimal
separator is important, especially if you are working with international
colleagues, because different countries have different conventions for the
decimal point (i.e. comma vs period).
Hint: use `??"read table"` to look up functions related to reading in tabular data.

:::::::::::::::  solution

## Solution to Challenge 3

The standard R function for reading tab-delimited files with a period
decimal separator is read.delim(). You can also do this with
`read.table(file, sep="\t")` (the period is the *default* decimal
separator for `read.table()`), although you may have to change
the `comment.char` argument as well if your data file contains
hash (#) characters.



:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Resources

- [Quick R](https://www.statmethods.net/)
- [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/)
- [Cookbook for R](https://www.cookbook-r.com/)

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `help()` to get online help in R.

::::::::::::::::::::::::::::::::::::::::::::::::::


