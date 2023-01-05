ui <- navbarPage(
  
  # Base settings
  title = "CASH BOOK",
  id = "navPage",
  position = "static-top",
  footer = tags$footer("(c)takahirohashimoto 2022"),
  inverse = TRUE,
  collapsible = TRUE,
  windowTitle = "CASH BOOK | sana and takahiro",
  
  # Form and Table
  tabPanel(
    
    # Base settings
    title = "FORM and TABLE",
    
    sidebarLayout(
      
      # Input form
      sidebarPanel(
        tags$h2("INPUT FORM"),
        inputPanel(
          dateInput("date", label = "Date Purchased", value = tail(df_all$date,1)),
          uiOutput("name_button")
        ),
        inputPanel(
          selectInput("place", label = "Place", choices = df_all$place[!is.na(df_all$place)], selected = tail(df_all$place[!is.na(df_all$place)],1)),
          selectInput("category", label = "Category", choices = df_all$category[!is.na(df_all$category)], selected = TRUE),
          selectInput("event", label = "Event", choices = df_all$event[!is.na(df_all$event)], selected = TRUE),
          numericInput("amount", label = "Price", value = round(median(df_all$amount)))
        ),
        actionButton(
          inputId = "Submit",
          label = "Submit"
        )
      ),
      
      # Show table
      mainPanel(
        verbatimTextOutput("auth_output"),
        tags$h2("DATA TABLE"),
        tabsetPanel(
          tabPanel("DATA THE DAY", dataTableOutput("tableDay")),
          tabPanel("DATA ALL",  dataTableOutput("tableAll"))
        ) 
      )
    )
  ),
  
  # Plotting
  tabPanel(
    title = "PLOTS"
  ),
  
  # Prediction Models
  tabPanel(
    title = "MODELS"
  )
)

ui <- secure_app(ui)