csvUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(csvUrl , destfile = "housing.csv", method="curl")

housingData <- read.table("housing.csv", sep =",", header = TRUE)
housingVal <- HousingData[complete.cases(HousingData[,"VAL"]),]
table(housingVal$VAL)

xlsUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(xlsUrl, destfile = "NaturalGas.xlxs", method = "curl")
library("readxl")
gas <- read_excel("NaturalGas.xlxs")
dat <- gas[18:22,7:15] # no header so adjusting the row
# excel library to be used is not working in current Rstudio version, skipping for now


xmlUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library("httr")
library("XML")
restaurant <- xmlTreeParse(GET(xmlUrl),useInternal=TRUE)
rootNode <- xmlRoot(restaurant)
zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcodes[zipcodes==21231])

dtUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(dtUrl , destfile = "survey.csv", method="curl")