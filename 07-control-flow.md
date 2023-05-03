---
title: Control Flow
teaching: 45
exercises: 20
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- Write conditional statements with `if...else` statements and `ifelse()`.
- Write and understand `for()` loops.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I make data-dependent choices in R?
- How can I repeat operations in R?

::::::::::::::::::::::::::::::::::::::::::::::::::



Often when we're coding we want to control the flow of our actions. This can be done
by setting actions to occur only if a condition or a set of conditions are met.
Alternatively, we can also set an action to occur a particular number of times.

There are several ways you can control flow in R.
For conditional statements, the most commonly used approaches are the constructs:


```r
# if
if (condition is true) {
  perform action
}

# if ... else
if (condition is true) {
  perform action
} else {  # that is, if the condition is false,
  perform alternative action
}
```

Say, for example, that we want R to print a message if a variable `x` has a particular value:


```r
x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
}

x
```

```{.output}
[1] 8
```

The print statement does not appear in the console because x is not greater than 10. To print a different message for numbers less than 10, we can add an `else` statement.


```r
x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
} else {
  print("x is less than 10")
}
```

```{.output}
[1] "x is less than 10"
```

You can also test multiple conditions by using `else if`.


```r
x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
} else if (x > 5) {
  print("x is greater than 5, but less than 10")
} else {
  print("x is less than 5")
}
```

```{.output}
[1] "x is greater than 5, but less than 10"
```

**Important:** when R evaluates the condition inside `if()` statements, it is
looking for a logical element, i.e., `TRUE` or `FALSE`. This can cause some
headaches for beginners. For example:


```r
x  <-  4 == 3
if (x) {
  "4 equals 3"
} else {
  "4 does not equal 3"
}
```

```{.output}
[1] "4 does not equal 3"
```

As we can see, the not equal message was printed because the vector x is `FALSE`


```r
x <- 4 == 3
x
```

```{.output}
[1] FALSE
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 1

Use an `if()` statement to print a suitable message
reporting whether there are any records from 2002 in
the `gapminder` dataset.
Now do the same for 2012.

:::::::::::::::  solution

## Solution to Challenge 1

We will first see a solution to Challenge 1 which does not use the `any()` function.
We first obtain a logical vector describing which element of `gapminder$year` is equal to `2002`:


```r
gapminder[(gapminder$year == 2002),]
```

Then, we count the number of rows of the data.frame `gapminder` that correspond to the 2002:


```r
rows2002_number <- nrow(gapminder[(gapminder$year == 2002),])
```

The presence of any record for the year 2002 is equivalent to the request that `rows2002_number` is one or more:


```r
rows2002_number >= 1
```

Putting all together, we obtain:


```r
if(nrow(gapminder[(gapminder$year == 2002),]) >= 1){
   print("Record(s) for the year 2002 found.")
}
```

All this can be done more quickly with `any()`. The logical condition can be expressed as:


```r
if(any(gapminder$year == 2002)){
   print("Record(s) for the year 2002 found.")
}
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

Did anyone get a warning message like this?


```{.error}
Error in if (gapminder$year == 2012) {: the condition has length > 1
```

The `if()` function only accepts singular (of length 1) inputs, and therefore
returns an error when you use it with a vector. The `if()` function will still
run, but will only evaluate the condition in the first element of the vector.
Therefore, to use the `if()` function, you need to make sure your input is
singular (of length 1).

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: Built in `ifelse()` function

`R` accepts both `if()` and `else if()` statements structured as outlined above,
but also statements using `R`'s built-in `ifelse()` function. This
function accepts both singular and vector inputs and is structured as
follows:


```r
# ifelse function
ifelse(condition is true, perform action, perform alternative action)
```

where the first argument is the condition or a set of conditions to be met, the
second argument is the statement that is evaluated when the condition is `TRUE`,
and the third statement  is the statement that is evaluated when the condition
is `FALSE`.


```r
y <- -3
ifelse(y < 0, "y is a negative number", "y is either positive or zero")
```

```{.output}
[1] "y is a negative number"
```

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: `any()` and `all()`

The `any()` function will return `TRUE` if at least one
`TRUE` value is found within a vector, otherwise it will return `FALSE`.
This can be used in a similar way to the `%in%` operator.
The function `all()`, as the name suggests, will only return `TRUE` if all values in
the vector are `TRUE`.


::::::::::::::::::::::::::::::::::::::::::::::::::

## Repeating operations

If you want to iterate over
a set of values, when the order of iteration is important, and perform the
same operation on each, a `for()` loop will do the job.
We saw `for()` loops in the shell lessons earlier. This is the most
flexible of looping operations, but therefore also the hardest to use
correctly. In general, the advice of many `R` users would be to learn about
`for()` loops, but to avoid using `for()` loops unless the order of iteration is
important: i.e. the calculation at each iteration depends on the results of
previous iterations. If the order of iteration is not important, then you
should learn about vectorized alternatives, such as the `purrr` package, as they
pay off in computational efficiency.

The basic structure of a `for()` loop is:


```r
for (iterator in set of values) {
  do a thing
}
```

