library(shiny)
library(dplyr)
library(ggplot2)
library(viridis)
library(tidyr)
library(readr)
library(scales)
library(rsconnect)


# Define server logic required to draw graphs
shinyServer(function(input, output) {
  ## First Tab - First Graph
  output$generalR <- renderPlot({
    annual_visitors_3 <- read.csv(
      "./data/input/annual_visitors.csv", sep = ";")

    plot_title <- paste("Annual Visitors per Year")

    agg_tbl <- annual_visitors_3 %>%
      group_by(year) %>%
      summarise(sum_visitors = sum(annual_visitors),
                avg_income = max(income),
                .groups = "drop")
    df2 <- agg_tbl %>% as.data.frame()

    ggplot(
      df2,
      aes_string(
        x = "year",
        y = "sum_visitors",
        group = 1)) +
    geom_line(color = "#228f22") +
    ggtitle(plot_title) +
    geom_point(size = 3, color = "#228f22") +
    scale_y_continuous(labels = comma) +
    labs(x = "Years", y = "Visitors") +
    theme(plot.title = element_text(size = 20, hjust = 0.5),
          axis.title.y = element_text(size = 13),
          axis.title.x = element_text(size = 13),
          axis.text.y = element_text(size = 12),
          axis.text.x = element_text(size = 12)
    )
  })

  ## First Tab - Second Graph
  output$scatterGeneral <- renderPlot({
    df_income <- read.csv("./data/input/income.csv")
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
      labs(x = "Years", y = "Incomes (US$ billions)") +
      scale_y_continuous(labels = comma) +
      theme(plot.title = element_text(size = 20, hjust = 0.5),
            axis.title.y = element_text(size = 13),
            axis.title.x = element_text(size = 13),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12),
      )
  })

  ## First Tab - Third Graph
  output$thirdGraph <- renderPlot({
    df_income <- read.csv("./data/input/countryWise.csv")
    plot_title <- paste("Correlation between visitors and incomes quarterly")
    ggplot(
      data = df_income,
      aes_string(
        x = "visitors",
        y = "incomes")) +
      geom_point(color = "#228f22", show.legend = FALSE) +
      ggtitle(plot_title) +
      labs(x = "Visitors", y = "Incomes (US$ billions)") +
      scale_y_continuous(labels = comma) +
      scale_x_continuous(labels = comma) +
      theme(plot.title = element_text(size = 20, hjust = 0.5),
            axis.title.y = element_text(size = 13),
            axis.title.x = element_text(size = 13),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12),
      )
  })

  ## PIE CHART
  output$lineAge <- renderPlot({
    df_age_group <- read.csv("./data/input/yearly_categories.csv")
    plot_title <- paste("Percentage of people per variable in", input$siyear)
    choice <- input$categorical_choice

    df_age_group <- df_age_group %>%
      group_by(category, year) %>%
      mutate(sum_values = sum(value)) %>%
      as.data.frame()

    ggplot(
      data = df_age_group %>%
        filter(category == choice, year == input$siyear),
      aes(x = " ", y = value, fill = variable)) +
    geom_bar(stat = "identity", width = 1, color = "white") +
    coord_polar("y", start = 0) +
    theme_void() +
    geom_text(
      aes(label = percent(value / sum_values, accuracy = 1)),
      position = position_stack(vjust = 0.5)) +
    ggtitle(plot_title) +
    labs(fill = choice) +
    theme(plot.title = element_text(size = 20, hjust = 0.5))
  })

  ## STACKER BAR CHART
  output$stackedAir <- renderPlot({
    df_air_continent <- read.csv(
      "./data/input/annual_visitors_air.csv", sep = ";")
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
    
    df_annual_visitors <- read.csv("./data/input/annual_visitors.csv", sep=";")
    
    # select a city
    country_of_choice <- c(input$country1, input$country2)
    df_visitors <- df_annual_visitors %>%
      filter(country == country_of_choice)

    plot_title <- paste("Annual Visitors per Year and Country")
    ggplot(
      df_visitors,
      aes_string(
        x = "year",
        y = "annual_visitors",
        colour = "country")) +
      geom_line() +
      geom_point(size = 3) +
      scale_y_continuous(labels = comma) +
      scale_color_discrete(name = "country") +
      ggtitle(plot_title) +
      labs(x = "Years", y = "Number of Visitors") +
      theme(plot.title = element_text(size = 20, hjust = 0.5),
            axis.title.y = element_text(size = 13, vjust = 0.5),
            axis.title.x = element_text(size = 13),
            axis.text.y = element_text(size = 12),
            axis.text.x = element_text(size = 12)
      )
  })

  output$lineScatter <- renderPlot({
    df_income <- read.csv("./data/input/income.csv")
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
