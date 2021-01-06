if (!require("pacman")) install.packages("pacman")
library("tidyverse")
# Load contributed packages with pacman
pacman::p_load(pacman, party, rio, tidyverse)
library(ggplot2)
library(dplyr)

(health_data <- import("2017-MEPS-account-release-table.xlsx") %>% as_tibble())
# (dummy <- import("expenditure_dummy_data.xlsx") %>% as_tibble())
# (dummy <- import("test.xlsx") %>% as_tibble())

# change column names
colnames(health_data) <- c("Disease","2000", "2001","2002","2003","2004",
                           "2005","2006","2007","2008","2009","2010","2011",
                           "2012","2013","2014","2015","2016","2017")

# remove rows
health_data <- health_data[-c(1,39,38,37),]

# summary(health_data)



health_data$"2015" <- as.character(as.numeric(health_data$"2015"))

#summary(health_data)

# change it to narrow and not wide data
# pivot_wider
h_data <- health_data %>%
            pivot_longer(cols = !Disease,
               names_to = "Year",
               values_to = "Costs")

glimpse(h_data)
glimpse(health_data)
h_data$Costs<- as.numeric(as.character(h_data$Costs))

summary(h_data)

h_data %>%
  filter(Disease == "Congenital anomalies")
low_costs <- h_data %>%
              arrange(Costs)
high_costs <- h_data %>%
  arrange(desc(Costs))

h_data %>%
  group_by(Disease) %>%
  summarize(average_cost = mean(Costs)) %>%
  arrange(desc(average_cost))


health <- h_data %>%
  filter(Disease == "Diseases of the circulatory system") %>%
  ggplot(aes(x=Year, y=Costs)) +
  ggtitle("Health") +
  geom_bar(stat="identity",fill="gray", color = 'black') +
  theme_dark()

health



m_health <- h_data %>%
  slice(415:432) %>%
  ggplot(aes(x=Year, y=Costs)) +
  ggtitle("Mental Health") +
  geom_bar(stat="identity",fill="gray", color = 'black') +
  theme_dark()

m_health

sort(unique(h_data$Disease))
