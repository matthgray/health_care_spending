if (!require("pacman")) install.packages("pacman")
library("tidyverse")
# Load contributed packages with pacman
pacman::p_load(pacman, party, rio, tidyverse)
library(ggplot2)
library(dplyr)
library("readxl")

# upload data and use sheet that deals with inflation
real_health_data <- read_excel("2017-MEPS-account-release-table.xlsx", sheet ="Real Expenditures MEPS")



# change column names
colnames(real_health_data) <- c("Disease","2000", "2001","2002","2003","2004",
                           "2005","2006","2007","2008","2009","2010","2011",
                           "2012","2013","2014","2015","2016","2017")

# remove rows
health_data <- real_health_data[-c(1,2,3,4,19,39,38,37),]

# summary(health_data)


# convert row 2015 to character
health_data$"2015" <- as.character(as.numeric(health_data$"2015"))


# change it to narrow and not wide data

h_data <- health_data %>%
  pivot_longer(cols = !Disease,
               names_to = "Year",
               values_to = "Expenditure")

# change spending to a number and not a character
h_data$Expenditure<- as.numeric(as.character(h_data$Expenditure))

# create a csv for the clean data
write.csv(h_data, "/Users/matth/Downloads/nss_projects_ds/Questions/Mid_course_project/health_care_spending/app/CleanData.csv",row.names=TRUE,col.names=TRUE)
