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
      aes_string(
        x = "year",
        y = "sum_visitors",
        group = 1)) +
    geom_line() +
    ggtitle(plot_title) +
    geom_point(size = 3) +
    geom_line(
      aes_string(y = "avg_income"),
      color = "#228f22") +
    scale_y_continuous(labels = comma) +
    labs(x = "Years", y = "Visitors / Income") +
    theme(plot.title = element_text(size = 20, hjust = 0.5),
          axis.title.y = element_text(size = 13),
          axis.title.x = element_text(size = 13),
          axis.text.y = element_text(size = 12),
          axis.text.x = element_text(size = 12)
    )
  })

  ##general
  output$scatterGeneral <- renderPlot({
    df_income <- read.csv("./../data/input/income.csv")
    plot_title <- paste("Incomes per year related with the number of visitors")
    ggplot(
        data = df_income,
        aes_string(
          x = "year",
          y = "ingresos",
          size = "visitantes",
          label = "visitantes")) +
      geom_point(color = "#228f22", show.legend = FALSE) +
      geom_text(hjust = -0.4, vjust = 0, size = 5) +
      ggtitle(plot_title) +
      labs(x = "Year", y = "Incomes (US$ billions)") +
      scale_y_continuous(labels = comma) +
      theme(plot.title = element_text(size = 20, hjust = 0.5),
            axis.title.y = element_text(size = 13),
            axis.title.x = element_text(size = 13),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12),
      )
  })

  ## Detailed view
  output$lineAge <- renderPlot({
    df_age_group <- read.csv("./../data/input/yearly_categories.csv")
    plot_title <- paste("Amount of people per variable in", input$siyear)
    choice <- input$categorical_choice

    ggplot(
      data = df_age_group %>%
        filter(category == choice, year == input$siyear),
      aes(x = " ", y = value, fill = variable)) +
    geom_bar(stat = "identity", width = 1, color = "white") +
    coord_polar("y", start = 0) +
    theme_void() +
    geom_text(
      aes(y = cumsum(value) - min(value) / 2,
          label = value),
      size = 4) +
    scale_fill_brewer(palette = "Greens") +
    ggtitle(plot_title) +
    labs(fill = choice) +
    theme(plot.title = element_text(size = 20, hjust = 0.5))
  })

  output$stackedAir <- renderPlot({
    df_air_continent <- read.csv(
      "./../data/input/annual_visitors_air.csv", sep = ";")
    plot_title <- paste("Amount of people per airport in", input$siyear)

    ggplot(
      data = df_air_continent %>%
        filter(year == input$siyear),
      aes_string(
        x = "airport",
        y = "annual_visitors_air",
        fill = "Continente")) +
    geom_bar(stat = "identity", width = 0.5) +
    scale_y_continuous(labels = comma) +
    labs(x = "Airport", y = "Visitors") +
    ggtitle(plot_title) +
    theme(plot.title = element_text(size = 20, hjust = 0.5),
          axis.title.y = element_text(size = 13),
          axis.title.x = element_text(size = 13),
          axis.text.y = element_text(size = 12),
          axis.text.x = element_text(size = 12),
    )
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
            axis.title.x = element_text(size = 13, angle = 0),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12)
      )
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
