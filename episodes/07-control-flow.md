---
title: Control Flow
teaching: 45
exercises: 20
questions:
- "How can I make data-dependent choices in R?"
- "How can I repeat operations in R?"
objectives:
- "Write conditional statements with `if()` and `else()`."
- "Write and understand `for()` loops."
keypoints:
- "Use `if` and `else` to make choices."
- "Use `for` to repeat operations."
source: Rmd
---



Often when we're coding we want to control the flow of our actions. This can be done
by setting actions to occur only if a condition or a set of conditions are met.
Alternatively, we can also set an action to occur a particular number of times.

There are several ways you can control flow in R.
For conditional statements, the most commonly used approaches are the constructs:


~~~
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
~~~
{: .language-r}

Say, for example, that we want R to print a message if a variable `x` has a particular value:


~~~
# sample a random number from a Poisson distribution
# with a mean (lambda) of 8

x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
}

x
~~~
{: .language-r}



~~~
[1] 8
~~~
{: .output}

The print statement does not appear in the console because x is not greater than 10. To print a different message for numbers less than 10, we can add an `else` statement.


~~~
x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
} else {
  print("x is less than 10")
}
~~~
{: .language-r}



~~~
[1] "x is less than 10"
~~~
{: .output}

You can also test multiple conditions by using `else if`.


~~~
x <- 8

if (x >= 10) {
  print("x is greater than or equal to 10")
} else if (x > 5) {
  print("x is greater than 5, but less than 10")
} else {
  print("x is less than 5")
}
~~~
{: .language-r}



~~~
[1] "x is greater than 5, but less than 10"
~~~
{: .output}

**Important:** when R evaluates the condition inside `if()` statements, it is
looking for a logical element, i.e., `TRUE` or `FALSE`. This can cause some
headaches for beginners. For example:


~~~
x  <-  4 == 3
if (x) {
  "4 equals 3"
} else {
  "4 does not equal 3"          
}
~~~
{: .language-r}



~~~
[1] "4 does not equal 3"
~~~
{: .output}

As we can see, the not equal message was printed because the vector x is `FALSE`


~~~
x <- 4 == 3
x
~~~
{: .language-r}



~~~
[1] FALSE
~~~
{: .output}

> ## Challenge 1
>
> Use an `if()` statement to print a suitable message
> reporting whether there are any records from 2002 in
> the `gapminder` dataset.
> Now do the same for 2012.
>
> > ## Solution to Challenge 1
> > We will first see a solution to Challenge 1 which does not use the `any()` function.
> > We first obtain a logical vector describing which element of `gapminder$year` is equal to `2002`:
> > 
> > ~~~
> > gapminder[(gapminder$year == 2002),]
> > ~~~
> > {: .language-r}
> > Then, we count the number of rows of the data.frame `gapminder` that correspond to the 2002:
> > 
> > ~~~
> > rows2002_number <- nrow(gapminder[(gapminder$year == 2002),])
> > ~~~
> > {: .language-r}
> > The presence of any record for the year 2002 is equivalent to the request that `rows2002_number` is one or more:
> > 
> > ~~~
> > rows2002_number >= 1
> > ~~~
> > {: .language-r}
> > Putting all together, we obtain:
> > 
> > ~~~
> > if(nrow(gapminder[(gapminder$year == 2002),]) >= 1){
> >    print("Record(s) for the year 2002 found.")
> > }
> > ~~~
> > {: .language-r}
> >
> > All this can be done more quickly with `any()`. The logical condition can be expressed as:
> > 
> > ~~~
> > if(any(gapminder$year == 2002)){
> >    print("Record(s) for the year 2002 found.")
> > }
> > ~~~
> > {: .language-r}
> >
> {: .solution}
{: .challenge}


Did anyone get a warning message like this?


