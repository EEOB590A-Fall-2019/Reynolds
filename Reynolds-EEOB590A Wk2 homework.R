# EEOB590A 
# Homework - 5 September 2019

#develop a script that reads your dataset into R, checks the structure of the dataset, and looks at the summary of the dataset. 

#As you look at your data in R, make a list of the things you think you need to do to tidy up your dataset at the top of your script



install.packages("readxl")
library("readxl")

Halofenozide <-read.csv(file.choose(), header=T)
#there are a bunch of N/As where there are spaces between experiments. 
#I'm not sure whether R will read the spaces between the 3 experiments as separate experiments or one large experiments with about 45 data points
#I may have to add a row for date of experiment or something along those lines

#note that you can use just T or F instead of writing out TRUE or FALSE


str(object=Halofenozide)
#I noticed after running this that R is reading each space on excel as a data point, which may or may not be a problem
#The structure tabel says that I have 45 observations but for the 2 ug column there are only 10 observations
#Are the N/A rows ignored? 

summary(Halofenozide)
#I do not see anything immediately wrong with the summary table of my data 

#note that the number of NAs is provided in the summary

  
  
)