require(maps)
require(rvest)

# Define webpage
epl1718 <- read_html("https://www.premierleague.com/stats/top/clubs/goals?se=79")

epl1718 %>% 
  html_node(".statsTableContainer tr:nth-child(1) .mainStat") %>%
  html_text()

