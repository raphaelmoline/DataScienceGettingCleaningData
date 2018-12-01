set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15)) # create data frame
x <- x[sample(1:5),] # change rows order
x$var2[c(1,3)] = NA # add some NA

x[(x$var1 <=3 & x$var3 >11),] # subsetting on conditions

# manage NAs with which
x[x$var2 > 8,]
x[which(x$var2 > 8),]

#Sort
sort(x$var1)
sort(x$var1,decreasing = TRUE)
sort(x$var2, na.last = TRUE)

#Order
x[order(x$var1),] #order returns rows references
x[order(x$var1,x$var3),] # multiple

# using plyr library
library(plyr)
arrange(x,var1)
arrange(x,desc(var1))

# add columns to data frame
x$var4 <- rnorm(5)
y <- cbind(x,rnorm(5))

if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

# sample of the data
head(restData,5)
tail(restData,5)

# summary of the data
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))
table(restData$zipCode,useNA = "ifany") # would create a columns with the # of NAs
table(restData$councilDistrict,restData$zipCode) # two dimensional table

# check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

#rows and column sums
colSums(is.na(restData)) # sum of number of NA
all(colSums(is.na(restData)) == 0) # is there any NA?

#values with specific characteristics
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]

# cross tabs, not done here

#objet size
print(object.size(restData),units="Mb")


### creating new variables missingness, curring up (factor quantitatives), transforms

#creating sequences
s1 <- seq(1,10,by=2)
s1
s2 <- seq(1,10,length=3)
s2
x2 <- c(1,3,8,25,100)
seq(along= x2)

#creating binary variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)

#creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)

#Easier utting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# creating factor variable
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

#levels of facroe variables
yesno <- sample(c("yes","no"),size=10, replace = TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac, ref="yes")
as.numeric(yesnofac)

#using the mutate function
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))

##reshaping data
library(reshape2)
head(mtcars)
mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(mtcars,id=c("carname", "gear","cyl"),measure.vars = c("mpg","hp"))
head(carMelt)
tail(carMelt)

# casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData

#averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)

#split functions
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns # output is a list

sprCount = lapply(spIns,sum)
sprCount
unlist(sprCount)
sapply(spIns, sum)

#using plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count)) # not working
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))

#using dplyr package
library(dplyr)
chicogo <- readRDS("chicago.rds")
names(chicago)
head(select(chicago, city:dptp)) # select range of columns
head(select(chicago, -(city:dptp)))
# alternative
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[,-(i:j)])
# filter on value
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80) # multiple filters
#rearrange
chicago <- arrange(chicago,date)
head(chicago)
chicago <- arrange(chicago,desc(date)) # descending order
# rename
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
#mutate, new variables
chicago <- mutate(chicago, pm25dtrend = pm25-mean(pm25,na.rm = TRUE))
head(select(chicago, pm25, pm25dtrend))
# group by: split
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago,tempcat)
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago,year)
summarize(years, pm25 = mean(pm25,na.rm=TRUE),  o3 = max(o3tmean2), no2 = median(no2tmean2))
# pipeline operator,do not need to specify the data frame used
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm= TRUE),o3 = max(o3tmean2), no2 = median(no2tmean2) )






