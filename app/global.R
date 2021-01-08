library(shiny)
library(tidyverse)
library(shinydashboard)

library(ggplot2)
library(dplyr)
# import data



health_spending <- read_csv('MyData.csv')


Disease_choices <- sort(unique(health_spending$Disease))

