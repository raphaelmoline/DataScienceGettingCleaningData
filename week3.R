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

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode <0, TRUE, FALSE)
table(restData$zipWrong,restData$zipCode < 0)
