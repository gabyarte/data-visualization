library(shiny)
library(dplyr)
library(ggplot2)
library(viridis)
library(tidyr)
library(readr)
library(scales)

yearly_isitors <- read.csv("../data/input/yearly-visitors.csv")

# Define server logic required to draw graphs
shinyServer(function(input, output) {
  output$linePlot <- renderPlot({

    # select a city
    city_of_choice <- c(input$country1, input$country2)
    crime_data_city <- yearly_isitors %>%
      filter(country == city_of_choice)

    plot_title <- paste("Annual Visitors per Year and Country")
    # select crime type based on input$crime from ui.R
    ggplot(crime_data_city, aes_string(
        x = "year",
        y = "annual_visitors",
        colour = "country")) +
      geom_line() +
      geom_point(size = 3) +
      scale_y_continuous(name = "visitors", labels = comma) +
      scale_color_discrete(name = "country") +
      ggtitle(plot_title) +
      theme(plot.title = element_text(size = 20, hjust = 0.5),
            axis.title.y = element_text(size = 13, vjust = 0.5, angle = 0),
            axis.title.x = element_text(size = 13, angle = 0),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12)
      )
  })
  # click and dbclick interaction for comparing two data points
  output$click_info <- renderPrint({
    cat("Single-Click to select one \n point on the graph:\n")
    str(input$plot_click$x)
    str(input$plot_click$y)
  })
  output$dblclick_info <- renderPrint({
    cat("Double-Click to select another\n point on the graph:\n")
    str(input$plot_dblclick$x)
    str(input$plot_dblclick$y)
  })
})
