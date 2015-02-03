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

Fortunately, RStudio can help up with this.

One of the most powerful and useful aspects of RStudio is its project management  
functionality. We'll be using this today to create a self-contianed project. 
 
> # Installing Packages {.challenge} 
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