For example:


```r
for (i in 1:10) {
  print(i)
}
```

```{.output}
[1] 1
[1] 2
[1] 3
[1] 4
[1] 5
[1] 6
[1] 7
[1] 8
[1] 9
[1] 10
```

The `1:10` bit creates a vector on the fly; you can iterate
over any other vector as well.

We can use a `for()` loop nested within another `for()` loop to iterate over two things at
once.


```r
for (i in 1:5) {
  for (j in c('a', 'b', 'c', 'd', 'e')) {
    print(paste(i,j))
  }
}
```

```{.output}
[1] "1 a"
[1] "1 b"
[1] "1 c"
[1] "1 d"
[1] "1 e"
[1] "2 a"
[1] "2 b"
[1] "2 c"
[1] "2 d"
[1] "2 e"
[1] "3 a"
[1] "3 b"
[1] "3 c"
[1] "3 d"
[1] "3 e"
[1] "4 a"
[1] "4 b"
[1] "4 c"
[1] "4 d"
[1] "4 e"
[1] "5 a"
[1] "5 b"
[1] "5 c"
[1] "5 d"
[1] "5 e"
```

We notice in the output that when the first index (`i`) is set to 1, the second
index (`j`) iterates through its full set of indices. Once the indices of `j`
have been iterated through, then `i` is incremented. This process continues
until the last index has been used for each `for()` loop.

Rather than printing the results, we could write the loop output to a new object.


```r
output_vector <- c()
for (i in 1:5) {
  for (j in c('a', 'b', 'c', 'd', 'e')) {
    temp_output <- paste(i, j)
    output_vector <- c(output_vector, temp_output)
  }
}
output_vector
```

```{.output}
 [1] "1 a" "1 b" "1 c" "1 d" "1 e" "2 a" "2 b" "2 c" "2 d" "2 e" "3 a" "3 b"
[13] "3 c" "3 d" "3 e" "4 a" "4 b" "4 c" "4 d" "4 e" "5 a" "5 b" "5 c" "5 d"
[25] "5 e"
```

This approach can be useful, but 'growing your results' (building
the result object incrementally) is computationally inefficient, so avoid
it when you are iterating through a lot of values.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: don't grow your results

One of the biggest things that trips up novices and
experienced R users alike, is building a results object
(vector, list, matrix, data frame) as your for loop progresses.
Computers are very bad at handling this, so your calculations
can very quickly slow to a crawl. It's much better to define
an empty results object before hand of appropriate dimensions, rather
than initializing an empty object without dimensions.
So if you know the end result will be stored in a matrix like above,
create an empty matrix with 5 row and 5 columns, then at each iteration
store the results in the appropriate location.


::::::::::::::::::::::::::::::::::::::::::::::::::

A better way is to define your (empty) output object before filling in the values.
For this example, it looks more involved, but is still more efficient.


```r
output_matrix <- matrix(nrow = 5, ncol = 5)
j_vector <- c('a', 'b', 'c', 'd', 'e')
for (i in 1:5) {
  for (j in 1:5) {
    temp_j_value <- j_vector[j]
    temp_output <- paste(i, temp_j_value)
    output_matrix[i, j] <- temp_output
  }
}
output_vector2 <- as.vector(output_matrix)
output_vector2
```

```{.output}
 [1] "1 a" "2 a" "3 a" "4 a" "5 a" "1 b" "2 b" "3 b" "4 b" "5 b" "1 c" "2 c"
[13] "3 c" "4 c" "5 c" "1 d" "2 d" "3 d" "4 d" "5 d" "1 e" "2 e" "3 e" "4 e"
[25] "5 e"
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip: While loops

Sometimes you will find yourself needing to repeat an operation as long as a certain
condition is met. You can do this with a `while()` loop.


```r
while(this condition is true){
  do a thing
}
```

R will interpret a condition being met as "TRUE".

As an example, here's a while loop
that generates random numbers from a uniform distribution (the `runif()` function)
between 0 and 1 until it gets one that's less than 0.1.

```r
z <- 1
while(z > 0.1){
  z <- runif(1)
  cat(z, "\n")
}
```

`while()` loops will not always be appropriate. You have to be particularly careful
that you don't end up stuck in an infinite loop because your condition is always met and hence the while statement never terminates.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 2

Compare the objects `output_vector` and
`output_vector2`. Are they the same? If not, why not?
How would you change the last block of code to make `output_vector2`
the same as `output_vector`?

:::::::::::::::  solution

## Solution to Challenge 2

We can check whether the two vectors are identical using the `all()` function:


```r
all(output_vector == output_vector2)
```

However, all the elements of `output_vector` can be found in `output_vector2`:


```r
all(output_vector %in% output_vector2)
```

and vice versa:


```r
all(output_vector2 %in% output_vector)
```

therefore, the element in `output_vector` and `output_vector2` are just sorted in a different order.
This is because `as.vector()` outputs the elements of an input matrix going over its column.
Taking a look at `output_matrix`, we can notice that we want its elements by rows.
The solution is to transpose the `output_matrix`. We can do it either by calling the transpose function
`t()` or by inputting the elements in the right order.
The first solution requires to change the original


```r
output_vector2 <- as.vector(output_matrix)
```

into


```r
output_vector2 <- as.vector(t(output_matrix))
```

The second solution requires to change


```r
output_matrix[i, j] <- temp_output
```

into


```r
output_matrix[j, i] <- temp_output
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 3

