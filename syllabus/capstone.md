---
layout: page
title: Capstone exercise
root: ..
---

### Using an Rmd file, create a short analysis report of the gapminder dataset.

Feel free to collaborate!

1. Pick three countries you are interested in.
2. Write an Rmd script to load the gapminder data file, select all the data for
   those countries (hint, use the filter() function), and use ggplot to make a
   three scatter plots (one for each country) that has year on the x-axis and
   GDP on the y axis. Make sure you load all the libraries you might need
   (dplyr, ggplot2, etc). Describe any trends you see for each country using
   markdown text.
3. Commit the changes to your .Rmd file using git.
4. For the year 2007, calculate the mean, min, and max life expectancies for
   each continent. Describe what you see in the results using markdown text.
5. Commit your changes using git and push them to GitHub.
6. Make 2 histograms of global life expectancy using ggplot. One with the
   default bin widths and one with narrower bin widths. Explain the differences
   and any interesting trends in markdown text.
7. Commit your changes and push them to GitHub.
8. Compile the final .Rmd file to HTML, make sure it looks ok, and then commit
   this HTML file (plus figures) and push everything to GitHub.


(Thanks to [Naupaka](http://naupaka.github.io/2015-02-21-iplant/))
