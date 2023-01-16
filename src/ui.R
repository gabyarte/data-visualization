library(shiny)
library(colourpicker)
library(shinydashboard)

# Define UI for application that draws a histogram
ui_header <- dashboardHeader(title = "India Tourism")

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
          ##h4("Analysis of the visitors and incomes earned due to the tourism in India and the evolution of it through the years"),
          h4(
            "During this section we are going to present the evolution of visitors in India through years."          ),
          
          
          box(width = 12,
              solidHeader = TRUE,
              plotOutput("generalR")
          ),
          h4(
            "The second design is based on presenting the incomes obtained from tourism per year related to the number of visitors."
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
        # Application title
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
          h2("Yearly analysis of tourism")
        ),
        mainPanel(
          width = 12,
          h4("In the following section we are highlighting the comparison between country of nationality and it's frequency over time."),
          box(width = 12,
            selectInput(inputId = "country1", 
                        label = "Select Country of Nationality 1", 
                        choices = list("Canada"= "Canada",
                                       "U.S.A" = "U.S.A",
                                       "Argentina"= "Argentina", 
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
                                       "New Zealand" = "New Zealand"),
                        selected =  "Canada")
            ,
            selectInput(inputId = "country2", 
                        label = "Select Country of Nationality 2", 
                        choices = list("Canada"= "Canada",
                                       "U.S.A" = "U.S.A",
                                       "Argentina"= "Argentina", 
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
                                       "New Zealand" = "New Zealand"),
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
    ),

    tabItem(
      tabName = "Fourth",
    )
  )
)

ui <- dashboardPage(skin = "green", ui_header, ui_sidebar, ui_body)