~~~
Warning in if (gapminder$year == 2012) {: the condition has length > 1 and
only the first element will be used
~~~
{: .error}

If your condition evaluates to a vector with more than one logical element,
the function `if()` will still run, but will only evaluate the condition in the first
element. Here you need to make sure your condition is of length 1.

> ## Tip: `any()` and `all()`
>
> The `any()` function will return TRUE if at least one
> TRUE value is found within a vector, otherwise it will return `FALSE`.
> This can be used in a similar way to the `%in%` operator.
> The function `all()`, as the name suggests, will only return `TRUE` if all values in
> the vector are `TRUE`.
{: .callout}

## Repeating operations

If you want to iterate over
a set of values, when the order of iteration is important, and perform the
same operation on each, a `for()` loop will do the job.
We saw `for()` loops in the shell lessons earlier. This is the most
flexible of looping operations, but therefore also the hardest to use
correctly. Avoid using `for()` loops unless the order of iteration is important:
i.e. the calculation at each iteration depends on the results of previous iterations.

The basic structure of a `for()` loop is:


~~~
for(iterator in set of values){
  do a thing
}
~~~
{: .language-r}

For example:


~~~
for(i in 1:10){
  print(i)
}
~~~
{: .language-r}



~~~
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
~~~
{: .output}

The `1:10` bit creates a vector on the fly; you can iterate
over any other vector as well.

We can use a `for()` loop nested within another `for()` loop to iterate over two things at
once.


~~~
for(i in 1:5){
  for(j in c('a', 'b', 'c', 'd', 'e')){
    print(paste(i,j))
  }
}
~~~
{: .language-r}



~~~
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
~~~
{: .output}

Rather than printing the results, we could write the loop output to a new object.


~~~
output_vector <- c()
for(i in 1:5){
  for(j in c('a', 'b', 'c', 'd', 'e')){
    temp_output <- paste(i, j)
    output_vector <- c(output_vector, temp_output)
  }
}
output_vector
~~~
{: .language-r}



~~~
 [1] "1 a" "1 b" "1 c" "1 d" "1 e" "2 a" "2 b" "2 c" "2 d" "2 e" "3 a"
[12] "3 b" "3 c" "3 d" "3 e" "4 a" "4 b" "4 c" "4 d" "4 e" "5 a" "5 b"
[23] "5 c" "5 d" "5 e"
~~~
{: .output}

This approach can be useful, but 'growing your results' (building
the result object incrementally) is computationally inefficient, so avoid
it when you are iterating through a lot of values.

> ## Tip: don't grow your results
>
> One of the biggest things that trips up novices and
> experienced R users alike, is building a results object
> (vector, list, matrix, data frame) as your for loop progresses.
> Computers are very bad at handling this, so your calculations
> can very quickly slow to a crawl. It's much better to define
> an empty results object before hand of the appropriate dimensions.
> So if you know the end result will be stored in a matrix like above,
> create an empty matrix with 5 row and 5 columns, then at each iteration
> store the results in the appropriate location.
{: .callout}

A better way is to define your (empty) output object before filling in the values.
For this example, it looks more involved, but is still more efficient.


~~~
output_matrix <- matrix(nrow=5, ncol=5)
j_vector <- c('a', 'b', 'c', 'd', 'e')
for(i in 1:5){
  for(j in 1:5){
    temp_j_value <- j_vector[j]
    temp_output <- paste(i, temp_j_value)
    output_matrix[i, j] <- temp_output
  }
}
output_vector2 <- as.vector(output_matrix)
output_vector2
~~~
{: .language-r}



~~~
 [1] "1 a" "2 a" "3 a" "4 a" "5 a" "1 b" "2 b" "3 b" "4 b" "5 b" "1 c"
[12] "2 c" "3 c" "4 c" "5 c" "1 d" "2 d" "3 d" "4 d" "5 d" "1 e" "2 e"
[23] "3 e" "4 e" "5 e"
~~~
{: .output}

> ## Tip: While loops
>
>
> Sometimes you will find yourself needing to repeat an operation until a certain
> condition is met. You can do this with a `while()` loop.
>
> 
> ~~~
> while(this condition is true){
>   do a thing
> }
> ~~~
> {: .language-r}
>
> As an example, here's a while loop
> that generates random numbers from a uniform distribution (the `runif()` function)
> between 0 and 1 until it gets one that's less than 0.1.
>
> ~~~
> z <- 1
> while(z > 0.1){
>   z <- runif(1)
>   print(z)
> }
> ~~~
> {: .r}
>
> `while()` loops will not always be appropriate. You have to be particularly careful
> that you don't end up in an infinite loop because your condition is never met.
{: .callout}


> ## Challenge 2
>
> Compare the objects output_vector and
> output_vector2. Are they the same? If not, why not?
> How would you change the last block of code to make output_vector2
> the same as output_vector?
>
> > ## Solution to Challenge 2
> > We can check whether the two vectors are identical using the `all()` function:
> > 
> > ~~~
> > all(output_vector == output_vector2)
> > ~~~
> > {: .language-r}
> > However, all the elements of `output_vector` can be found in `output_vector2`:
> > 
> > ~~~
> > all(output_vector %in% output_vector2)
> > ~~~
> > {: .language-r}
> > and vice versa:
> > 
> > ~~~
> > all(output_vector2 %in% output_vector)
> > ~~~
> > {: .language-r}
> > therefore, the element in `output_vector` and `output_vector2` are just sorted in a different order.
> > This is because `as.vector()` outputs the elements of an input matrix going over its column.
> > Taking a look at `output_matrix`, we can notice that we want its elements by rows.
> > The solution is to transpose the `output_matrix`. We can do it either by calling the transpose function
> > `t()` or by inputing the elements in the right order.
> > The first solution requires to change the original
> > 
> > ~~~
> > output_vector2 <- as.vector(output_matrix)
> > ~~~
> > {: .language-r}
> > into
> > 
> > ~~~
> > output_vector2 <- as.vector(t(output_matrix))
> > ~~~
> > {: .language-r}
> > The second solution requires to change
> > 
> > ~~~
> > output_matrix[i, j] <- temp_output
> > ~~~
> > {: .language-r}
> > into
> > 
> > ~~~
> > output_matrix[j, i] <- temp_output
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

> ## Challenge 3
>
> Write a script that loops through the `gapminder` data by continent and prints out
> whether the mean life expectancy is smaller or larger than 50
> years.
>
> > ## Solution to Challenge 3
> >
> > **Step 1**:  We want to make sure we can extract all the unique values of the continent vector
> > 
> > ~~~
> > gapminder <- read.csv("data/gapminder-FiveYearData.csv")
> > unique(gapminder$continent)
> > ~~~
> > {: .language-r}
> >
> > **Step 2**: We also need to loop over each of these continents and calculate the average life expectancy for each `subset` of data.
> > We can do that as follows:
> >
> > 1. Loop over each of the unique values of 'continent'
> > 2. For each value of continent, create a temporary variable storing the life exepectancy for that subset,
> > 3. Return the calculated life expectancy to the user by printing the output:
> >
> > 
> > ~~~
> > for( iContinent in unique(gapminder$continent) ){
> >    tmp <- mean(subset(gapminder, continent==iContinent)$lifeExp)
> >    cat("Average Life Expectancy in", iContinent, "is", tmp, "\n")
> >    rm(tmp)
> > }
> > ~~~
> > {: .language-r}
> >
> > **Step 3**: The exercise only wants the output printed if the average life expectancy is less than 50 or greater than 50. So we need to add an `if` condition before printing.
> > So we need to add an `if` condition before printing, which evaluates whether the calculated average life expectancy is above or below a threshold, and print an output conditional on the result.
> > We need to amend (3) from above:
> >
> > 3a. If the calculated life expectancy is less than some threshold (50 years), return the continent and a statement that life expectancy is less than threshold, otherwise return the continent and   a statement that life expectancy is greater than threshold,:
> >
> > 
> > ~~~
> > thresholdValue <- 50
> > 
> > for( iContinent in unique(gapminder$continent) ){
> >    tmp <- mean(subset(gapminder, continent==iContinent)$lifeExp)
> >    
> >    if(tmp < thresholdValue){
> >        cat("Average Life Expectancy in", iContinent, "is less than", thresholdValue, "\n")
> >    }
> >    else{
> >        cat("Average Life Expectancy in", iContinent, "is greater than", thresholdValue, "\n")
> >         } # end if else condition
> >    rm(tmp)
> >    } # end for loop
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

> ## Challenge 4
>
> Modify the script from Challenge 3 to loop over each
> country. This time print out whether the life expectancy is
> smaller than 50, between 50 and 70, or greater than 70.
>
> > ## Solution to Challenge 4
> >  We modify our solution to Challenge 3 by now adding two thresholds, `lowerThreshold` and `upperThreshold` and extending our if-else statements:
> >
> > 
> > ~~~
> >  lowerThreshold <- 50
> >  upperThreshold <- 70
> >  
> > for( iCountry in unique(gapminder$country) ){
> >     tmp <- mean(subset(gapminder, country==iCountry)$lifeExp)
> >     
> >     if(tmp < lowerThreshold){
> >         cat("Average Life Expectancy in", iCountry, "is less than", lowerThreshold, "\n")
> >     }
> >     else if(tmp > lowerThreshold && tmp < upperThreshold){
> >         cat("Average Life Expectancy in", iCountry, "is between", lowerThreshold, "and", upperThreshold, "\n")
> >     }
> >     else{
> >         cat("Average Life Expectancy in", iCountry, "is greater than", upperThreshold, "\n")
> >     }
> >     rm(tmp)
> > }
> > ~~~
> > {: .language-r}
> {: .solution}
{: .challenge}

> ## Challenge 5 - Advanced
>
> Write a script that loops over each country in the `gapminder` dataset,
> tests whether the country starts with a 'B', and graphs life expectancy
> against time as a line graph if the mean life expectancy is under 50 years.
>
> > ## Solution for Challenge 5
> >
> > We will use the `grep` command that was introduced in the Unix Shell lesson to find countries that start with "B."
> > Lets understand how to do this first.
> > Following from the Unix shell section we may be tempted to try the following
> > 
> > ~~~
> > grep("^B", unique(gapminder$country))
> > ~~~
> > {: .language-r}
> >
> > But when we evaluate this command it returns the indices of the factor variable `country` that start with "B."
> > To get the values, we must add the `value=TRUE` option to the `grep` command:
> >
> > 
> > ~~~
> > grep("^B", unique(gapminder$country), value=TRUE)
> > ~~~
> > {: .language-r}
> >
> > We will now store these countries in a variable called candidateCountries, and then loop over each entry in the variable.
> > Inside the loop, we evaluate the average life expectancy for each country, and if the average life expectancy is less than 50 we use base-plot to plot the evolution of average life expectancy:
> >
> > 
> > ~~~
> > thresholdValue <- 50
> > candidateCountries <- grep("^B", unique(gapminder$country), value=TRUE)
> > 
> > for( iCountry in candidateCountries){
> >     tmp <- mean(subset(gapminder, country==iCountry)$lifeExp)
> >     
> >     if(tmp < thresholdValue){
> >         cat("Average Life Expectancy in", iCountry, "is less than", thresholdValue, "plotting life expectancy graph... \n")
> >         
> >         with(subset(gapminder, country==iCountry),
> >                 plot(year,lifeExp,
> >                      type="o",
> >                      main = paste("Life Expectancy in", iCountry, "over time"),
> >                      ylab = "Life Expectancy",
> >                      xlab = "Year"
> >                    ) # end plot
> >               ) # end with
> >     } # end for loop
> >     rm(tmp)
> >  }```
> > > {: .solution}
> > {: .challenge}
> > ~~~
> > {: .language-r}
