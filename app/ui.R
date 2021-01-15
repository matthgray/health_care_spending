shinyUI(
  dashboardPage(
    
    # Application title
    dashboardHeader(title = HTML("Health Spending"),
    titleWidth = 250),
    
    # Sidebar with a slider input for number of bins
    
    dashboardSidebar(

      width = 300,
      selectInput("Disease",
                  "Choose a disease:",
                  choices = Disease_choices,
                  selected = Disease_choices[1])

    ),
    #distPlot
    # Show a plot of the generated distribution
    dashboardBody(
      fluidRow(
        tabBox(
          title = "First",
          id = "distPlot", height = "300px", width = "300px",
          tabPanel("Bar Plot",plotOutput("Bar")),
          tabPanel("Dot Plot", plotOutput("Dot"))
        ),

      )
    )
    
  )
)
