library(shiny)

# Load data and get typical values for wt and hp
data(mtcars)
minwt <- round(min(mtcars$wt),2)
maxwt <- round(max(mtcars$wt),2)
avgwt <- round(mean(mtcars$wt),2)
minhp <- round(min(mtcars$hp),0)
maxhp <- round(max(mtcars$hp),0)
avghp <- round(mean(mtcars$hp),0)

shinyUI(fluidPage(
  
  titlePanel("Prediction of mileage using Motor Trend (mtcars) data set"),
  
  sidebarLayout(
    sidebarPanel(
      # Car weight - Decimal value
      sliderInput("wt", "Weight (wt) in 1000 lbs:", 
                  min = minwt, max = maxwt, value = avgwt, step = 0.01),
      
      # Number of cylinders - Integer value
      radioButtons("cyl", label = "Number of cylinders (cyl):",
                   choices = list("4" = 4, "6" = 6, "8" = 8),selected = 4),
      
      # Horse power - Integer value
      sliderInput("hp", "Gross horse power (hp):", 
                  min = minhp, max = maxhp, value = avghp, step = 1),
      
      # Transmission - Integer value
      radioButtons("am", label = "Transmission type (am):",
                   choices = list("Automatic" = 0, "Manual" = 1),selected = 1)
      
    ),
    
    # Display regression models & their predictions
    mainPanel(

      p("This app and its reproducible pitch present multiple linear regression
        to predict the miles per gallon (MPG) for a given car specification using
        the mtcars data set."),
      
      p("Mileage obviously depends on the car weight, since a heavier vehicle will
        need more energy to drag itself. Interestingly, as shown below such a 
        minimal model is able to explain about 74.46% of the variablity in the 
        data - as shown by its adjusted R squared value."),
      
      p("The data set has ten features: weight, number of cylinders, gross horse
        power, transmission type, displacement, rear axle ratio, 1/4 mile time,
        engine type - V or straight, number of forward gears and number of 
        carburetors."),
      
      p("A systematic analysis, presented in the pitch, shows that of all 
        possible linear models from single feature (weight) to all the ten 
        features, the optimal model (with highest adjusted R squared value) 
        needs only four features: weight, number of cylinders, gross horse 
        power, and transmission type.This optimal model is presented in this 
        reactive Shiny app."),
      
      p("Note that the optimal model is able to expain 84.01% of variability
        in the data. It takes three additional features to decribe an extra 
        10% variability above the minimal model which has weight as its only
        feature!"),
      
      p("Play with the app to discover insights like automatic transmission 
        often leads to lower mileage, etc."),
      
      p("The MPG fit, its lower and upper bounds at 95% confidence level for the 
        reactive inputs are given below:"),
      
      tableOutput("values")
    )
  )
))