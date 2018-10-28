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
