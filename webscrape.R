#Webscaping in R

install.packages("rvest")
library("rvest")

scrape_url <- "https://gc.com/t/summer-2022/arrowhead-west-mudcats-moorhead-628eaa8d0e8fb8a65f000001/stats"

gamechanger <- read_html(scrape_url)


stats <- gamechanger %>% html_elements("th class")


test <- readLines(flat_html, encoding = "")

View(flat_html)

??grep


grep(".statCell", flat_html)



starwars <- read_html("https://rvest.tidyverse.org/articles/starwars.html")

