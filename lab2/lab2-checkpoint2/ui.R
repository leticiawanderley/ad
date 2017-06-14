#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)

series <- read_csv("series_from_imdb.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Lab 2 - Checkpoint 2"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(position = "right",
    sidebarPanel(
      selectInput("serie", label = h3("Selecione sua série"), 
                  choices = list("13 Reasons Why", "How to Get Away with Murder", "Mr Robot",
                                 "Sense8", "Sherlock", "Black Mirror", "Breaking Bad",
                                 "Dexter", "House of Cards", "Stranger Things", "Arrow",
                                 "Gotham", "Grey’s Anatomy"), selected = "13 Reasons Why"),
      
      selectInput("season", "Temporada:", 
                  choices = unique(series$season),
                  selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput(outputId = "plot", width = "100%")
    )
  )
))
