####################################################################
# MakeFile
####################################################################

brew <- read.csv('data/Breweries.csv')
beer <- read.csv('data/Beers.csv')

merged_data <- merge(x = brew,y = beer,by.x = 'Brew_ID', by.y = 'Brewery_id')

write.csv(merged_data,file = 'data/merged_data.csv')
