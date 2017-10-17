library(ggplot2)
library(data.table)
library(dplyr)
library(ggthemes)

source('Analysis/makefile.R')

#question 1
q1 <- brew %>% group_by(brew$State) %>% summarize(N = n())
q1 <- as.data.frame(q1)

q1_plot <- ggplot(data = q1, aes(x = as.factor(q1$`brew$State`),y = TotalBreweries)) + 
  geom_col(color = 'red',fill = 'pink') +
  labs(y = 'N',x = 'State') +
  ggtitle('Number of Breweries by State') +
  theme_economist()
print(q1_plot)









#Question 2
head(merged_data, 6)
tail(merged_data, 6)

#Question 3
q3a <- sum(is.na(merged_data$ABV))
q3b <- sum(is.na(merged_data$IBU))
print(q3a)
print(q3b)

#question4
q4 <- merged_data %>% group_by(merged_data$State) %>% summarize(median_ABV = median(ABV), median_IBU = median(IBU))
q4 <- as.data.frame(q4)
setnames(q4, "merged_data$State", "State")

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

#question5

#question 6

#summary of ABV                                              
q6 <- summary(merged_data$ABV)
print(q6)

#scatter plot
q7 <- ggplot(data = merged_data, aes(x = ABV,y = IBU)) + 
  geom_point() +
  labs(x = 'ABV', y = 'IBU',title = 'International Bitterness Content vs. Alcoholic Content') +
  theme_economist() +
  geom_smooth(method = 'lm')
print(q7)  

#linear reegression model
q7model <- lm(IBU ~ ABV, merged_data)
summary(q7model)