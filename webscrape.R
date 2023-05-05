#Webscaping in R

install.packages("rvest")
library("rvest")

#rvest example
starwars <- "https://rvest.tidyverse.org/articles/starwars.html"

starwars <- read_html(scrape_url)


stats <- starwars %>% 
  html_elements("section")


title <- stats %>% 
  html_element("h2") %>% 
  html_text2()


#Gamechanger
gc <- "https://gc.com/t/summer-2022/arrowhead-west-mudcats-moorhead-628eaa8d0e8fb8a65f000001/stats"

gcElements <- read_html(gc)


stats <- gcElements %>% 
  html_elements("tbody")


title <- gcElements %>% 
  html_element("tbody") %>% 
  html_table()
