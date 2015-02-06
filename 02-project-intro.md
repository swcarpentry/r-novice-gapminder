---
layout: page
title: R for reproducible scientific analysis
subtitle: Project management with RStudio
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * To be able to create self-contained projects in RStudio
>

### Directory layout - the general disaster

The scientific process is naturally incremental, and many projects
start life as random notes, some code, then a manuscript, and
eventually everything is a bit mixed together.

<blockquote class="twitter-tweet"><p>Managing your projects in a reproducible fashion doesn't just make your science reproducible, it makes your life easier.</p>&mdash; Vince Buffalo (@vsbuffalo) <a href="https://twitter.com/vsbuffalo/status/323638476153167872">April 15, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

Most people tend to organize their projects like this:

![](img/bad_layout.png)

There are many reasons why we should *ALWAYS* avoid this:

1. It is really hard to tell what version of your data is
the original and what is the modified;
2. It gets really messy because it mixes files with various
extensions together;
3. It probably takes you a lot of time to actually find
things, and relate the correct figures to the exact code
that has been used to generate it;

A good project layout helps ensure the

* Integrity of data
* Portability of the project
* Easier to pick the project back up after a break

### Project separation

The scientific process can often be exploratory, and you may find
yourself juggling several different projects or analyses at once.
Eventually, you will need to return to a project, and work out what
you've done (e.g. when writing up your thesis!). 

Separating different analysis into different directories is a good idea
for a number of reasons, as it allows you to more easily:

 * Archive a finished project
 * Give your code to someone else (your lab-mate, collaborator, supervisor)
 * Upload your code with your manuscript submission
 * Move between computers (for example home and work, or to a new machine when one breaks)

### The RStudio solution

Fortunately, RStudio can help you manage your code effectively.

One of the most powerful and useful aspects of RStudio is its project management 
functionality. We'll be using this today to create a self-contianed, reproducible
project.
 
> #### Challenge: Installing Packages {.challenge} 
> 
> The first thing we're going to do is to install a third-party package, `packrat`. 
> This is allows RStudio to create self-contained packages: any further packages 
> you download will be contained within their respective projects. This is really 
> useful, as different versions of packages can change results as new knowledge is 
> gained. This allows you to easily keep track of the version used for your analyses. 
> 
> Packages can be installed using the `install.packages` function: 
> 
> ~~~ {.r} 
> install.packages("packrat") 
> ~~~
>

> #### Challenge: Creating a self-contained project {.challenge}
>
> Now we're going to create a new project in RStudio:
> 
> 1. Click the "File" menu button, then "New Project".
> 2. Click "New Directory"
> 3. Click "Empty Project"
> 4. Type in the name of the directory to store your project, e.g. "my_project"
> 5. Make sure that the checkboxes for "Create a git repository" and "Use
>    packrat with this project" are selected >
> 6. Click the "Create Project" button
>

Now if we start R in this project directory, or open this project with RStudio,
everything will work nicely and be self-contained to this directory. Packrat
will handle any package dependencies our analyses will have by installing them
in a library stored in the subdirectory of our project directory. Packrat will
keep track of version numbers, and later you can bundle up your project and 
share it with someone else and it will install the right package versions from
the project's library. This means we don't have to waste time and memory keeping
track of these mundane details, and even allows us to use different versions of
packages in different projects.

First lets, download a useful package that will create a nice project structure
for us:

> #### Challenge: ProjectTemplate {.challenge}
>
> ~~~ {.r}
> install.packages("ProjectTemplate")
> ~~~
>

Now lets load the ProjectTemplate and packrat packages into our R session:

> #### Challenge: Loading Libraries {.challenge}
>
> ~~~ {.r}
> library("ProjectTemplate")
> library("packrat")
> ~~~
>

Here we've called the function `library` and used it to load those packages
into our local namespace (our interactive R session). This means all of 
their functions are now available to us.

