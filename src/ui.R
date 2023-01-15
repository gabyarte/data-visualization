library(shiny)
library(colourpicker)
library(shinydashboard)

# Define UI for application that draws a histogram
ui_header <- dashboardHeader(title = "India Tourism in the Open")

ui_sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebar_menu",
    menuItem("General View", tabName = "First", icon = icon("star")),
    menuItem("Detail View", tabName = "Second", icon = icon("dashboard")),
    menuItem("Comparisons View", tabName = "Thrid", icon = icon("cloud")),
    menuItem("Fourth", tabName = "Fourth", icon = icon("users"))
))

ui_body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "First",
      fluidPage(
        titlePanel(
            h2("India Tourism Overview Evolution Through Years")
          ),
        mainPanel(
          width = 12,
          h4("Analysis of the visitors and incomes earned due to the tourism in India and the evolution of it through the years"),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("generalR")
          ),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("scatterGeneral")
          ),
        )
      )
    ),

    tabItem(
      tabName = "Second",
      fluidPage(
        # Application title
        titlePanel(
          h2("Yearly analysis of tourism")
        ),
        mainPanel(
          width = 12,
          h4("Analysis of the important statistics regarding airport visitors, visitors' nationalities and age groups."),
          box(width = 12,
              sliderInput("siyear", "Years:",
                          min = 2014, max = 2020,
                          value = 2014, round = 1, sep = "")
          ),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("stackedAir")
          ),
          fluidRow(
            box(width = 3,
              radioButtons(
              "categorical_choice",
              h4("Select variable to analyze"),
              choices = list(
                "Age Groups",
                "Continent",
                "Sex",
                "Transport mean"
              ),
              selected = "Age Groups")
            ),
            box(width = 9,
              solidHeader = TRUE,
              plotOutput("lineAge")
            ),
          ),
        ))
    ),

    tabItem(
      tabName = "Thrid",
      box(
        title = "asdasd"
      )
    ),

    tabItem(
      tabName = "Fourth",
      box(
        title = "asdasd"
      )
    )
  )
)

ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)
