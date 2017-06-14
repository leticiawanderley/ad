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
                         choices = unique(series$series_name), selected = "13 Reasons Why")
             )
    ),
    br(),
    fluidRow(
      column(8,
             plotlyOutput(outputId = "general", width = "100%")
      ),
      column(1,
             p("teste teste stes")
      )
    ),
    br(),
    hr(),
    br(),
    
    fluidRow(
      column(2,
             selectInput("season", "Temporada:", 
                         choices = unique(series$season),
                         selected = 1)
      ),
      column(7, offset=1,
             plotlyOutput(outputId = "specific_season", width = "50%")
      )
    )
  )
)
)
