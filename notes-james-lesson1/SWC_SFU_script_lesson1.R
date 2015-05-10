
### Script for SFU SWC workshop - introduction to R with the Gapminder dataset

## Introduce R studio - 4 panels etc..

## Introduce projects - way of keeping code, data, figures, analyses, tables etc. all together in one directory

## This avoids keeping scripts in one location away from text + data - 
## think of papers + projects as a single directory on your computer.

### Talk about Git - but don't open Git. Focus on R.

### Talk about file names - make them explicit and easy to read.

### Before ANYTHING. Use R as a calculator in the console. Talk about shortcuts. Show example of missing + or missing ).

## You can use Esc to get out of a console problem.

## Read in data without assigning. PUT DATA IN THE PROJECT FOLDER.

### COMMENTING - mention

gapminder<-read.csv("/Users/jpwrobinson/Desktop/SWC_SFU_R/gapminder-FiveYearData.csv")
read.csv("gapminder-FiveYearData.csv")


## How do we tell R to save objects?

100
a<-100
a*22

mass<-100
masses<-c(10, 100, 50, 60)


### quick introduction to help in R
?read.csv


### Now we can use the same approach to save our gapminder data.
gapminder<-read.csv("gapminder-FiveYearData.csv")

## Appears in top right. 

## How do we look through our data?

head(gapminder)
tail(gapminder)

dim(gapminder)
class(gapminder)
str(gapminder)
colnames(gapminder)
### Talk about different data structures in R.

### Data frames are the most commonly used for reading in experimental data, remote sensing, observations etc.

## Matrices might be more commonly used in mathematical modelling, or simulations.

## Lists are useful for containing multiple data structures - 
## e.g. multiple data frames in a single object, or a data frame and a matrix.

### How do we index a data frame - how do we use R to pull out specific rows + columns?

## Talk about rows + columns

gapminder[1,]
gapminder[1,1]
gapminder[10, 10]   ### What is this telling us?
gapminder[10,6]

## Data frames also informative column names. We call these with $ signs
gapminder$country


### SOCRATIVE QUESTION
#### Q: What does gapminder$country[100] tell us?
#### Correct answers: 
## A) The country value in the 100th row of the gapminder dataframe
### B) Bangladesh


###  Simple functions: min, max, mean, sd
### Use ? to find out how to use these functions
colnames(gapminder)

max(gapminder$lifeExp)
min(gapminder$pop)
summary(gapminder$gdpPercap)
unique(gapminder$country)

### Introduce levels for factors
class(gapminder$country)
levels(gapminder$country)


## Ok. All very well, but we really want to use R for more complex calculations. We could easily find the mean in excel.
## With data frames, you should develop your subsetting skills. A few simple commands go a long way in helping you 
## understand your dataframe.

## Logical commands
## in R, a double equals (==) is a logical operator. It asks - is X exactly = to Y?

gapminder$country=="United Kingdom"  ### what does this say?

#  we want all of the records for UK = TRUE
gapminder[gapminder$country=="United Kingdom",]

### also use which()
gapminder[which(gapminder$country=="United Kingdom"),]
## also works for numbers...
gapminder[gapminder$pop<100000,]
## we can combine commands...
gapminder[gapminder$pop<100000 & gapminder$year==1952,]
gapminder[gapminder$pop<500000 & gapminder$pop>10000,]

## What does the comma represent?

## We can now wrap our subset inside a function
unique(gapminder$country[gapminder$pop<500000 & gapminder$pop>10000])


### SOCRATIVE QUESTION::
## How would you estimate the mean population size across all of the Asian countries in gapminder?
## Many ways to do this.

### COMMENT AFTER WORKSHOP: This was perhaps a little complicated.
### Maybe just use subset() instead - more intuitive for beginners.

### Aggregate lets us calculate summary statistics on different sections of the data frame:
?aggregate

aggregate(pop ~ country, gapminder, mean)
mean_pop<-aggregate(cbind(pop, lifeExp) ~ country + continent, gapminder, mean)

## and by life exp...
aggregate(lifeExp ~ continent + year, gapminder, mean)


write.csv(mean_pop, file="mean_pop_bycountry_gapminder.csv")


#### CHALLENGE

### Which country has the maximum life expectancy between 1980-1989, in Asia?
## Answer: Japan. Get students to write this in the etherpad.

### Now, can we plot our results. Plotting in R - discuss....

plot(mean_pop$pop)  ## this isn't particularly useful - just has order on the x axis

plot(mean_pop$pop ~ mean_pop$country)  ## let's log population to deal with the large variability
plot(log(mean_pop$pop) ~ mean_pop$country)  ## we can also boxplot - more informative?  
plot(log(mean_pop$pop) ~ mean_pop$continent)

## return to the original dataset
plot(gapminder$lifeExp ~ log(gapminder$pop))
plot(gapminder$lifeExp ~ log(gapminder$pop), col=gapminder$continent)
text(gapminder$lifeExp ~ log(gapminder$pop), labels=gapminder$country, col=as.numeric(gapminder$continent))

##### EXTRA WORK ###########################


## we can also sort our values...
mean_pop_sorted<-mean_pop[order(mean_pop$pop),]
head(mean_pop_sorted)
tail(mean_pop_sorted)
## does it work??
plot(mean_pop_sorted$pop ~ mean_pop_sorted$country)
## no. why not?

levels(mean_pop_sorted$country)

mean_pop_sorted$country<-reorder(mean_pop_sorted$country, mean_pop_sorted$pop)
plot(mean_pop_sorted$pop ~ mean_pop_sorted$country) ## log it!
plot(log(mean_pop_sorted$pop) ~ mean_pop_sorted$country, fill=mean_pop_sorted$continent)

topten<-tail(mean_pop_sorted, 10)
plot(log(topten$pop) ~ topten$country)

## NOW WHAT????
levels(topten$country)
topten$country<-droplevels(topten$country)
plot(log(topten$pop) ~ topten$country)
### END WITH SOCRATIVE ON PLOTTING


