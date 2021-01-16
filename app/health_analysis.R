if (!require("pacman")) install.packages("pacman")
library("tidyverse")
# Load contributed packages with pacman
pacman::p_load(pacman, party, rio, tidyverse)
library(ggplot2)
library(dplyr)
library("growthrates")

health_spending <- read_csv('CleanData.csv')
if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman
pacman::p_load(GGally, magrittr, pacman, rio, tidyverse)

# health_spending %>% ggpairs()
mean(health_spending$Expenditure)

health_spending %>%
  filter(Disease == "Infectious and parasitic diseases") %>%
  growth.


health_spending %>%
  filter(Disease == "Infectious and parasitic diseases") %>%
  summarize(mean(Expenditure))
# growth_rate = growth %>%
  # first sort by year


test <- health_spending %>%
  filter(Disease == "Infectious and parasitic diseases") %>%
  arrange(Year) %>%
  mutate(Diff_year = Year - lag(Year),  # Difference in time (just in case there are gaps)
         Diff_growth = Expenditure - lag(Expenditure), # Difference in route between years
         Rate_percent = (Diff_growth / Diff_year)/Expenditure * 100) # growth rate in percent
test

health_spending %>% 
  filter(Disease == "Infectious and parasitic diseases") %>%
  ggplot(aes(Year, Expenditure)) +
  geom_point(size = 3) +
  geom_smooth(method = lm)

fit1 <- health_spending %>% 
  filter(Disease== "Infectious and parasitic diseases") %>%# Save as "fit1"
  select(Year, Expenditure) %>%  # y, then x
  lm() 

fit1 %>% summary()
fit1 %>% confint()
fit1 %>% predict()

fit1 %>% predict(interval = "prediction")

fit1 %>% lm.influence()
fit1 %>% influence.measures()

fit1 %>% plot()


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