> #### Challenge: Project Template {.challenge}
>
> Let's use `ProjectTemplate` to populate our directory structure:
> 
> ~~~ {.r}
> # Here "." means "current working directory", just like we saw in the shell
> # lessons 
> create.project(".") 
> ~~~
> 
> ~~~ {.output}
> Error in .create.project.existing(template.path, project.name, merge.strategy) : 
>   Directory . not empty.  Use merge.strategy = 'allow.non.conflict' to override.
> ~~~

> #### Tip: Warnings vs. Errors {.callout}
>
> Pay attention when R does something unexpected! Errors, like above,
> are thrown when R cannot proceed with a calculation. Warnings on the
> other hand usually mean that the function has run, but it probably
> hasn't worked as expected.
>
> In both cases, the message that R prints out usually give you clues
> how to fix a problem.
>

In this case, an error was thrown since `ProjectTemplate` is usually run
on an empty directory. In this case though, we're using `packrat` to manage
or project, so let's follow the advice of the error message:

> #### Challenge: Project Template continued {.challenge}
>
> ~~~ {.r}
> create.project(".", merge.strategy = 'allow.non.conflict')
> ~~~
>

Now we see a lot of new files and directories have appeared in our project. Let's 
open the `README` file.

You should now see a new window in your RStudio environment. This is called the 
"scripting" pane: this is where all your scripts and files will open for editing.

### Best practices for project organisation

`ProjectTemplate` is a third-party package that attempts to create a useful
project layout for you. There is no "best" solution for this, but it does
provide a good starting point and guide. 

`ProjectTemplate` also automates a lot of the repetitive tasks for you: library 
loading, data cleaning, and reading in data. We will be turning these off 
for the purposes of this workshop: 

We're simply using `ProjectTemplate` to 
show some design philosophies for effective project management.

#### Treat data as read only

This is probably the most important goal of setting up a project. Data is
typically time consuming and/or expensive to collect. Working with them
interactively (e.g., in Excel) where they can be modified means you are never
sure of where the data came from, or how it has been modified since collection. 
It's a good idea to treat your data as "read-only". Any processing and analysis
of the data should store results or intermediate data elsewhere. `ProjectTemplate`
sets this up for you:

 * The `data/` directory is where you should put your read-only data.

#### Data Cleaning

In many cases your data will be "dirty": it will need significant preprocessing
to get into a format R (or any other programming language) will find useful. This
task is sometimes called "data munging". You should store any scripts for data
processing in the `munge` directory. 

`ProjectTemplate` suggests storing the processed data in the `cache` folder, but
you may find it useful to create a separate folder for your cleaned gold-standard
versions of your datasets.

#### Treat generated output as disposable

Anything generated by your scripts should be treated as disposable: it should 
all be able to be regenerated from your scripts. `ProjectTemplate` creates 
a number of folders to separate various types of output:

 * `graphs`: for any figures your code produces
 * `reports`: for any tables and generated reports (using RMarkdown for example)

#### Separate function definition and application

The most effective way I find to work in R, is to play around in the interactive
session, then copy commands across to a script file when I'm sure they work and
do what I want. You can also save all the commands you've entered using the 
`history` command, but I don't find it useful because when I'm typing its 90%
trial and error.

When your project is new and shiny, the script file usually contains many lines
of directly executed code. As it matures, reusable chunks get pulled into their
own functions. Its a good idea to logically separate these files, especially if 
you're doing lots of different analyses:

 * `src`: to store your analysis scripts 
 * `lib`: to store your helper functions

#### Other folders

`ProjectTemplate` generates a lot of other folders, but we won't cover them here.
If you're interested in using ProjectTemplate you can find out more on [their
website](http://projecttemplate.net/)


### Version Control

We also set up our project to integrate with git, putting it under version control.
RStudio has a nicer interface to git than shell, but is very limited in what it can
do, so you will find yourself occasionally needing to use the shell. Let's go 
through and make an initial commit of our template files.

