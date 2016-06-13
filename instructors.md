---
layout: page
title: Lesson Title
subtitle: Instructor's Guide
---

## Timing

Leave about 30 minutes at the start of each workshop and another 15 mins
at the start of each sesson for technical difficulties like WiFi and
installing things (even if you asked students to install in advance, longer if
not).


## Setting up git in RStudio

There can be difficulties linking git to RStudio depending on the operating system and the version of the operating system. To make sure git is properly installed, the learners should go to the Options window.

* **Mac OS X:**
  * Go RStudio -> Preferences... -> Git/SVN
  * Check and see whether there is a path to a file in the "Git executable" window. If not, the next challenge is figuring out where Git is located.
  * In the terminal enter `which git` and you will get a path to the git executable. In the "Git executable" window you may have difficulties finding the directory since OS X hides many of the systems file. If the user presses "Command-Shift-G" that will allow you to enter `/usr/bin/git` or whatever the path is.
* **Windows:**
	* Go Tools -> Global options... -> Git/SVN
	* If you use the Software Carpentry Installer, then 'git.exe' should be installed at 'C:/Program Files/Git/bin/git.exe'

To prevent the learners from having to re-enter their password each time they push a commit to GitHub, this command will make it so they only have to enter their password once:

    git config --global credential.helper 'cache --timeout=10000000'




## Pulling in data

The easiest way to get the data used in this lesson during a bootcamp is
to have attendees run the following:

~~~ {.shell}
git remote add data https://github.com/resbaz/r-novice-gapminder-files
git pull data master
~~~

## Overall

Make sure to emphasise good practices: put code in scripts, and make
sure they're version controlled. Encourage students to create script
files for challenges.

If you're working in a cloud environment, get them to upload the
gapminder data after the second lesson.

Make sure to emphasise that matrices are vectors underneath the hood
and data frames are lists underneath the hood: this will explain a
lot of the esoteric behaviour encountered in basic operations.

Vector recycling and function stacks are probably best explained
with diagrams on a whiteboard.

Be sure to actually go through examples of an R help page: help files
can be intimidating at first, but knowing how to read them is tremendously
useful.

Be sure to show the CRAN task views, look at one of the topics.

There's a lot of content: move quickly through the earlier lessons. Their
extensiveness is mostly for purposes of learning by osmosis: so that their
memory will trigger later when they encouter a problem or some esoteric behaviour.

Key lessons to take time on:

 * Data subsetting - conceptually difficult for novices
 * Functions - learners especially struggle with this
 * Data structures - worth being thorough, but you can go through it quickly.

Don't worry about being correct or knowing the material back-to-front. Use
mistakes as teaching moments: the most vital skill you can impart is how to
debug and recover from unexpected errors.
