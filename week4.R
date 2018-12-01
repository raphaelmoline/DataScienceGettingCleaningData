if(!file.exists("./data")) {dir.create(".data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accesstype=Download"
download.file(fileUrl,destfile = "data/cameras.csv", method = "curl")
cameraData <- read.csv("data/cameras.csv")
names(cameraData)
tolower(names(cameraData))
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]

#quick aside: lists
myList <- list(letter = c("A","b","c"), mumbers = 1:3, matrix(1:25, ncol=5))
head(myList)

#using sapply
splitNames[[6]][[1]]
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

fileUrl1 <- "http://www.sharecsv.com/dl/e70e9c289adc4b87c900fdf69093f996/reviews.csv" # links broken
fileUrl2 <- "http://www.sharecsv.com/dl/0863fd2414355555be0260f46dbe937b/solutions.csv" # links broken
download.file(fileUrl1,destfile = "data/reviews.csv", method = "curl")
download.file(fileUrl2,destfile = "data/solutions.csv", method = "curl")
reviews <- read.csv("data/reviews.csv")
solutions <- read.csv("data/solutions.csv")
head(reviews,2)
head(solutions,2)

#substiture -> use sub()
#sub("_","",names(reviews),)

testName <- "this_is_q_test"
sub("_","",testName)
gsub("_","",testName)

#finding values - grep(), grepl()
grep("Alameda",cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
grep("Alameda",cameraData$intersection, value = TRUE)
length(grep("JeffStreet", cameraData$intersection))

library(string)
nchar("Raphael Moline")
substr("Raphael Moline",1,7)
paste("Raphael","Moline")
paste0("Raphael","Moline")
#strtrim("Raphael        ")

#important points: lower case, descriptive, not duplicated, no underscores or dots or white spaces

#Regex: ^ beginning of line, $ end of line character classes eg [0-9][a-zA-Z]
# regex2 not matching [^?.]$ no matching lines neding with . or ?
#regex metacharacters . is for any character 9.11 ; or: | ; ? for optional ; \ to escape eg.
#regex" * is repeat eg (.*) anaything between parenthesis, curly brackets for min/max number of matches

# dates
d1 = date()
d1
class(dq)
d2 = Sys.Date()
d2
class(d2)
format(d2,"%a %b %d")
x = c("1jan1960","2jan1960","31mar1960","30jul1960")
z = as.Date(x,"%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1] - z[2])
weekdays(d2)
months(d2)
julian(d2)

#lubridate
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")
x = dmy(c("1jan2013","2jan2013","3jan2013","30jul2013"))
wday(x[1])
wday(x[1],label = TRUE)