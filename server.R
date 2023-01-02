server <- function(input, output) {
    
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