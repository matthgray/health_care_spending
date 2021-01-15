
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
      ggtitle(input$Disease) +
      geom_bar(fill = "steelblue",stat="identity")+
      geom_text(aes(label=Expenditure), vjust=1.6, color="black", size=3.5)+
      theme_dark()
  })
  output$Dot <- renderPlot({
    health_spending %>%
      filter(Disease == input$Disease) %>%
      ggplot(aes(Year, Expenditure)) +
      ggtitle(input$Disease) +
      geom_point(size = 3) +
      geom_smooth(method = lm)
  })
  
})
