source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library("rhdf5")
created = h5createFile("example.h5")created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/baa")
h5ls("example.h5")

A = matrix (1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
attr(B,"scale") <- "liter"
h5write(B,"example.h5", "baa/B")
h5ls("example.h5")

df = data.frame(1L:5L,seq(0,1,length.out=5),c("ab","cde","fghi","a","s"), stringAsFactors=FALSE)
h5write(df,"example.h5","df")

readA = h5read("example.h5", "foo/A")
readA

h5write(c(12,13,14),"example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5", "foo/A")