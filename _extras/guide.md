---
layout: page
title: "Instructor Notes"
permalink: /guide/
---

## Timing

Leave about 30 minutes at the start of each workshop and another 15 mins
at the start of each session for technical difficulties like WiFi and
installing things (even if you asked students to install in advance, longer if
not).

## Lesson Plans

The lesson contains much more material than can be taught in a day.
Instructors will need to pick an appropriate subset of episodes to use
in a standard one day course. 

Some suggested paths through the material are:

(suggested by [@liz-is](https://github.com/swcarpentry/r-novice-gapminder/issues/104#issuecomment-276529213))

* 01 Introduction to R and RStudio
* 04 Data Structures
* 05 Exploring Data Frames ("Realistic example" section onwards)
* 08 Creating Publication-Quality Graphics with ggplot2
* 10 Functions Explained
* 13 Dataframe Manipulation with dplyr
* 15 Producing Reports With knitr

(suggested by [@naupaka](https://github.com/swcarpentry/r-novice-gapminder/issues/104#issuecomment-312547509))
* 01 Introduction to R and RStudio
* 02 Project Management With RStudio
* 03 Seeking Help
* 04 Data Structures
* 05 Exploring Data Frames
* 06 Subsetting Data
* 09 Vectorization
* 08 Creating Publication-Quality Graphics with ggplot2 *OR*
  13 Dataframe Manipulation with dplyr
* 15 Producing Reports With knitr

A half day course could consist of (suggested by [@karawoo](https://github.com/swcarpentry/r-novice-gapminder/issues/104#issuecomment-277599864)):

* 01 Introduction to R and RStudio
* 04 Data Structures (only creating vectors with `c()`)
* 05 Exploring Data Frames ("Realistic example" section onwards)
* 06 Subsetting Data (excluding factor, matrix and list subsetting)
* 08 Creating Publication-Quality Graphics with ggplot2

## Setting up git in RStudio

There can be difficulties linking git to RStudio depending on the
operating system and the version of the operating system. To make sure
Git is properly installed and configured, the learners should go to
the Options window in the RStudio application.

* **Mac OS X:**
  * Go RStudio -> Preferences... -> Git/SVN
  * Check and see whether there is a path to a file in the "Git executable" window. If not, the next challenge is figuring out where Git is located.
  * In the terminal enter `which git` and you will get a path to the git executable. In the "Git executable" window you may have difficulties finding the directory since OS X hides many of the operating system files. While the file selection window is open, pressing "Command-Shift-G" will pop up a text entry box where you will be able to type or paste in the full path to your git executable: e.g. /usr/bin/git or whatever else it might be.
* **Windows:**
  * Go Tools -> Global options... -> Git/SVN
  * If you use the Software Carpentry Installer, then 'git.exe' should be installed at `C:/Program Files/Git/bin/git.exe`.

To prevent the learners from having to re-enter their password each time they push a commit to GitHub, this command (which can be run from a bash prompt) will make it so they only have to enter their password once:

~~~
$ git config --global credential.helper 'cache --timeout=10000000'
~~~
{: .bash}

## Pulling in Data

The easiest way to get the data used in this lesson during a workshop is to have
attendees download the raw data from [gapminder-data][gapminder-data] and
[gapminder-data-wide][gapminder-data-wide].

Attendees can use the `File - Save As` dialog in their browser to save the file.

## Overall

Make sure to emphasize good practices: put code in scripts, and make
sure they're version controlled. Encourage students to create script
files for challenges.

If you're working in a cloud environment, get them to upload the
gapminder data after the second lesson.

Make sure to emphasize that matrices are vectors underneath the hood
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
memory will trigger later when they encounter a problem or some esoteric behaviour.

Key lessons to take time on:

* Data subsetting - conceptually difficult for novices
* Functions - learners especially struggle with this
* Data structures - worth being thorough, but you can go through it quickly.

Don't worry about being correct or knowing the material back-to-front. Use
mistakes as teaching moments: the most vital skill you can impart is how to
debug and recover from unexpected errors.

[gapminder-data]: https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_data.csv

[gapminder-data-wide]: https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/_episodes_rmd/data/gapminder_wide.csv
