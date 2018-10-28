ucscDb <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc,edu")
result <- dbGetQuery(ucsDb,"show databases,") ; dbDisconnect(ucscDB);