Write a script that loops through the `gapminder` data by continent and prints out
whether the mean life expectancy is smaller or larger than 50
years.

:::::::::::::::  solution

## Solution to Challenge 3

**Step 1**:  We want to make sure we can extract all the unique values of the continent vector


```r
gapminder <- read.csv("data/gapminder_data.csv")
unique(gapminder$continent)
```

**Step 2**: We also need to loop over each of these continents and calculate the average life expectancy for each `subset` of data.
We can do that as follows:

1. Loop over each of the unique values of 'continent'
2. For each value of continent, create a temporary variable storing that subset
3. Return the calculated life expectancy to the user by printing the output:


```r
for (iContinent in unique(gapminder$continent)) {
  tmp <- gapminder[gapminder$continent == iContinent, ]
  cat(iContinent, mean(tmp$lifeExp, na.rm = TRUE), "\n")
  rm(tmp)
}
```

**Step 3**: The exercise only wants the output printed if the average life expectancy is less than 50 or greater than 50.
So we need to add an `if()` condition before printing, which evaluates whether the calculated average life expectancy is above or below a threshold, and prints an output conditional on the result.
We need to amend (3) from above:

3a. If the calculated life expectancy is less than some threshold (50 years), return the continent and a statement that life expectancy is less than threshold, otherwise return the continent and a statement that life expectancy is greater than threshold:


```r
thresholdValue <- 50

for (iContinent in unique(gapminder$continent)) {
   tmp <- mean(gapminder[gapminder$continent == iContinent, "lifeExp"])

   if (tmp < thresholdValue){
       cat("Average Life Expectancy in", iContinent, "is less than", thresholdValue, "\n")
   } else {
       cat("Average Life Expectancy in", iContinent, "is greater than", thresholdValue, "\n")
   } # end if else condition
   rm(tmp)
} # end for loop
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 4

Modify the script from Challenge 3 to loop over each
country. This time print out whether the life expectancy is
smaller than 50, between 50 and 70, or greater than 70.

:::::::::::::::  solution

## Solution to Challenge 4

We modify our solution to Challenge 3 by now adding two thresholds, `lowerThreshold` and `upperThreshold` and extending our if-else statements:


```r
 lowerThreshold <- 50
 upperThreshold <- 70

for (iCountry in unique(gapminder$country)) {
    tmp <- mean(gapminder[gapminder$country == iCountry, "lifeExp"])

    if(tmp < lowerThreshold) {
        cat("Average Life Expectancy in", iCountry, "is less than", lowerThreshold, "\n")
    } else if(tmp > lowerThreshold && tmp < upperThreshold) {
        cat("Average Life Expectancy in", iCountry, "is between", lowerThreshold, "and", upperThreshold, "\n")
    } else {
        cat("Average Life Expectancy in", iCountry, "is greater than", upperThreshold, "\n")
    }
    rm(tmp)
}
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  challenge

## Challenge 5 - Advanced

Write a script that loops over each country in the `gapminder` dataset,
tests whether the country starts with a 'B', and graphs life expectancy
against time as a line graph if the mean life expectancy is under 50 years.

:::::::::::::::  solution

## Solution for Challenge 5

We will use the `grep()` command that was introduced in the Unix Shell lesson to find countries that start with "B."
Lets understand how to do this first.
Following from the Unix shell section we may be tempted to try the following


```r
grep("^B", unique(gapminder$country))
```

But when we evaluate this command it returns the indices of the factor variable `country` that start with "B."
To get the values, we must add the `value=TRUE` option to the `grep()` command:


```r
grep("^B", unique(gapminder$country), value = TRUE)
```

We will now store these countries in a variable called candidateCountries, and then loop over each entry in the variable.
Inside the loop, we evaluate the average life expectancy for each country, and if the average life expectancy is less than 50 we use base-plot to plot the evolution of average life expectancy using `with()` and `subset()`:


```r
thresholdValue <- 50
candidateCountries <- grep("^B", unique(gapminder$country), value = TRUE)

for (iCountry in candidateCountries) {
    tmp <- mean(gapminder[gapminder$country == iCountry, "lifeExp"])

    if (tmp < thresholdValue) {
        cat("Average Life Expectancy in", iCountry, "is less than", thresholdValue, "plotting life expectancy graph... \n")

        with(subset(gapminder, country == iCountry),
                plot(year, lifeExp,
                     type = "o",
                     main = paste("Life Expectancy in", iCountry, "over time"),
                     ylab = "Life Expectancy",
                     xlab = "Year"
                     ) # end plot
             ) # end with
    } # end if
    rm(tmp)
} # end for loop
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Use `if` and `else` to make choices.
- Use `for` to repeat operations.

::::::::::::::::::::::::::::::::::::::::::::::::::


