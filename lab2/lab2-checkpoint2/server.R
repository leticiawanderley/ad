#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

series <- read_csv("../series_from_imdb.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot <- renderPlot({
    
    chartSeries(series, theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })
  
})
