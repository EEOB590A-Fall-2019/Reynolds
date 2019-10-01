getwd()
setwd("/Users/rebekah/Desktop/Course-Materials/3. Data wrangling")
getwd()
#1) load libraries - you will need tidyverse and readxl
library(tidyverse)
library(readxl)
#2) Read in data
pollination<-read_excel("Data_wrangling_day1_pollination.xlsx")

#3) rename columns. Leave insect families with capital letters, but make all other columns lowercase. Remove any spaces. Change "location" to "site". Change "tract" to "transect". 
colnames(pollination)[colnames(pollination)=="Location"]<- "site"
colnames(pollination)[colnames(pollination)=="Tract"]<- "transect"
colnames(pollination)[colnames(pollination)=="Island"]<- "island"
colnames(pollination)[colnames(pollination)=="Top color - Bowl color"]<- "topcolorbowlcolor"
colnames(pollination)[colnames(pollination)=="Other"]<- "other"

#4) Add missing data. Note that the people who entered the data did not drag down the island or location column to fill every row. 
is.na(pollination$site)

pollination <- pollination %>%
  fill(island,site)

is.na(pollination$site)
view(pollination)

#5) Separate "Top color - Bowl color" into two differnt columns, with the first letter for the top color and the second letter for the bowl color. We do not need to save the original column. 
pollination <- pollination %>%
  separate(topcolorbowlcolor, into=c("topcolor", "bowlcolor"), sep="-", remove = T)
view(pollination)

#6) Use the complete function to see if we have data for all 3 transects at each location. Do not overwrite the poll dataframe when you do this. 
#which transects appear to be missing, and why? 
complete(pollination)
CompletePollination <-pollination %>%
  complete(site, transect)
missing <- CompletePollination[is.na(CompletePollination$island),]
view(missing)
#The transects that appear to be missing are the transects T1,T2,T3 that do no have any insect collected from any of the Orders. 

#7) Unite island, site, transect into a single column with no spaces or punctuation between each part. Call this column uniqueID. We need to keep the original columns too. 

pollination <- pollination %>%
  unite(c(island,site,transect),col="uniqueID",sep="",remove=F)
view(pollination)

#8) Now, make this "wide" dataset into a "long" dataset, with one column for the insect orders, and one column for number of insects. 
?gather
PollinationLongDataset<- pollination %>%
  gather(insectorder, numberinsects, 7:19)
view(PollinationLongDataset)

#9) And just to test it out, make your "long" dataset into a "wide" one and see if anything is different. 
PollinationWideDataset<- PollinationLongDataset %>%
  spread(insectorder, numberinsects,convert = TRUE)
?spread

#are you getting an error? Can you figure out why? 

#I'm getting the error that each row is not identified by a unique combination of keys. I'm note quite sure what this means. 
#my first thought was that because there are more than 2 variables in the "insectorder" column, then R is becoming confused by how to separate the columns but that is not what I think the error is saying
#still not totally sure what is going on..

#10) Now, join the "InsectData" with the "CollectionDates" tab on the excel worksheet. You'll need to read it in, and then play around with the various types of 'mutating joins' (i.e. inner_join, left_join, right_join, full_join), to see what each one does to the final dataframe.

CollectionDates <- read_excel("Data_wrangling_day1_pollination.xlsx", sheet = 2)
InnerPollinationCollectionDates <- pollination%>%
  inner_join(CollectionDates)
LeftPollinationCollectionDates <- pollination%>%
  left_join(CollectionDates)
RightPollinationCollectionDates <- pollination%>%
  right_join(CollectionDates)
FullPollinationCollectionDates <- pollination%>%
  full_join(CollectionDates)

View(CollectionDates)
View(FullPollinationCollectionDates)

