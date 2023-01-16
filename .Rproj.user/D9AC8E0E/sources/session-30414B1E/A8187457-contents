library(shiny)
library(colourpicker)
library(shinydashboard)

countries <- list("Canada" = "Canada",
                  "U.S.A" = "U.S.A",
                  "Argentina" = "Argentina",
                  "Brazil" = "Brazil",
                  "Mexico" = "Mexico",
                  "Austria" = "Austria",
                  "Belgium" = "Belgium",
                  "Denmark" = "Denmark",
                  "Finland" = "Finland",
                  "France" = "France",
                  "Germany" = "Germany",
                  "Greece" = "Greece",
                  "Ireland" = "Ireland",
                  "Italy" = "Italy",
                  "Netherlands" = "Netherlands",
                  "Norway" = "Norway",
                  "Portugal" = "Portugal",
                  "Spain" = "Spain",
                  "Sweden" = "Sweden",
                  "Switzerland" = "Switzerland",
                  "U.K." = "U.K.",
                  "Czech Rep." = "Czech Rep.",
                  "Hungary" = "Hungary",
                  "Kazakhstan" = "Kazakhstan",
                  "Poland" = "Poland",
                  "Russian Fed" = "Russian Fed",
                  "Ukraine" = "Ukraine",
                  "Egypt" = "Egypt",
                  "Kenya" = "Kenya",
                  "Mauritius" = "Mauritius",
                  "Nigeria" = "Nigeria",
                  "South Africa" = "South Africa",
                  "Sudan" = "Sudan",
                  "Tanzania" = "Tanzania",
                  "Bahrain" = "Bahrain",
                  "Iraq" = "Iraq",
                  "Israel" = "Israel",
                  "Oman" = "Oman",
                  "Saudi Arabia" = "Saudi Arabia",
                  "Turkey" = "Turkey",
                  "U.A.E." = "U.A.E.",
                  "Yemen Arab Rep." = "Yemen Arab Rep.",
                  "Afghanistan" = "Afghanistan",
                  "Bangladesh" = "Bangladesh",
                  "Bhutan" = "Bhutan",
                  "Iran" = "Iran",
                  "Maldives" = "Maldives",
                  "Nepal" = "Nepal",
                  "Pakistan" = "Pakistan",
                  "Sri Lanka" = "Sri Lanka",
                  "Indonesia" = "Indonesia",
                  "Malaysia" = "Malaysia",
                  "Myanmar" = "Myanmar",
                  "Philippines" = "Philippines",
                  "Singapore" = "Singapore",
                  "Thailand" = "Thailand",
                  "Vietnam" = "Vietnam",
                  "China" = "China",
                  "Japan" = "Japan",
                  "Rep. of Korea" = "Rep. of Korea",
                  "Taiwan" = "Taiwan",
                  "Australia" = "Australia",
                  "New Zealand" = "New Zealand")

ui_header <- dashboardHeader(title = "India Tourism in the Open")

ui_sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebar_menu",
    menuItem("General View", tabName = "First", icon = icon("star")),
    menuItem("Detail View", tabName = "Second", icon = icon("dashboard")),
    menuItem("Comparisons View", tabName = "Thrid", icon = icon("cloud"))
))

ui_body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "First",
      fluidPage(
        titlePanel(
            h2("India Tourism Overview")
          ),
        mainPanel(
          width = 12,
          h4(
            "This section describes the evolution of visitors to India through years."),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("generalR")
          ),
          h4(
            "The second design is based on presenting the incomes obtained from tourism per year and its relationship with the number of visitors."
          ),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("scatterGeneral")
          ),
          h4(
            "Finally, the correlation between visitors and incomes quarterly is shown."
          ),
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("thirdGraph")
          ),
        )
      )
    ),

    tabItem(
      tabName = "Second",
      fluidPage(
        titlePanel(
          h2("Yearly analysis of tourism")
        ),
        mainPanel(
          width = 12,
          h4("Analysis of the important statistics regarding airport visitors, visitor's nationalities and age groups."),
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
      fluidPage(
        titlePanel(
          h2("Tourist's nationalities comparisons")
        ),
        mainPanel(
          width = 12,
          h4("This section highlights the comparison between visitors' nationalities regarding the frequency over time."),
          box(width = 12,
            selectInput(inputId = "country1",
                        label = "Select first country",
                        choices = countries,
                        selected =  "Canada"),
            selectInput(inputId = "country2",
                        label = "Select second country",
                        choices = countries,
                        selected =  "U.S.A")
          ),
        ),
      ),

      box(width = 12,
          solidHeader = TRUE,
          plotOutput("linePlot"),
          click = "plot_click",
          dblclick = dblclickOpts(id = "plot_dblclick"),
      ),
    )
  )
)

ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)
