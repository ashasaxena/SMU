####################################################################
# MakeFile
####################################################################

brew <- read.csv('data/Breweries.csv')
beer <- read.csv('data/Beers.csv')

suds <- merge(x = brew,y = beer,by.x = 'Brew_ID', by.y = 'Brewery_id')

write.csv(suds,file = 'data/suds.csv')
