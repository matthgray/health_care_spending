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
health_data <- health_data[-c(1,2,3,4,19,39,38,37),]

# summary(health_data)



health_data$"2015" <- as.character(as.numeric(health_data$"2015"))

#summary(health_data)

# change it to narrow and not wide data
# pivot_wider
h_data <- health_data %>%
            pivot_longer(cols = !Disease,
               names_to = "Year",
               values_to = "Expenditure")


h_data$Expenditure<- as.numeric(as.character(h_data$Expenditure))


write.csv(h_data, "/Users/matth/Downloads/nss_projects_ds/Questions/Mid_course_project/health_care_spending/app/MyData.csv",row.names=TRUE)


health_spending <- read_csv('MyData.csv')

h_avg_costs <-health_spending %>%
  group_by(Disease) %>%
  summarize(average_cost = mean(Expenditure)) %>%
  arrange(desc(average_cost))

low_costs <- health_spending %>%
              arrange(Expenditure)

Disease_choices <- sort(unique(health_spending$Disease))

high_costs <- h_data %>%
  arrange(desc(Costs))

h_avg_costs <-h_data %>%
                group_by(Disease) %>%
                summarize(average_cost = mean(Costs)) %>%
                arrange(desc(average_cost))

h_data %>%
  group_by(Disease) %>%
  summarize(std = sd(Costs)) %>%
  arrange(desc(std))


health_spending %>%
  filter(Disease == "Infectious and parasitic diseases") %>%
  ggplot(aes(x=Year, y=Expenditure)) +
  ggtitle("Health") +
  geom_bar(stat="identity", fill="steelblue") +
  geom_text(aes(label=Expenditure), vjust=1.6, color="black", size=3.5)





m_health <- h_data %>%
  slice(415:432) %>%
  ggplot(aes(x=Year, y=Costs)) +
  ggtitle("Mental Health") +
  geom_bar(stat="identity",fill="gray", color = 'black') +
  theme_dark()

m_health

sort(unique(h_data$Disease))
