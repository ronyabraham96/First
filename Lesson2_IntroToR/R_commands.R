#My first R command
print("Good Morning")

name <- 'Rony'
price <- 5.00
print(price)
ls()
rm(price)
ls()

mass <- 47.5
age <- 122
mass <- mass * 2.3
age <- age - 20
height <- 0
height <- height + 20
mass <- 64
result <- sqrt(mass)

?print
help(print)

getwd()

#installing packages

install.packages("knitr")
library(knitr)

score <- 79
typeof(score)

v <- c(4,5,6)
v <- c(1:3, 12, 12)
length(v)
head(v, n=2)

?str
v <- c(v,211)
str(v)

m <- matrix(c(1:18),3,6)
m

cont <- factor(c("asia", "europe","america"))
str(cont)

menu <- c("chicken","soup","salad","tea")
menutypes <- factor(c("solid","liquid","solid","liquid"))
menucost <- c(4.99,2.99,3.29,1.89)
l <- list(menu,menutypes,menucost)
print(l)

df <- data.frame(menu,menutypes,menucost)
print(df)

v <- c(2:10)
v[2]          #subset
v[c(3:6)]     #subset a set of nos
v[-c(3:6)]    #subset by omitting

l[1]

df[1:3, ]

x <- df$menutypes
print(x)

v <- c(1,5,3,4,5)
v1 <- v[v==5]
v1
v==5

df1 <- df[df$menutypes=="solid", ]
df1

df2 <- df[df$menucost>3, ]
df2

df3 <- df[df$menucost<3, ]
df3

data <- read.table("gapminder.txt", header = TRUE)
head(data)
str(data)
typeof(data)

x1 <- data[,c(3,5)]     #pull out columns 3 & 5
head(x1)

data[data$country=="Sweden",]   #pull out rows with Sweden

unique(data[,1])
head(data)
x2 <- data[data$lifeExp<70,]
head(x2)     

x3 <- data[data$lifeExp>80,]
head(x3)
