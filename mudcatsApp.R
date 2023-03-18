
library(shiny)
library(tidyverse)

#Reading in the numbers
# Reading Data
mudcatsRaw <- read.csv("https://raw.githubusercontent.com/bmswnson/Mudcats/main/Data/currentStats.csv")

#Creating full names
mudcatsRaw$fullName <- paste(mudcatsRaw$First, mudcatsRaw$Last, sep = " ")



#Mudcats App

# Define UI for miles per gallon app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Mudcat Stats"), #Name of app
  
  # Sidebar panel for inputs ----
  fluidPage(
    
    # Input: Selector for variable to plot against mpg ----
    selectizeInput("variable", "Player", 
                choices = mudcatsRaw$fullName, multiple = TRUE),
    
    selectizeInput("stat", "Stats", 
                  choices = names(mudcatsRaw), multiple = TRUE), 
   
    selectInput("graph", "Graph Stats", 
                   choices = names(mudcatsRaw)),
               
                
                
                 # c("Gabe" = "Gabe_Duncan", 
                 #  "Howe" = "Isaac_Howe")),
    
    # Input: Checkbox for whether outliers should be included ----
    # checkboxInput("outliers", "Show outliers", TRUE)
    
  ),
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ----
    h3(textOutput("caption")),
    
    # Output: Table of all the outputs
    tableOutput("average"),
    
    #Plot output
    plotOutput("plot", click = "plot_click"), 
    

    
  )
)


# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  
  #update select input
  
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the
  # output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste(input$variable)
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a table of requested values
  output$average <- renderTable({

    mudcatsRaw %>% 
      filter(fullName %in% input$variable) %>% 
      select(fullName, input$stat)
    # mudcatsRaw[which(mudcatsRaw$fullName == input$variable), c("AVG")]
    
  })
  
  #creating a plot to also go in the app
  output$plot <- renderPlot({
    
    #This dataframe allows to emphasize those that are selected as an input
    highlight_df <- mudcatsRaw %>% 
      filter(fullName %in% input$variable)
  
  
    
    ggplot(data = mudcatsRaw, aes(x=fullName, y= !!as.symbol(input$graph), label = Last)) + #the !! as.symbol is necessary for inputs to be read correctly
      scale_x_discrete(guide = guide_axis(angle = 90)) +
      geom_point(alpha=0.3) +
      geom_point(data=highlight_df, 
                 aes(x = fullName, y = !!as.symbol(input$graph)), 
                 color='red',
                 size=3) + 
      geom_text(data=highlight_df,
                aes(fullName, !!as.symbol(input$graph), label=fullName), 
                size = 5, vjust = -2)
    
    
    
    #creating a table of the plot click graph
  
  }
  )
  
}



shinyApp(ui, server)


