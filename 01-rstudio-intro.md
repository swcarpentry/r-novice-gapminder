---
layout: page
title: R for reproducible scientific analysis
subtitle: Introduction to RStudio and RStudio Projects
minutes: 15
---

> ## Learning Objectives {.objectives}
>
> * To be familiar with the various panes in the RStudio IDE
> * To be able to create self-contained projects in RStudio
>

### Introduction to RStudio

Welcome to the R portion of the Software Carpentry workshop. 

Throughout this lesson, we're going to teach you some of the fundamentals of
the R language as well as some best practices for organising code for
scientific projects that will make your life easier.

We'll be using RStudio: a free, open source R integrated development
environment. It provides a built in editor, works on all platforms (including
on servers) and provides many advantages such as integration with version
control and project management.

**Basic layout**

When you first open RStudio, you will be greeted by three panels:

  * The interactive R console (entire left)
  * Workspace/History (tabbed in upper right)
  * Files/Plots/Packages/Help (tabbed in lower right)

When open files, such as R scripts, a scripting panel will also open in the top left.

I'm going to reorganise these panes in such a way that makes them easier to see while
teaching.

One of the most powerful and useful aspects of RStudio is its project management 
functionality. 

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
