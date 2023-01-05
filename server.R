server <- function(input, output, session) {
  
  # ==== Delay loading ====
  values <- reactiveValues(finished.init = FALSE)
  session$onFlushed(function(){
    values$finished.init <- TRUE
  })
  observe({
    req(values$finished.init)
    source("./scripts/global_delayed.R")
  })
  
  # ==== Check credentials ====
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials),
    keep_token = TRUE
  )
  
  # ==== Input ui ====
  output$name_button <- renderUI({
    radioButtons("name_radio", label = "Name", choices = list("さな", "たかひろ"), selected = ifelse(res_auth$user == "takahiro","たかひろ","さな"),inline = FALSE)
  })
  
  # ==== Output Data tables ====
  output$tableAll <- renderDataTable(
    datatable(
      df_all %>% select(!uid),
      editable = "cell",
      caption = htmltools::tags$caption(
        style = "caption-side: bottom; text-align: center;",
        htmltools::em("DATA AT THE SAME DAY (editable with double clicking of cells)")
      ),
      filter = "top",
      options = list(
        pageLength = 10,
        autoWidth = TRUE
      )
    )
  )
  
  observe({
    output$tableDay <- renderDataTable(
      datatable(
        df_all[df_all$date == input$date,] %>% select(!uid),
        editable = "cell",
        caption = htmltools::tags$caption(
          style = "caption-side: bottom; text-align: center;",
          htmltools::em("DATA AT THE SAME DAY (editable with double clicking of cells)")
        ),
        filter = "top",
        options = list(
          pageLength = 10,
          autoWidth = TRUE
        )
      )
    )
  })
}