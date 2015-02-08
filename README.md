R for reproducible scientific analysis
===

Introduction to R for non-programmers using gapminder data.

The goal of this lesson is to teach novice programmers to write modular code
and best practices for using R for data analysis. R is commonly used in many
scientific disciplines for statistical analysis and its array of third-party
packages. We find that many scientists who come to Software Carpentry workshops
use R and want to learn more. The emphasis of these materials is to give
attendees a strong foundation in the fundamentals of R, and to teach best
practices for scientific computing: breaking down analyses into modular units,
task automation, and encapsulation.

Note that this workshop will focus on teaching the fundamentals of the 
programming language R, and will not teach statistical analysis.

A variety of third party packages are used throughout this workshop. These
are not necessarily the best, nor are they comprehensive, but they are 
packages we find useful, and have been chosen primarily for their 
usability.

These lesson materials are adapted from the
[R-novice-inflammation](http://swcarpentry.github.io/r-novice-inflammation)
materials, which were translated from the Python materials, and materials from
our [R Data Carpentry materials used at the Sydney bootcamp last
year](https://dbarneche.github.io/2014-10-31-USyd/).

These lesson materials are designed to be run *after* both the Shell and Git
materials, and are built around the [Gapminder dataset](http://www.gapminder.org/).

## Contributing

Please see the current list of [issues][] for ideas for contributing to this
repository. 

When editing topic pages, you should change the source R Markdown file.
Afterwards you can render the pages by running `make preview` from the base of
the repository. Building the rendered page with the Makefile requires
installing some dependencies first. In addition to the dependencies listed in
the [lesson template documentation][dependencies], you also need to install the
R package [knitr][].

Once you've made your edits and rendered the corresponding html files, you need
to add, commit, and push both the source R Markdown file(s) and the rendered
html file(s). Including the html file(s) is required for viewing the [online
version of the lessons][online] (you can learn more about the design of the
build process [here][design]).

[issues]: https://github.com/resbaz/novice-r/issues [dependencies]:
https://github.com/swcarpentry/lesson-template#dependencies [knitr]:
http://cran.r-project.org/web/packages/knitr/index.html [online]:
http://resbaz.github.io/novice-r/ [design]:
https://github.com/swcarpentry/lesson-template/blob/gh-pages/DESIGN.md

## Getting Help

> Please see
> [https://github.com/swcarpentry/lesson-template](https://github.com/swcarpentry/lesson-template)
> for instructions on formatting, building, and submitting lessons, or run
> `make` in this directory for a list of helpful commands.

If you have questions or proposals, please send them to the [r-discuss][]
mailing list.

[r-discuss]:
http://lists.software-carpentry.org/mailman/listinfo/r-discuss_lists.software-carpentry.org
