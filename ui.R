library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
     
     # Application title
     titlePanel("Buzz Wing Finder"),
     
     # Sidebar with a slider input for the number of bins
     fluidRow(
          column(12,
               sliderInput("stt",
                           "BuzzStart:",
                           min = 0,
                           max = waveLen,
                           value = 0, step = 0.01, 
                           width = "100%"), 
               
               sliderInput("en",
                           "BuzzEnd",
                           min = 0,
                           max = waveLen,
                           value = waveLen, step = 0.01, 
                           width = "100%"),
               
               actionButton("listen", label = "Listen"), 
               
               actionButton("submit", label = "Submit")
          
          ),
          
     
          # Show a plot of the generated distribution
          column(12,
               plotOutput("distPlot"), 
               tags$head(tags$script(src = "enter_button.js")),
               tags$head(tags$script(src = "enter_button2.js"))
          )
     )
))