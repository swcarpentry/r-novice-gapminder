---
layout: page
title: Lesson Title
subtitle: Instructor's Guide
---

## Timing

Leave about 30 minutes at the start of each workshop and another 15 mins 
at the start of each sesson for technical difficulties like WiFi and 
installing things (even if you asked them to install in advance, longer if 
not).

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
