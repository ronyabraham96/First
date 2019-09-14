##This is script to plot life exp

myDataFull <- read.table("gapminder.txt",header = TRUE)     #read data

Canada <- myDataFull[myDataFull$country=="Canada",]         #obtain all data for Canada

png("Canada.png")                                           #open a png for plot
plot(Canada$year,Canada$lifeExp,type = "h",col = "green")   # plot histrogram with green color
dev.off()



mean(Canada$lifeExp)



