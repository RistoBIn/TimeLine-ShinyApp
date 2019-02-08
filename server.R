library(shiny)  
library(dplyr)
library(timevis)
library(tidyverse)
library(lubridate)

by_modality <- termine %>% 
               group_by(Modality) %>% 
               summarise(count=n()) %>% 
               mutate(id=c(1:4))

mergedata <- merge(termine, by_modality, all=TRUE)

mergedata$period <- as.Date(mergedata$Termin)

myfunc <- function(inputdate) {
  per_day <- filter(mergedata, period >= inputdate & period <= inputdate)
  return(per_day)
}

shinyServer(
  
  function(input, output, session) {
    output$timeline <- renderTimevis(
      timevis(data = data.frame(
        content = c(myfunc(input$date)[['PatID']]),
        start   = c(myfunc(input$date)[['Termin']]),
        group = c(myfunc(input$date)[['id']])),
        groups = data.frame(id = 1:4, content = c(by_modality[['Modality']]))
      )
    )
  
})
