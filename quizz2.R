download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","quizz.csv")
housing <- read.csv("quizz.csv", header = TRUE)
housing[which(housing$ACR == 3 & housing$AGS == 6) ,]

img <- readJPEG("image.jpg", native = TRUE)
quantile(img, probs = .3)
quantile(img, probs = .8)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "country.csv")
gdp <- read.csv("gdp.csv", skip = 3, header = TRUE, stringsAsFactors = FALSE)
country <- read.csv("country.csv", header = TRUE)
matched <- gdp[gdp[,1] %in% country[,1],]
matched$Ranking <- as.numeric(matched$Ranking)
matched <- matched[which(matched$Ranking>0),]
matched[order(-matched$Ranking),]

country_red <- country[,1:3]
names(matched)[1] <- "CountryCode"
data <- merge(matched[,1:5], country_red )

library(readr)
data$US.dollars. <-  parse_number(data$US.dollars.)
mean(data[data$Income.Group == "High income: OECD",2])
mean(data[data$Income.Group == "High income: nonOECD",2])
data[which(data$Income.Group == "Lower middle income" & data$Ranking <= 38),]

