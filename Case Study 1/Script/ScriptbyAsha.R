rm(list=ls())
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(dplyr)
library(sp)
library(maptools)
library(readr) 

stateFromLower <-function(x) {
  #read 51 state codes into local variable [includes DC (Washington D.C.)]
  st.codes<-data.frame(
    state=as.factor(c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA",
                      "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME",
                      "MI", "MN", "MO", "MS",  "MT", "NC", "ND", "NE", "NH", "NJ", "NM",
                      "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN",
                      "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")),
    full=as.factor(c("alaska","alabama","arkansas","arizona","california","colorado",
                     "connecticut","district of columbia","delaware","florida","georgia",
                     "hawaii","iowa","idaho","illinois","indiana","kansas","kentucky",
                     "louisiana","massachusetts","maryland","maine","michigan","minnesota",
                     "missouri","mississippi","montana","north carolina","north dakota",
                     "nebraska","new hampshire","new jersey","new mexico","nevada",
                     "new york","ohio","oklahoma","oregon","pennsylvania",
                     "rhode island","south carolina","south dakota","tennessee","texas",
                     "utah","virginia","vermont","washington","wisconsin",
                     "west virginia","wyoming"))
  )
  #create an nx1 data.frame of state codes from source column
  st.x<-data.frame(state=x)
  #match source codes with codes from 'st.codes' local variable and use to return the full state name
  refac.x<-st.codes$full[match(st.x$state,st.codes$state)]
  #return the full state names in the same order in which they appeared in the original source
  return(refac.x)
  
}


beers <- read_csv("C:/Users/ashas/github/SMU/Case Study 1/Data/Beers.csv")
brws <- read_csv("C:/Users/ashas/github/SMU/Case Study 1/Data/Breweries.csv")

d<-merge(beers, brws, by.brewery_id = "brewery_id", by.beer_id = "beer_id")
d

names(d)[names(d)=="name.x"]<-"beer"
names(d)[names(d)=="name.y"]<-"brewery"



# Summary Statistics
# plot average abv and ibu by style
states<-map_data("state")
head(states)
d$region<-stateFromLower(d$state)

# we see that this doesn't work because there is an extra space in the state abbrevations
levels(d$state)
d$state<-gsub("[[:space:]]", "", d$state)
d$region<-stateFromLower(d$state)


agg<-aggregate(cbind(ibu,abv)~region,FUN = mean,d)

# text data for maps
counts<-as.data.frame(table(d$state)) # no. of observations per state
d.ibu<-d[!is.na(d$ibu),]
counts.ibu<-as.data.frame(table(d.ibu$state))
colnames(counts.ibu)<-c("state.abb","count.ibu")
colnames(counts)<-c("state.abb","count")
txt <- data.frame(state.center, state.abb)
d1<-txt
d2<-counts
d3<-counts.ibu
lab<-merge(d1,d2, by = "state.abb", all=FALSE)
lab<-merge(lab,d3,by="state.abb")
rm(counts,txt,d1,d2,d3)

plot.data <- inner_join(states, agg, by = "region")

# ABV
ggplot(data = plot.data, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +   geom_polygon(data = plot.data, aes(fill = abv), color = "white") +
  geom_polygon(color = "black", fill = NA) +theme_bw() +labs( title="Average ABV by state \n (numbers indicate observations by state)")+
  scale_fill_gradientn("ABV",colors=c("#BBFFFF","#000080" ))+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())+
  geom_text(data = lab, aes(x = x, y = y, label = count, group = NULL), size = 2)+theme_bw()

# IBU
ggplot(data = plot.data, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +   geom_polygon(data = plot.data, aes(fill = ibu), color = "white") +
  geom_polygon(color = "black", fill = NA) +theme_bw() +labs( title="Average IBU by state \n (numbers indicate observations of IBU by state)")+
  scale_fill_gradientn(colours = rev(rainbow(7)))+
  # breaks = c(2, 4, 10, 30, 50, 60),
  # trans = "log10")+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())+
  geom_text(data = lab, aes(x = x, y = y, label = count.ibu, group = NULL), size = 2)+theme_bw()


# number of styles per state
d$style<-as.character(d$style)
d.new<-within(d,{no.styles<-ave(style,region,FUN=function(x) length(unique(x)))})
agg<-subset(d.new,select=c("region","no.styles"))
agg<-unique(agg)
agg$no.styles<-as.numeric(paste(agg$no.styles))
plot.data <- inner_join(states, agg, by = "region")


ggplot(data = plot.data, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +   geom_polygon(data = plot.data, aes(fill = no.styles), color = "white") +
  geom_polygon(color = "black", fill = NA) +theme_bw() +labs( title="Number of styles per state \n (numbers indicate observations by state)")+
  scale_fill_gradientn("no. of styles",colors=c("#FF9999","#000099" ))+
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank())+
  geom_text(data = lab, aes(x = x, y = y, label = count, group = NULL), size = 2)+theme_bw()


#### Relationship between ABV and IBU
d$ounces<-as.factor(d$ounces)
qplot(ibu,abv,data=d,color=ounces)

#let's relabel 16.9 ounces as 16 ounces
d$ounces.new<-d$ounces
d$ounces.new[d$ounces==16.9]<-16
ggplot(data=d,aes(x=ibu,y=abv,color=ounces.new))+geom_point(size=1.5,alpha=.8)+
  scale_color_manual(breaks = c("8.4","12","16","19.2","24","32"),
                     values=c("red", "blue", "green","yellow","black","pink"))+theme_bw()

show less

View(d)
