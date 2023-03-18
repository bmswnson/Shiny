# install.packages("shiny")

library(shiny)
library(tidyverse)

#Reading in the numbers
# Reading Data
mudcatsRaw <- read.csv("https://raw.githubusercontent.com/bmswnson/Mudcats/main/Data/currentStats.csv")

# View(mudcatsRaw)

#Creating full names
mudcatsRaw$fullName <- paste(mudcatsRaw$First, mudcatsRaw$Last, sep = "_")

mudcatsAverage <- mudcatsRaw %>% 
  select(fullName, AVG)

#removing names down
Gabe <- mudcatsRaw[1,]
Howe <- mudcatsRaw[1,]

playerAverage <- list(Gabe, Howe)


#Example App

# Define UI for miles per gallon app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Miles Per Gallon"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    # Input: Selector for variable to plot against mpg ----
    selectInput("variable", "Variable:", 
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear")),
    
    # Input: Checkbox for whether outliers should be included ----
    checkboxInput("outliers", "Show outliers", TRUE)
    
  ),
  
  # Main panel for displaying outputs ----
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ----
    h3(textOutput("caption")),
    
    # Output: Plot of the requested variable against mpg ----
    plotOutput("mpgPlot")
    
  )
)




# Data pre-processing ----
# Tweak the "am" variable to have nicer factor labels -- since this
# doesn't rely on any user inputs, we can do this once at startup
# and then use the value throughout the lifetime of the app
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
            data = mpgData,
            outline = input$outliers,
            col = "#007bc2", pch = 19)
  })
  
}



shinyApp(ui, server)




