library(shiny)
library(timevis)
library(tidyverse)
library(lubridate)

# You may set full path of RDS as like following example
termine  <- readRDS('C:/users/leus/Documents/my_work/timeline/termine.RDS')
#termine  <- readRDS('termine.RDS')

shinyUI(fluidPage(
  titlePanel("Timeline"),
  sidebarLayout(
    
    sidebarPanel(
      dateInput('date',
                label = 'Date input',
                value = Sys.Date()
      )
    ),
    mainPanel(
      timevisOutput('timeline')
    )
  )
))
