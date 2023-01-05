server <- function(input, output) {
  
  # Check credentials
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials),
    keep_token = TRUE
  )
  
  output$auth_output <- renderPrint(
    reactiveValuesToList(res_auth)
  )
  
  output$name_button <- renderUI({
    radioButtons("name_radio", label = "Name", choices = list("さな", "たかひろ"), selected = ifelse(res_auth$user == "takahiro","たかひろ","さな"),inline = FALSE)
  })
    
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