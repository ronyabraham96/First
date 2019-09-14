## Install ggplot2
install.packages("ggplot2")

## Load package into R
library(ggplot2)

## Load data
gapminder <- read.table("gapminder.txt", header = TRUE, sep = "\t")

## View data
head(gapminder)

##### example plot ######
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()
### call function and select global option (important for when adding layers)
### aes specifies the aesthetic properties (x,y)
### + geom_point acctually applies the geometric object (in this case the points)

## break into peices
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))
### now this isnt enough to actually draw a figure

## tell ggplot how to visually represent the data
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()
### + geom_point() tells ggplot to visually represent x and y and a scatterplot of points

# three components that must be specified to build a plot
## data
## aesthetic mappings (aes)
## geometric objects (geom)
######

###### Challenge 1 ########
## Modify the example above so that the figure shows how life expectancy has changed over time ##
###### Answer 1 ######
ggplot(data = gapminder, aes(x = year, y = lifeExp)) + geom_point()
######

###### Challenge 2 ########
## Another aes property we can modify is point color. Modify the code from challenge 1
## to change the color of the point to represent the "continent" column
###### Answer 2 ######
ggplot(data = gapminder, aes(x = year, y = lifeExp, color=continent)) + geom_point()
######

###### layers ########
# layers are added with the + operator
# above, geom_point() was a layer containing points
# scatter plot isnt the best for looking at change over time, let use line plots
ggplot(data = gapminder, aes(x=year, y=lifeExp, color=continent)) + 
  geom_line() 
## doesnt really make sense as its combining all the countries in each continent

## by adding "by=country" we get a line for every country and color it by continent 
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) + 
  geom_line() 
## dont try and do color by country as there are so many your computer might slow down 
## and you still wont get a visable graph
## trust me, i tried

## add another layer to view points
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country, color=continent)) + 
  geom_line() +
  geom_point()

## lets just apply the color = continent to the lines
## you have to specify its an aes property of geom_line due to it coming from a variable
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) + 
  geom_line(aes(color=continent)) +
  geom_point()

## what if i want to change all the colors to blue
## you might think i just use geom_line(aes(color="blue"))
## but im not mapping to a variable so i use
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) + 
  geom_line(color="blue") +
  geom_point()
######

###### Challenge 3 ######
## switch the order of the point and line layers from the previous example.
## what happened?
###### Answer 3 ######
ggplot(data = gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_point() + 
  geom_line(aes(color=continent))
## lines are now drawn over points 
######

###### Transformations and stats ######

## lets go back to original example
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color=continent)) +
  geom_point()

## we can change the scale with the scale function
## and modify transparency of points with the alpha function
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10()
## the log10 applied a transformation so that multiples of 10 only correspond to an increase in 1
## remember, using a setting outside of the aes() will cause this for all points

## fit a simple relationship
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method="lm")

## can change the size of the lm
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method="lm", size=1.5)
######

###### Challenge 4 ######
## modify the color and size of the points on the point later
## hint: dont use aes()
###### Answer 4 ######
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size=3, color="orange") + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)
######

###### Challenge 5 ######
## modify your answer to challenge 4  so that the points are now a different shape
## and are colored by continent with a new trend line
## hint: use color argument inside aes()
## see here about shapes (https://ggplot2.tidyverse.org/articles/ggplot2-specs.html#point)
###### Answer 5 ######
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size=3, shape=17) + 
  scale_x_log10() +
  geom_smooth(method="lm", size=1.5)
######

###### Multi-panel figures ######
## tip, can subset the data with "startsWith" function
az_rows <- startsWith(as.vector(gapminder$country), c('A','Z') )
az_countries <- gapminder[az_rows, ]
ggplot(data = az_countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() +
  facet_wrap( ~ country)
## the facet_wrap layer took a formula as its argument denoted by a tilde (~)
## this tells R to draw a panel for each unique value in the country column
######

###### Modifying text ######
## labels and any legend can be set using the "labs" function
## legend titles are set using the same names from aes
ggplot(data = az_countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + 
  facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x=element_text(angle=45), axis.ticks.x=element_blank())
######

###### Exporting the Plot ######
## ggsave() allows you to export plot
## first save plot to variable
lifeExp_plot <- ggplot(data = az_countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + 
  facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x=element_text(angle=45), axis.ticks.x=element_blank())

## then export 
ggsave(filename = "lifeExp.png", plot = lifeExp_plot, width = 12, height = 10, dpi = 300, units = "cm")
## note, if you dont save plot to a variable you can still export which 
## defaults to the last plot made
ggsave("myPlot.pdf")
######

###### bar plot challenges ######
###### Challenge 6a ######
## plot life exp. over years for a country of your choice using geom_bar()
## Hint: use ?geom_bar and know diff. between stat="count" and stat="identity"

###### Challenge 6b ######
## prepare a figure for publication (add labels, titles, etc.,) to show population size
## over years for every country that starts with the letter 'E'
## Hint: follow example from earlier

###### Challenge 6c ######
## can you explain what info is being plotted with this code
## ggplot(data=gapminder, aes(x=continent, y=lifeExp)) + 
##    geom_bar(aes(fill = continent), stat="summary",fun.y="mean")

###### Answer 6a ######
## you must specify stat="identity" to get lifeExp on y axis:
ggplot(data =gapminder[gapminder$country=="Sweden", ], aes(x = year, y = lifeExp)) +
  geom_bar(fill='orange', stat="identity")

## the default stat for geom_bar() is stat="count". In this case, the number of observations
## for every year is plotted:
ggplot(data =gapminder[gapminder$country=="Sweden", ], aes(x = year)) +
  geom_bar(fill='orange')

###### Answer 6b ######
e_rows=startsWith(as.vector(gapminder$country), c('E') )
e_countries <- gapminder[e_rows, ]
ggplot(data = e_countries, aes(x = year, y = pop/1000000, fill=continent)) +
  geom_bar(stat="identity") + facet_wrap( ~ country) +
  labs(
    x = "Year",                     # x axis title
    y = "Population (Million)",     # y axis title
    title = "Figure 1",             # main title of figure
    fill = "Continent"              # title of legend
  ) +
  theme(axis.text.x=element_text(angle=45), axis.ticks.x=element_blank()) +
  theme_bw()

###### Answer 6c ######
## A barplot of average life expectancy across years and countries for every continent.
######


###### Advanced Features ######
library(dplyr)
bubble <- gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent,
             size = pop)) +
  geom_point() + 
  labs(
    x = "Income",            # x axis title
    y = "Life expectancy"    # y axis title
  )
bubble

## lets go more interactive
install.packages("plotly")
library(plotly)

# plotly has built in support for `ggplot` objects
bubble2 <- gapminder %>%
  filter(year == 2007) %>%
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             color = continent,
             size = pop,
             text = country)) +
  geom_point() + 
  labs(
    x = "Income",            # x axis title
    y = "Life expectancy"    # y axis title
  )

ggplotly(bubble2)


