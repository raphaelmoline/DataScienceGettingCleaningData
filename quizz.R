library("httpuv")
library("rjson")
# oauth_endpoints("github")
# myapp = oauth_app("github", key = "xxx", secret = "yyy")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

json2 = jsonlite::fromJSON((toJSON(json1)))

projects <- vector()
for (i in 1:length(json1)) {projects[i] = (json1[[i]]$name) }


json1[[16]]$created_at

acs <- read.csv("AmericanStudySurvey.csv")


con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
htmlCode
nchar(htmlCode[c(10,20,30,100)])

dat <- read.fwf(file = "quizzdata.for", widths = c(14,5,6,7,6,7,6,7,6), skip =4)
sum(dat[,4])