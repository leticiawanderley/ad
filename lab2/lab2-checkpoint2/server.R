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
library(plotly)

series <- read_csv("series_from_imdb.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  observe({
    x <- input$serie
    
    # Can use character(0) to remove all choices
    if (is.null(x))
      x <- character(0)
    
    # Can also set the label and select items
    updateSelectInput(session, "season",
                      choices = unique(series[series$series_name == x,]$season)
    )
  })
  
  serie <- reactive({
    series[series$series_name == input$serie,]
  })
  
  output$general <- renderPlotly({
    graph <- 
      ggplot(serie(), aes(x=series_ep, y=UserRating, alpha=season)) + 
      theme_bw() +
      geom_smooth(size=.5, method = 'loess', alpha=.2, 
                  colour="lightslateblue", fill="lightslateblue") +
      geom_point(aes(text=paste('Nome:', Episode, '<br>Nota:', UserRating, 
                                '<br>Temporada:', season, '<br>Episódio:', series_ep)), 
                 colour="lightslateblue", size=.9) +
      scale_alpha_continuous(range = c(0.3, 1)) +
      theme(legend.title=element_blank()) +
      theme(legend.position="none") +
      labs(title=serie()$series_name, x="Episódio da série", y="")
    
    ggplotly(graph, tooltip = c("text"), width = 800) %>%
      layout(autosize=TRUE)

  })
  
  output$specific_season <- renderPlotly({
    specific_season <- 
      ggplot(serie()[serie()$season == input$season,], aes(x=season_ep, y=UserRating, alpha=season)) + 
      theme_bw() +
      geom_line(size=.5, colour="aquamarine3", alpha=.3) +
      geom_point(aes(text=paste('Nome:', Episode, '<br>Nota:', UserRating, 
                                '<br>Temporada:', season, '<br>Episódio:', season_ep)),
                 colour="aquamarine3") +
      theme(legend.title=element_blank()) +
      theme(legend.position="none") +
      labs(title=paste(serie()$series_name,
                       " - Temporada ", serie()$season), x="Episódio da temporada", y="")
    
    ggplotly(specific_season, tooltip = c("text"), width = 480) %>%
      layout(autosize=TRUE)
  })
})
