library(ggplot2)
library(data.table)
library(dplyr)
library(ggthemes)

source(file = 'script/makefile.R')

#question 1
q1 <- brew %>% group_by(brew$State) %>% summarize(n = n())
head(q1)

#Question 2
head(suds, 6)
tail(suds, 6)

q3 <- sapply(q2, function(x) sum(length(which(is.na(q2)))))
print(q3)

q4 <- q2 %>% group_by(q2$State) %>% summarize(median_ABV = median(ABV), median_IBU = median(IBU))
q4_df <- as.data.frame(q4)
setnames(q4_df, "q2$State", "State")

#bar chart for median_ABV
q5a <- ggplot(data = q4, aes(x = State,y = median_ABV)) + 
  geom_col(color = 'red',fill = 'pink') +
  labs(y = 'Median ABV',title = 'Median Alcohol Content') +
  theme_economist()
               
#bar chart for median_IBU
q5b <- ggplot(data = q4, aes(x = State,y = median_IBU)) + 
  geom_col(color = 'red',fill = 'pink') +
  labs(y = 'Median IBU',title = 'Median International Bitterness Content') +
  theme_economist()                 

print(q5a)
print(q5b)

#summary of ABV                                              
q6 <- summary(q2$ABV)
print(q6)

#scatter plot
q7 <- ggplot(data = q2, aes(x = ABV,y = IBU)) + 
  geom_point() +
  labs(x = 'ABV', y = 'IBU',title = 'International Bitterness Content vs. Alcoholic Content') +
  theme_economist()  
print(q7)  

#linear reegression model
q7model <- lm(IBU ~ ABV, q2)
summary(q7model)