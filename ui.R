ui <- fluidPage(
  
  # Application title
  titlePanel("CASH BOOK sana and takahiro"),
  
  # Inputs
  
  sidebarLayout(
    sidebarPanel(
      tags$h2("DATA INPUT"),
      dateInput("date", label = "Date"),
      selectInput("name", label = "Name", choices = df_all$name, selected = tail(df_all$name,1)),
      selectInput("place", label = "Place", choices = df_all$place, selected = mode(df_all$place[!is.na(df_all$place)])),
      selectInput("category", label = "Category", choices = df_all$category, selected = mode(df_all$category[!is.na(df_all$category)])),
      selectInput("event", label = "Event", choices = df_all$event, selected = mode(df_all$event[!is.na(df_all$event)])),
      numericInput("amount", label = "Price", value = median(df_all$amount))
    ),
    
    mainPanel(
      plotOutput(plot(df_all))
    )
  )
)