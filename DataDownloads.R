fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl4, destfile = "housing.csv", method="curl")

housingData <- read.table("housing.csv", sep =",", header = TRUE)
housingVal <- HousingData[complete.cases(HousingData[,"VAL"]),]
table(housingVal$VAL)