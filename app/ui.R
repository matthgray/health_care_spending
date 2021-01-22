shinyUI(
  dashboardPage(
    
    # Application title
    dashboardHeader(title = HTML("Health Spending"),
    titleWidth = 250),
    
    # Sidebar with a slider input for number of bins
    
    dashboardSidebar(

      width = 300,
      sidebarMenu(
        id = "Health",
        style = "position: relative;overflow: visible;",
      
      selectInput("Disease",
                  "Choose a disease:",
                  choices = Disease_choices,
                  selected = Disease_choices[1])
      )

    ),
    #distPlot
    # Show a plot of the generated distribution
    dashboardBody(
      fluidRow(
        tabBox(
          title = "Expenditure in billions",
          id = "distPlot", height = "300px", width = "300px",
          tabPanel("Manual",h2("This application allows the user to visualize
                   data from the Bureau of Economic Analysis on healthcare spending by disease."),br(),
                   strong("How to use this application"),br(),
                   h3("Given you have the side bar open in the top left. When you click on the disease. Then the graph shows the data for that disease."),
                   ),
          tabPanel("Spending over the years",valueBoxOutput("approvalBox"),
                   valueBoxOutput("stdBox"), valueBoxOutput("diffBox"),plotOutput("Bar")),
          tabPanel("Relationship between years and spending", plotOutput("Dot"))

        ),

      )
    )
    
  )
)
