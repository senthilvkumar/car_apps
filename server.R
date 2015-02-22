library(shiny)

# Load data and set cyl, am as categorical vars
data(mtcars)
mtcars$cyl <- factor(mtcars$cyl, levels = c(4,6,8))
mtcars$am <- factor(mtcars$am, levels = c(0,1))

## Minimal model - only feature is wt
mod_min <- lm(mpg ~ wt, data = mtcars)
adjR2_min <- round(summary(mod_min)$adj.r.squared,4)

## Optimal model - features are wt, cyl, hp and am
mod_opt <- lm(mpg ~ wt+cyl+hp+am, data = mtcars)
adjR2_opt <- round(summary(mod_opt)$adj.r.squared,4)

# Define server logic for slider
shinyServer(function(input, output) {
  
  sliderValues <- reactive({
    
    ## Prediction using the minimal model
    res_min <- predict(mod_min,data.frame(wt = input$wt),interval = "confidence")
    res_min <- round(res_min,2)

    ## Prediction using the optimal model
    res_opt <- predict(mod_opt,data.frame(wt = input$wt,
                      cyl = factor(input$cyl,levels = c(4,6,8)),
                      hp = input$hp,am = factor(input$am,levels = c(0,1))),
                      interval = "confidence")
    res_opt <- round(res_opt,2)
                
    # Compose data frame to be displayed
    data.frame(
      Model = c("Minimal","Optimal"),
      Features = c("wt only", "wt, cyl, hp & am"),
      Adj_R_sq = as.character(c(adjR2_min,adjR2_opt)),
      MPG_fit = as.character(c(res_min[1],res_opt[1])),
      MPG_lwr_bnd = as.character(c(res_min[2],res_opt[2])), 
      MPG_upr_bnd = as.character(c(res_min[3],res_opt[3])),
      stringsAsFactors=FALSE)
  }) 
  
  # Show the model results using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
})