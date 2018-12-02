# question 1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "data/Idaho.csv", method = "curl")
idaho <- read.csv("data/Idaho.csv", sep =",", header = TRUE)
splitNames <- strsplit(names(idaho),"wgtp")
splitNames[[123]]

# question 2

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2,destfile = "data/gdpdata.csv", method = "curl")
gdpdata <- read.csv("data/gdpdata.csv", sep =",", header = TRUE, skip=4)
values <- gsub(" ","",gdpdata$X.4)
values <- gsub(",","",gdpdata$X.4)
head(values)
values <- values[1:190]
values <- as.numeric(values)
values
mean(values)

#question 3
grep("^United", gdpdata$X.3, value = TRUE)

# question 4
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl3,destfile = "data/country.csv", method = "curl")
countrydata <- read.csv("data/country.csv", sep =",", header = TRUE)
fiscal <- country[grep("Fiscal year end: June 30",countrydata$Special.Notes),]
dim(fical)[1]

# question 5
library("quantmod")
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
library(lubridate)
year2012 <- sampleTimes[year(sampleTimes) == 2012]
length(year2012)
Mondays2012 <- year2012[wday(year2012) == 2]
length(Mondays2012)

