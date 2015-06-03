---
layout: page
title: R for reproducible scientific analysis
subtitle: Creating publication quality graphics
minutes: 60
---



> # Learning Objectives {.objectives}
>
> * To be able to use ggplot2 to generate publication quality graphics
> * To understand the basics of the grammar of graphics:
>   - The aesthetics layer
>   - The geometry layer
>   - Adding statistics
>   - Transforming scales
>   - Coloring or panelling by groups.
>

Plotting our data is one of the best ways to
quickly explore it and the various relationships
between variables.

There are three main plotting systems in R,
the [base plotting system][base], the [lattice][lattice]
package, and the [ggplot2][ggplot2] package.

[base]: http://www.statmethods.net/graphs/
[lattice]: http://www.statmethods.net/advgraphs/trellis.html
[ggplot2]: http://www.statmethods.net/advgraphs/ggplot2.html

Today we'll be learning about the ggplot2 package, because
it is the most effective for creating publication quality
graphics.

ggplot2 is built on the grammar of graphics, the idea that any plot can be
expressed from the same set of components: a **data** set, a
**coordinate system**, and a set of **geoms**--the visual representation of data
points.

The key to understanding ggplot2 is thinking about a figure in layers: just like
you might do in an image editing program like photoshop, illustrator, or
inkscape.

Let's start off with an example:




~~~{.r}
library(ggplot2)
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-vs-gdpPercap-scatter.png" title="plot of chunk lifeExp-vs-gdpPercap-scatter" alt="plot of chunk lifeExp-vs-gdpPercap-scatter" style="display: block; margin: auto;" />

So the first thing we do is call the `ggplot` function. This function lets R
know that we're creating a new plot, and any of the arguments we give the
`ggplot` function are the *global* options for the plot: they apply to all
layers on the plot.

We've passed in two arguments to `ggplot`. First, we tell `ggplot` what data we
want to show on our figure, in this example the gapminder data we read in
earlier. For the second argument we passed in the `aes` function, which
tells `ggplot` how variables in the **data** map to *aesthetic* properties of
the figure, in this case the **x** and **y** locations. Here we told `ggplot` we
want to plot the "lifeExp" column of the gapminder data frame on the x-axis, and
the "gdpPercap" column on the y-axis. Notice that we didn't need to explicity
pass `aes` these columns (e.g. `x = gapminder[, "lifeExp"]`), this is because
`ggplot` is smart enough to know to look in the **data** for that column!

By itself, the call to `ggplot` isn't enough to draw a figure:


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap))
~~~



~~~{.output}
Error: No layers in plot

~~~

We need to tell `ggplot` how we want to visually represent the data, which we
do by adding a new **geom** layer. In our example, we used `geom_point`, which
tells `ggplot` we want to visually represent the relationship between **x** and
**y** as a scatterplot of points:


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-vs-gdpPercap-scatter2.png" title="plot of chunk lifeExp-vs-gdpPercap-scatter2" alt="plot of chunk lifeExp-vs-gdpPercap-scatter2" style="display: block; margin: auto;" />

> #### Challenge 1 {.challenge}
>
> Modify the example so that the figure visualise how life expectancy has
> changed over time:
>
>`ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) + geom_point()`
>
> Hint: the gapminder dataset has a column called "year", which should appear
> on the x-axis.
>

Solution:


~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()
~~~

<img src="fig/08-plot-ggplot2.Rmdchallenge-1-solution.png" title="plot of chunk challenge-1-solution" alt="plot of chunk challenge-1-solution" style="display: block; margin: auto;" />

> #### Challenge 2 {.challenge}
>
> In the previous examples and challenge we've used the `aes` function to tell
> the scatterplot **geom** about the **x** and **y** locations of each point.
> Another *aesthetic* property we can modify is the point *color*. Modify the
> code from the previous challenge to **color** the points by the "continent"
> column. What trends do you see in the data? Are they what you expected?
>

Solution:


~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_point()
~~~

<img src="fig/08-plot-ggplot2.Rmdchallenge-2-solution.png" title="plot of chunk challenge-2-solution" alt="plot of chunk challenge-2-solution" style="display: block; margin: auto;" />

### Layers

Using a scatterplot probably isn't the best for visualising change over time.
Instead, let's tell `ggplot` to visualise the data as a line plot:


~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-line.png" title="plot of chunk lifeExp-line" alt="plot of chunk lifeExp-line" style="display: block; margin: auto;" />

Instead of adding a `geom_point` layer, we've added a `geom_line` layer. We've
added the **by** *aesthetic*, which tells `ggplot` to draw a line for each
country.

But what if we want to visualise both lines and points on the plot? We can
simply add another layer to the plot:


~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) +
  geom_line() + geom_point()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-line-point.png" title="plot of chunk lifeExp-line-point" alt="plot of chunk lifeExp-line-point" style="display: block; margin: auto;" />

It's important to note that each layer is drawn on top of the previous layer. In
this example, the points have been drawn *on top of* the lines. Here's a
demonstration:


~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(color=continent)) + geom_point()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-layer-example-1.png" title="plot of chunk lifeExp-layer-example-1" alt="plot of chunk lifeExp-layer-example-1" style="display: block; margin: auto;" />

In this example, the *aesthetic* mapping of **color** has been moved from the
global plot options in `ggplot` to the `geom_line` layer so it no longer applies
to the points. Now we can clearly see that the points are drawn on top of the
lines.

