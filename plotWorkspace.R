

# Reading Data
mudcatsRaw <- read.csv("https://raw.githubusercontent.com/bmswnson/Mudcats/main/Data/currentStats.csv")

View(mudcatsRaw)

#Creating full names
mudcatsRaw$fullName <- paste(mudcatsRaw$First, mudcatsRaw$Last, sep = "_")


plot <- mudcatsRaw %>% 
  filter(fullName == "Gabe Duncan") %>% 
  select(AVG, OPS)


plot(plot$AVG, plot$OPS)





mudcatsRaw %>% 
  ggplot(aes(x=AVG,y=OPS)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x=AVG,y=OPS), 
             color='red',
             size=3) + geom_text()

highlight_df <- mudcatsRaw %>% 
  filter(fullName == "Toby Sayles")


ggplot(data = mudcatsRaw, aes(x=AVG, y=OPS, label = Last)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x=AVG,y=OPS), 
             color='red',
             size=3) + 
  geom_text(data=subset(mudcatsRaw, fullName == "Toby Sayles"),
            aes(AVG,OPS,label=fullName), 
            size = 2.5, vjust = 2) 




ggplot(data = highlight_df, aes(x = fullName, y = AVG, label = Last)) + 
  geom_text(size = 2.5, vjust = 2) +
  geom_point() + 
  scale_y_continuous(breaks = seq(0,1,.05)) +
  ylim(0, .75) +
  scale_x_discrete(expand = c(.04, .08)) +
  theme(axis.text.x = element_text(angle = 90, size = 0)) + 
  ggtitle(paste("Team Averages")) 


mudcatsRaw %>% 
  ggplot(aes(x=AVG,y=OPS)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x=AVG,y=OPS), 
             color='red',
             size=3) 


ggplot(data = mudcatsRaw, aes(x=AVG, y=OPS)) + 
  geom_point(alpha=0.3) +
  geom_point(mudcatsRaw, fullName == "Toby Sayles", 
             color='red',
             size=3) + 
  geom_text(data=subset(mudcatsRaw, fullName == "Toby Sayles"),
            aes(label=fullName), 
            size = 2.5, vjust = 2) 


highlight_df <- mudcatsRaw %>% 
  filter(fullName == "Toby Sayles")


ggplot(data = mudcatsRaw, aes(x=AVG, y=OPS, label = Last)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x=AVG,y=OPS), 
             color='red',
             size=3) + 
  geom_text(data=subset(mudcatsRaw, fullName == "Toby Sayles"),
            aes(AVG,OPS,label=fullName), 
            size = 3, vjust = -2) + 
  ggtitle(paste("Average and OPS"))



ui <- fluidPage(
  titlePanel("MTCARS"),
  selectInput("Columns","Columns",
              names(mtcars), multiple = TRUE),
  verbatimTextOutput("dfStr")
)

server <- function(input, output) {
  Dataframe2 <- reactive({
    mtcars[,input$Columns] 
  })
  output$dfStr <- renderPrint({
    str(Dataframe2())
  })
}

shinyApp(ui, server)

ggplot(data = mudcatsRaw, aes(x=fullName, y=AVG, label = Last)) + 
  geom_point(alpha=0.3) + 
  Geom_point(data=highlight_df, 
                                  aes(x = fullName,y = input$graph), 
                                  color='red',
                                  size=3) + 
  geom_text(data=subset(mudcatsRaw, fullName %in% input$variable),
            aes(AVG,OPS,label=fullName), 
            size = 5, vjust = -2) + 
  ggtitle(paste(input$graph))


highlight_df <- mudcatsRaw %>% 
  filter(fullName %in% c("Toby Sayles", "Isaac Howe"))


ggplot(data = mudcatsRaw, aes(x=fullName, y=AVG, label = Last)) + 
  geom_point(alpha=0.3) +
  geom_point(data=highlight_df, 
             aes(x = fullName, y = AVG), 
             color='red',
             size=3) + 
  geom_text(data=highlight_df,
            aes(fullName, AVG, label=fullName), 
            size = 5, vjust = -2)



