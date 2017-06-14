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
      column(4,
             div("O objetivo desta visualização é observar o comportamento das notas dos episódios de uma série por toda sua duração. 
                 De acordo com a distribuição das notas se pode traçar uma tendência de avaliações e tentar prever como as notas das 
                 séries se comportaram do momento atual em diante.", 
              style = "font-family: 'times'; font-size: 16pt; text-align: justify; text-justify: inter-word;"
             )
      )
    ),
    br(),
    hr(),
    br(),
    
    fluidRow(
      column(3,
             selectInput("season", "Temporada:", 
                         choices = unique(series$season),
                         selected = 1),
             div("Neste painel se pode escolher um temporada específica da série selecionada, 
                 e observar a tendência de notas dos episódios da temporada.", 
              style = "font-family: 'times'; font-size: 14pt; text-align: justify; text-justify: inter-word;"
             )
      ),
      column(7, 
             plotlyOutput(outputId = "specific_season", width = "50%")
      )
    )
  ))
)