> #### Challenge 3 {.challenge}
>
> Switch the order of the point and line layers from the previous example. What
> happened?
>

Solution:


~~~{.r}
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_point() + geom_line(aes(color=continent))
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-layer-example-2.png" title="plot of chunk lifeExp-layer-example-2" alt="plot of chunk lifeExp-layer-example-2" style="display: block; margin: auto;" />

The lines now get drawn over the points!

### Transformations and statistics

Ggplot also makes it easy to overlay statistical models over the data. To
demonstrate we'll go back to our first example:


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap, color=continent)) +
  geom_point()
~~~

<img src="fig/08-plot-ggplot2.RmdlifeExp-vs-gdpPercap-scatter3.png" title="plot of chunk lifeExp-vs-gdpPercap-scatter3" alt="plot of chunk lifeExp-vs-gdpPercap-scatter3" style="display: block; margin: auto;" />

Currently it's hard to see the relationship between the points due to some strong
outliers in GDP per capita. We can change the scale of units on the y axis using
the *scale* functions. These control the mapping between the data values and
visual values of an aesthetic.


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point() + scale_y_log10()
~~~

<img src="fig/08-plot-ggplot2.Rmdaxis-scale.png" title="plot of chunk axis-scale" alt="plot of chunk axis-scale" style="display: block; margin: auto;" />

The `log10` function applied a transformation to the values of the gdpPercap
column before rendering them on the plot, so that each multiple of 10 now only
corresponds to an increase in 1 on the transformed scale, e.g. a GDP per capita
of 1,000 is now 3 on the y axis, a value of 10,000 corresponds to 4 on the y
axis and so on. This makes it easier to visualise the spread of data on the
y-axis.

We can fit a simple relationship to the data by adding another layer,
`geom_smooth`:


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point() + scale_y_log10() + geom_smooth(method="lm")
~~~

<img src="fig/08-plot-ggplot2.Rmdlm-fit.png" title="plot of chunk lm-fit" alt="plot of chunk lm-fit" style="display: block; margin: auto;" />

We can make the line thicker by *setting* the **size** aesthetic in the
`geom_smooth` layer:


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point() + scale_y_log10() + geom_smooth(method="lm", size=1.5)
~~~

<img src="fig/08-plot-ggplot2.Rmdlm-fit2.png" title="plot of chunk lm-fit2" alt="plot of chunk lm-fit2" style="display: block; margin: auto;" />

There are two ways an *aesthetic* can be specified. Here we *set* the **size**
aesthetic by passing it as an argument to `geom_smooth`. Previously in the
lesson we've used the `aes` function to define a *mapping* between data
variables and their visual representation.

> #### Challenge 4 {.challenge}
>
> Modify the color and size of the points on the point layer in the previous
> example.
>
> Hint: do not use the `aes` function.
>


~~~{.r}
ggplot(data = gapminder, aes(x = lifeExp, y = gdpPercap)) +
  geom_point(size=3, color="orange") + scale_y_log10() +
  geom_smooth(method="lm", size=1.5)
~~~

<img src="fig/08-plot-ggplot2.Rmdsetting.png" title="plot of chunk setting" alt="plot of chunk setting" style="display: block; margin: auto;" />

### Multi-panel figures

Earlier we visualised the change in life expectancy over time across all
countries in one plot. Alternatively, we can split this out over multiple panels
by adding a layer of **facet** panels:


~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country)
~~~

<img src="fig/08-plot-ggplot2.Rmdfacet.png" title="plot of chunk facet" alt="plot of chunk facet" style="display: block; margin: auto;" />

The `facet_wrap` layer took a "formula" as its argument, denoted by the tilda
(~). This tells R to draw a panel for each unique value in the country column
of the gapminder dataset.

### Modifying text

To clean this figure up for a publication we need to change some of the text
elements. The x-axis is way too cluttered, and the y axis should read
"Life expectancy", rather than the column name in the data frame.

We can do this by adding a couple of different layers. The **theme** layer
controls the axis text, and overall text size, and there are special layers
for changing the axis labels. To change the legend title, we need to use the
**scales** layer.


~~~{.r}
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  xlab("Year") + ylab("Life expectancy") + ggtitle("Figure 1") +
  scale_fill_discrete(name="Continent") +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
~~~

<img src="fig/08-plot-ggplot2.Rmdtheme.png" title="plot of chunk theme" alt="plot of chunk theme" style="display: block; margin: auto;" />


This is just a taste of what you can do with `ggplot2`. RStudio provides a
really useful [cheat sheet][cheat] of the different layers available, and more
extensive documentation is available on the [ggplot2 website][ggplot-doc].
Finally, if you have no idea how to change something, a quick google search will
usually send you to a relevant question and answer on stackoverflow with reusable
code to modify!

[cheat]: http://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
[ggplot-doc]: http://docs.ggplot2.org/current/


> #### Challenge 5 {.challenge}
>
> Create a density plot of GDP per capita, filled by continent.
>
> Advanced:
>  - Transform the x axis to better visualise the data spread.
>  - Add a facet layer to panel the density plots by year.
>


~~~{.r}
ggplot(data = gapminder, aes(x = gdpPercap, fill=continent)) +
  geom_density(alpha=0.6) + facet_wrap( ~ year) + scale_x_log10()
~~~

<img src="fig/08-plot-ggplot2.Rmddensity.png" title="plot of chunk density" alt="plot of chunk density" style="display: block; margin: auto;" />
