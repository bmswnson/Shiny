library("shiny")


mudcatsStats <- 
  read.csv("C:/Users/bmswnson/Downloads/gc-mudcats_summer-2022_Qualified_SeasonStats-2023-05-05.csv", 
           skip = 1, 
           header = TRUE)





## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Enter Gamechanger file",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE)
      ),
      mainPanel(
        tableOutput("contents")
      )
    )
  )
  
  server <- function(input, output) {
    output$contents <- renderTable({
      # input$file1 will be NULL initially. After the user selects
      # and uploads a file, it will be a data frame with 'name',
      # 'size', 'type', and 'datapath' columns. The 'datapath'
      # column will contain the local filenames where the data can
      # be found.
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      read.csv(inFile$datapath, 
               skip = 1, 
               header = input$header)
    })
  }
  
  shinyApp(ui, server)
}