install.packages("ggplot2")

library(ggplot2)

gapminder <-read.table("gapminder.txt", header = TRUE)

head(gapminder)

ggplot(data = gapminder, aes(x = year, y = lifeExp, by = country)) + 
  geom_line(color = 'blue') +
  geom_point()

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point(size = 3.5, shape = 17) + 
  scale_x_log10() +
  geom_smooth(method = 'lm')

az_row <- startsWith(as.vector(gapminder$country), c('A','Z'))
az_countries <- gapminder[az_row, ]
lifeExpplot <- ggplot(data = az_countries, aes(x = year, y = lifeExp, color=continent)) +
  geom_line() + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Life expectancy",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) +
  theme(axis.text.x=element_text(angle=45), axis.ticks.x=element_blank())

ggsave(filename = "lifeExp.png", plot = lifeExpplot, width = 12, height = 10, dpi = 300, units = "cm")


#Challenge 6a

Canlifeexp <-  gapminder[gapminder$country == 'Canada', ]
ggplot(data = Canlifeexp, aes(x = year, y = lifeExp)) +
  geom_col()


#Challenge 6b

erow <- startsWith(as.vector(gapminder$country), 'E')
popsize <-  gapminder[erow, ]
ecountplot <- ggplot(data = popsize, aes(x = year, y = pop/1000000)) +
  geom_bar(stat = 'identity') + facet_wrap( ~ country) +
  labs(
    x = "Year",              # x axis title
    y = "Population (in millions)",   # y axis title
    title = "Figure 1",      # main title of figure
    color = "Continent"      # title of legend
  ) 

ggsave(filename = "PopofEcountries.png", plot = ecountplot, width = 12, height = 10, dpi = 300, units = "cm")
