library(shiny)
library(colourpicker)
library(shinydashboard)

# Define UI for application that draws a histogram
ui_header <- dashboardHeader(title = "Basic dashboard")
ui_sidebar <- dashboardSidebar(
  sidebarMenu(id = "sidebar_menu",
              menuItem("General View", tabName = "First", icon = icon("star")),
              menuItem("Detail View", tabName = "Second", icon = icon("dashboard")),
              menuItem("Comparation View", tabName = "Thrid", icon = icon("cloud")),
              menuItem("Fourth", tabName = "Fourth", icon = icon("users"))
))
ui_body <- dashboardBody(
  
  tabItems(
    tabItem(
      tabName = "Second",
      fluidPage(
        # Application title
        titlePanel(
          h1("INDIA Tourism 2014-2020 Dataset")
        ),
        mainPanel(
          
          box(width = 12,
              solidHeader = TRUE,
              title = "Plotly Scatter3",
              plotOutput("viewFirst")
          ),
          
          fluidRow(
            box(width=4,
                sliderInput("siyear", "Years:",
                            min = 2014, max = 2020,
                            value = 2014, round = 1, sep = "")
            ),
            box(width = 8,
                solidHeader = TRUE,
                title = "Plotly Scatter2",
                plotOutput("lineAge")
            ),
          ),
          box(width = 12,
              solidHeader = TRUE,
              title = "Plotly Scatter3",
              plotOutput("stackedAir")
          ),
          
          
        ))
    ),
    
    tabItem(
      tabName = "First",
      box(
        title="asdasd"
      ),
      box(width = 12,
          solidHeader = TRUE,
          title = "Plotly Scatter3",
          plotOutput("generalR")
      ),
      
      box(width = 12,
          solidHeader = TRUE,
          title = "Plotly Scatter3",
          plotOutput("scatterGeneral")
      ),
    ),
    
    tabItem(
      tabName = "Thrid",
      box(
        title="asdasd"
      )
    ),
    
    tabItem(
      tabName = "Fourth",
      box(
        title="asdasd"
      )
    )
    
  )
  
)
ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)

