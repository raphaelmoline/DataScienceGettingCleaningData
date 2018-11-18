set.seed(13435)
x <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15)) # create data frame
x <- x[sample(1:5),] # change rows order
x$var2[c(1,3)] = NA # add some NA

x[(x$var1 <=3 & x$var3 >11),] # subsetting on conditions

# manage NAs with which
x[x$var2 > 8,]
x[which(x$var2 > 8),]
