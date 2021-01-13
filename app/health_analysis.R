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
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(GGally, magrittr, pacman, rio, tidyverse)

health_spending %>% ggpairs()

health_spending %>% 
  filter(Disease == "Infectious and parasitic diseases") %>%
  ggplot(aes(Year, Expenditure)) +
  geom_point(size = 3) +
  geom_smooth(method = lm)


h_avg_costs <-health_spending %>%
  group_by(Disease) %>%
  summarize(average_cost = mean(Expenditure)) %>%
  arrange(desc(average_cost))

low_costs <- health_spending %>%
              arrange(Expenditure)



high_costs <- h_data %>%
  arrange(desc(Costs))


health_spending %>%
  filter(Disease == "Infectious and parasitic diseases")
  
h_avg_costs <-health_spending %>%
                group_by(Disease) %>%
                summarize(average_cost = mean(Expenditure)) %>%
                arrange(desc(average_cost))

health_spending %>%
  group_by(Disease) %>%
  summarize(std = sd(Expenditure)) %>%
  arrange(desc(std))


health_spending %>%
  filter(Disease == "Infectious and parasitic diseases") %>%
  ggplot(aes(x=Year, y=Expenditure)) +
  ggtitle("Health") +
  geom_bar(stat="identity", fill="steelblue") +
  geom_text(aes(label=Expenditure), vjust=1.6, color="black", size=3.5)

health_spending %>%
  filter(Disease =="Symptoms; signs; and ill-defined conditions")%>%
  ggplot(aes(x=Year, y=Expenditure, group=1)) +
  geom_step()+
  geom_point()

health_spending %>%
  filter(Disease == "Symptoms; signs; and ill-defined conditions") %>%
  ggplot(aes( y=Expenditure))+
  geom_boxplot(fill='steelblue',color="green")+
  theme_dark()
  #geom_dotplot(binaxis = 'y',stackdir = 'center', dotsize =1)

library(plotly)
fig <- health_spending %>% 
  plot_ly(y = Expenditure, type = "box", quartilemethod="exclusive") # or "inclusive", or "linear" by default

fig

m_health

sort(unique(h_data$Disease))
