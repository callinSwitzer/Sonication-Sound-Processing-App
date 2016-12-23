library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
     
     # Expression that generates a plot from timeFiddle2. The expression is
     # wrapped in a call to renderPlot to indicate that:
     #
     #  1) It is "reactive" and therefore should re-execute automatically
     #     when inputs change
     #  2) Its output type is a plot
     
     output$distPlot <- renderPlot({
          par(mai = c(0,0,0,0))
          oscillo(r, f=f)
          mtext(buzzes, side = 3, line = -1)
          abline(v = input$stt, lwd = 2, col = "green")
          abline(v = input$en, lwd = 2, col = "red")
#           timeFiddle2(bar, f = f, threshold = input$thr, msmooth = c(15000, 90),
#                       power = input$pwr)
     })
     
     observeEvent(input$listen, {
          listen(r, f=f, from = input$stt, to = input$en)
     })
     
     observe({
          if (input$submit == 0)
               return()
          stopApp(data.frame(input$stt, input$en))
     })
})