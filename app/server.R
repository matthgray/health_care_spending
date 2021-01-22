
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    health_spending %>% 
      filter(Disease == input$Disease) %>% 
      ggplot(aes(x=Year,y=Expenditure)) +
      ggtitle(input$Disease) +
      geom_bar(fill = 'steelblue',stat="identity") +
      geom_text(aes(label=Expenditure), vjust=1.6, color="black", size=3.5)+
      theme_dark()
    
  })
  
  output$Bar <- renderPlot({
    
    health_spending %>%
      filter(Disease == input$Disease) %>% 
      ggplot(aes(x = Year,y=Expenditure)) +
      ggtitle(input$Disease,subtitle = "in billions") +
      geom_bar(fill = "steelblue",stat="identity")+
      geom_text(aes(label=Expenditure), vjust=1.6, color="black", size=3.5)+
      theme_dark()
  })
  output$Dot <- renderPlot({
    health_spending %>%
      filter(Disease == input$Disease) %>%
      ggplot(aes(Year, Expenditure)) +
      ggtitle(input$Disease,subtitle = "in billions") +
      geom_point(size = 3) +
      geom_smooth(method = lm)
  })
  output$approvalBox <- renderValueBox({
    valueBox(
      paste0(
        health_spending %>%
          filter(Disease == input$Disease) %>%
          summarize(mean(Expenditure,trim =  0.5)) %>%
          round(2)
      ),
      "Average in billions", icon = icon("calculator"), color = "green"
    )

  })
  output$stdBox <- renderValueBox({
    valueBox(
      paste0(
        health_spending %>%
          filter(Disease == input$Disease) %>%
          summarize(std = sd(Expenditure)) %>%
          round(2)
      ),
      "Distance from the mean in billions", icon = icon("calculator"), color = "red"
    )
  })
  output$diffBox <- renderValueBox({
    valueBox(
      paste0(
        health_spending %>%
          filter(Disease == input$Disease) %>%
          summarize(max(Expenditure) - min(Expenditure))
      ),
      "Difference from max and min in billions", icon = icon("calculator"), color = "blue"
    )
  })
})
