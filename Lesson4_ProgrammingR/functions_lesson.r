gapminder <- read.table("gapminder.txt", header = TRUE)

fahrenheit_to_celsius <- function(temp){
  celsius <- (temp-32)*5/9
  return(celsius)
}

celsius_to_kelvin <- function(temp_C){
  kelvin <- 273+temp_C
  return(kelvin)
}

fahrenheit_to_kelvin <- function(temp_F){
  celsius <- fahrenheit_to_celsius(temp_F)
  kelvin <- celsius_to_kelvin(celsius)
  return(kelvin)
}

#Mean life Exp of a specific continent
MeanlifeExp <- function(cont){
  continent <- gapminder[gapminder$continent == cont, "lifeExp"]
  m <- mean(continent)
  return(m)
}

#Check whether continents have a mean life exp > or < 50

category <- unique(gapminder$continent)
for (i in category){
  if(MeanlifeExp(i)>50)
    print(paste0(i," has mean life expectency greater than 50"))
  else
    print(paste0(i," has mean life expectency less than 50"))
}


