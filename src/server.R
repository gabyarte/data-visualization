library(shiny)
library(dplyr)
library(ggplot2)
library(viridis)
library(tidyr)
library(readr)
library(scales)

# Define server logic required to draw graphs
shinyServer(function(input, output) {
  #general
  output$generalR <- renderPlot({
    annual_visitors_3 <- read.csv(
      "./../data/input/annual_visitors.csv", sep = ";")

    plot_title <- paste("Annual Visitors and Income per Year")

    agg_tbl <- annual_visitors_3 %>%
      group_by(year) %>%
      summarise(sum_visitors = sum(annual_visitors),
                avg_income = max(income) * 100,
                .groups = "drop")
    df2 <- agg_tbl %>% as.data.frame()

    ggplot(
      df2,
      aes_string(y = "sum_visitors", x = "year", group = 1)) +
      geom_line() +
      geom_line(aes_string(y = "avg_income"), color = "red") +
      labs(x = "Year", y = "Visitors/Income") +
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

  ##general
  output$scatterGeneral <- renderPlot({
    df_income <- read.csv("./../data/input/income.csv")
    ggplot(
      data = df_income,
      aes_string(x = "Number of visitors", y = "Income")) + geom_point()
  })

  ## nationality
  output$linePlot <- renderPlot({
    df_annual_visitors <- read.csv("./../data/input/annual_visitors.csv")

    # select a city
    country_of_choice <- c(input$country1, input$country2)
    df_visitors <- df_annual_visitors %>%
      filter(country == country_of_choice)

    plot_title <- paste("Annual Visitors per Year and Country")

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
            ax
            is.title.x = element_text(size = 13, angle = 0),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12)
      )
  })

  ## Detailed view
  output$viewFirst <- renderPlot({
    df_air_continent <- read.csv(
      "./../data/input/annual_visitors_air.csv", sep = ";")
    ggplot(
      data = df_air_continent,
      aes(x = "airport", y = "annual_visitors_air", fill = "Continente")) +
      geom_bar(stat = "identity", width = 0.5) +
      scale_y_continuous(name = "visitors", labels = comma)
  })

  output$lineAge <- renderPlot({
    df_age_group <- read.csv("./../data/input/age_group.csv")
    ggplot(
      data = df_age_group,
      aes_string(x = "age_group", y = paste("X", input$siyear, sep = ""))) +
      geom_col()
  })

  output$stackedAir <- renderPlot({
    df_air_continent <- read.csv(
      "./../data/input/annual_visitors_air.csv", sep = ";")
    ggplot(
      data = df_air_continent,
      aes(x = "airport", y = "annual_visitors_air", fill = "Continente")) +
      geom_bar(stat = "identity", width = 0.5) +
      scale_y_continuous(name = "visitors", labels = comma)
  })

  output$lineScatter <- renderPlot({
    df_income <- read.csv("./../data/input/income.csv")
    ggplot(
      data = df_income,
      aes(x = "visitantes", y = "ingresos")) + geom_point()
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
