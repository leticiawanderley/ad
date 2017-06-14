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
  fluidPage(
    
    h3("Variação das notas dos usuários por episódio"),
    fluidRow(
      column(3,
             selectInput("serie", label = h4("Selecione sua série"), 
                         choices = list("13 Reasons Why", "How to Get Away with Murder", "Mr Robot",
                                        "Sense8", "Sherlock", "Black Mirror", "Breaking Bad",
                                        "Dexter", "House of Cards", "Stranger Things", "Arrow",
                                        "Gotham", "Grey’s Anatomy"), selected = "13 Reasons Why"))
      ),
      column(9,
             plotlyOutput(outputId = "general", width = "100%")
      )
    ),
    
    
    br(),
    hr(),
    br(),
    
    fluidRow(
      column(3,
             selectInput("season", "Temporada:", 
                         choices = unique(series$season),
                         selected = 1)
      ),
      column(7,
             plotlyOutput(outputId = "specific_season", width = "50%")
      )
    )
  )
)
