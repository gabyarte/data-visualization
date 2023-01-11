library(shiny)
library(dplyr)
library(ggplot2)
library(viridis)
library(tidyr)
library(readr)
library(scales)

# Define server logic required to draw graphs
shinyServer(function(input, output) {
  output$linePlot <- renderPlot({
    df_annual_visitors <- read.csv("./../data/input/annual_visitors.csv")

    # select a city
    country_of_choice <- c(input$country1, input$country2)
    df_visitors <- df_annual_visitors %>%
      filter(country == country_of_choice)

    plot_title <- paste("Annual Visitors per Year and Country")
    # select crime type based on input$crime from ui.R
    ggplot(
      df_visitors,
      aes_string(x = "year", y = "annual_visitors", colour = "country")) +
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

  output$lineAge <- renderPlot({
    df_age_group <- read.csv("./../data/input/age_group.csv")
    ggplot(
      data = df_age_group,
      aes_string(x = "age_group", y = paste("X", input$siyear, sep = ""))) +
      geom_col()
  })

  output$lineScatter <- renderPlot({
    df_income <- read.csv("./../data/input/income.csv")
    ggplot(
      data = df_income,
      aes_string(x = "visitantes", y = "ingresos")) + geom_point()
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

  output$out_siyear <- renderText(input$siyear)

})
