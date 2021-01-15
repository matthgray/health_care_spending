library(shiny)
library(tidyverse)
library(shinydashboard)

library(ggplot2)
library(dplyr)
# import data



health_spending <- read_csv('CleanData.csv')


Disease_choices <- sort(unique(health_spending$Disease))

