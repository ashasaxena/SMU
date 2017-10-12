library(ggplot2)
library(data.table)
library(dplyr)

brew <- read.csv('Breweries.csv')
beer <- read.csv('Beers.csv')

q1 <- brew %>% group_by(brew$State) %>% summarize(n = n())

head(q1)

q2 <- merge(x = brew,y = beer,by.x = 'Brew_ID', by.y = 'Brewery_id')
head(q2, 6)
tail(q2, 6)

q3 <- sapply(q2, function(x) sum(length(which(is.na(q2)))))
q3

q4 <- q2 %>% group_by(q2$State) %>% summarize(median_ABV = median(ABV), median_IBU = median(IBU))
q4_df <- as.data.frame(q4)
setnames(q4_df, "q2$State", "State")

#stuck here...
#q4_g <- ggplot(q4_df$median_ABV, aes(q4_df$State))
               
                 


                                              