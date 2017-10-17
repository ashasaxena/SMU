library(ggplot2)
library(data.table)
library(dplyr)
library(ggthemes)

source(file = 'script/makefile.R')

#question 1
q1 <- brew %>% group_by(brew$State) %>% summarize(Total = n())

write.csv(q1,file = 'Analysis/Breweries_by_State.csv',row.names = FALSE)

#Question 2
head(suds, 6)
tail(suds, 6)

#Question 3
q3a <- sum(is.na(suds$ABV))
q3b <- sum(is.na(suds$IBU))
print(q3a)
print(q3b)

q4 <- suds %>% group_by(suds$State) %>% summarize(median_ABV = median(ABV), median_IBU = median(IBU))
q4_df <- as.data.frame(q4)
setnames(q4_df, "suds$State", "State")

#bar chart for median_ABV
q4a <- ggplot(data = q4, aes(x = State,y = median_ABV)) + 
  geom_col(color = 'red',fill = 'pink') +
  labs(y = 'Median ABV',title = 'Median Alcohol Content') +
  theme_economist()
               
#bar chart for median_IBU
q4b <- ggplot(data = q4, aes(x = State,y = median_IBU)) + 
  geom_col(color = 'red',fill = 'pink') +
  labs(y = 'Median IBU',title = 'Median International Bitterness Content') +
  theme_economist()                 

print(q4a)
print(q4b)

#question 5
q5a <- suds$State[which.max(suds$ABV)]
q5b <- suds$State[which.max(suds$IBU)]
print(q5a)
print(q5b)

#summary of ABV                                              
q6 <- summary(suds$ABV)
print(q6)

#scatter plot
q7 <- ggplot(data = suds, aes(x = ABV,y = IBU)) + 
  geom_point() +
  labs(x = 'ABV', y = 'IBU',title = 'International Bitterness Content vs. Alcoholic Content') +
  theme_economist()  
print(q7)  

#linear reegression model
q7model <- lm(IBU ~ ABV, suds)
summary(q7model)
