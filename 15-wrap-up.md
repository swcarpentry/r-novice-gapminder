---
title: Writing Good Software
teaching: 15
exercises: 0
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Describe best practices for writing R and explain the justification for each.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I write software that other people can use?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Structure your project folder

Keep your project folder structured, organized and tidy, by creating subfolders for your code files, manuals, data, binaries, output plots, etc. It can be done completely manually, or with the help of RStudio's `New Project` functionality, or a designated package, such as `ProjectTemplate`.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: ProjectTemplate - a possible solution

One way to automate the management of projects is to install the third-party package, `ProjectTemplate`.
This package will set up an ideal directory structure for project management.
This is very useful as it enables you to have your analysis pipeline/workflow organised and structured.
Together with the default RStudio project functionality and Git you will be able to keep track of your
work as well as be able to share your work with collaborators.

1. Install `ProjectTemplate`.
2. Load the library
3. Initialise the project:


``` r
install.packages("ProjectTemplate")
library("ProjectTemplate")
create.project("../my_project_2", merge.strategy = "allow.non.conflict")
```

For more information on ProjectTemplate and its functionality visit the
home page [ProjectTemplate](https://projecttemplate.net/index.html)


::::::::::::::::::::::::::::::::::::::::::::::::::

## Make code readable

The most important part of writing code is making it readable and understandable.
You want someone else to be able to pick up your code and be able to understand
what it does: more often than not this someone will be you 6 months down the line,
who will otherwise be cursing past-self.

## Documentation: tell us what and why, not how

When you first start out, your comments will often describe what a command does,
since you're still learning yourself and it can help to clarify concepts and
remind you later. However, these comments aren't particularly useful later on
when you don't remember what problem your code is trying to solve. Try to also
include comments that tell you *why* you're solving a problem, and *what* problem
that is. The *how* can come after that: it's an implementation detail you ideally
shouldn't have to worry about.

## Keep your code modular

Our recommendation is that you should separate your functions from your analysis
scripts, and store them in a separate file that you `source` when you open the R
session in your project. This approach is nice because it leaves you with an
uncluttered analysis script, and a repository of useful functions that can be
loaded into any analysis script in your project. It also lets you group related
functions together easily.

## Break down problem into bite size pieces

When you first start out, problem solving and function writing can be daunting
tasks, and hard to separate from code inexperience. Try to break down your
problem into digestible chunks and worry about the implementation details later:
keep breaking down the problem into smaller and smaller functions until you
reach a point where you can code a solution, and build back up from there.

## Know that your code is doing the right thing

Make sure to test your functions!

## Don't repeat yourself

Functions enable easy reuse within a project. If you see blocks of similar
lines of code through your project, those are usually candidates for being
moved into functions.

If your calculations are performed through a series of functions, then the
project becomes more modular and easier to change. This is especially the case
for which a particular input always gives a particular output.

## Remember to be stylish

Apply consistent style to your code.

:::::::::::::::::::::::::::::::::::::::: keypoints

- Keep your project folder structured, organized and tidy.
- Document what and why, not how.
- Break programs into short single-purpose functions.
- Write re-runnable tests.
- Don't repeat yourself.
- Be consistent in naming, indentation, and other aspects of style.

::::::::::::::::::::::::::::::::::::::::::::::::::


