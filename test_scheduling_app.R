library("dplyr")
library("shiny")

schedule <- read.csv("C:/Users/bmswnson/Desktop/test-schedule.csv")


schedule[schedule == ""] <- NA


View(schedule)

test <- schedule %>% 
  select(names, Avery, Abbey)

test %>% 
  filter(Avery == "lab" & Abbey == "lab") %>% 
  select(names, Avery)


test %>% 
  select(where(~n_distinct(.) == 1))


test


test[which(test$Avery == "lab"), c("hours")]

as.

ui <-
  
  
  # Sidebar panel for inputs ----
  sidebarLayout(
    
                 
                 selectizeInput("variable", "ra", 
                                choices = names(schedule), multiple = TRUE), 

mainPanel(
  tableOutput("average"))
)

server <- function(input, output){
  
  output$average <- renderTable({
 
   test <- schedule %>% 
    select(names, input$variable)
   
   test %>% 
     filter(input$variable == "lab") %>% 
     select(names, input$variable)
  
   # test %>% 
   #   select(where(~n_distinct(.) == 1))
  })
  
}
                 
shinyApp(ui, server) 


for i in length (input$variable) {
  input$variable[i]
  
}
                 
      


