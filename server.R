library(shiny)
require(graphics)

shinyServer(function(input, output) {
  #reminder: add expected value at some point
  output$text1 <- renderText({
    runs <- input$runs
    if (runs == 1){
    paste("You have selected ", input$runs, " run.")
    }else{
      paste("You have selected ", input$runs, " runs.")
    }
  })
  
  output$pnl <- renderPlot({
    wr <- input$winRate
    ts <- input$tSize/100
    ws <- input$wSize/100
    ls <- input$lSize/100
    d <- input$days
    tpd <- input$tradesPerDay
    runs <- input$runs

    cumulateFunction <- function(d, tpd, wr, ts, ls){
      cumulate <- numeric(d)
      dailyChange <- numeric(d)
      dailyChange[1] <- 0
      cumulate[1] <- 100000
      for (i in 2:d){
        for (j in 1:tpd){
          ran <- sample(1:100, 1)
          if (ran <= wr){
            unif1 <- runif(1, min = 0, max = 2*ws) #using irwin-hall distribution as a sub for a normal distribution of values, since I only want positive values
            unif2 <- runif(1, min = 0, max = 2*ws) #using n = 8 to simulate decent discipline, not a whole lot of randomness
            unif3 <- runif(1, min = 0, max = 2*ws)
            unif4 <- runif(1, min = 0, max = 2*ws)
            unif5 <- runif(1, min = 0, max = 2*ws)
            unif6 <- runif(1, min = 0, max = 2*ws)
            unif7 <- runif(1, min = 0, max = 2*ws)
            unif8 <- runif(1, min = 0, max = 2*ws)
            ran2 <- c(unif1, unif2, unif3, unif4, unif5, unif6, unif7, unif8) #damn this looks messy, reminder to clean at some point
            dailyChange[i] <- dailyChange[i] + ts*cumulate[i-1]*mean(ran2)
          }else{
            unif1 <- runif(1, min = 0, max = 2*ls) #using irwin-hall distribution as a sub for a normal distribution of values, since I only want positive values
            unif2 <- runif(1, min = 0, max = 2*ls)
            unif3 <- runif(1, min = 0, max = 2*ls)
            unif4 <- runif(1, min = 0, max = 2*ls)
            unif5 <- runif(1, min = 0, max = 2*ls)
            unif6 <- runif(1, min = 0, max = 2*ls)
            unif7 <- runif(1, min = 0, max = 2*ls)
            unif8 <- runif(1, min = 0, max = 2*ls)
            ran2 <- c(unif1, unif2, unif3, unif4, unif5, unif6, unif7, unif8) 
            dailyChange[i] <- dailyChange[i] - ts*cumulate[i-1]*mean(ran2)
          }
        }
        cumulate[i] = cumulate[i-1] + dailyChange[i]
      }
      return (cumulate)
    }
    
    if (runs == 1){
      x <- c(1:d)
      y <- cumulateFunction(d, tpd, wr, ts, ls)
      
      DF<- data.frame(1:d, matrix(c(y), ncol=1))
      colnames(DF) <- c('Day', paste0('Run', 2:ncol(DF)-1))
      DF.TS <- ts(DF[-1], start = 1, frequency = 1)
      
      ts.obj <- ts(x)
      lowess.obj <- lowess(ts.obj, f = 1)
      plot(DF.TS, plot.type = "single", ylab="Total Equity ($)", col=1:ncol(DF.TS))
      legend("topleft", colnames(DF.TS), col=1:ncol(DF), lty =1, cex=1)
      
    }
    else if (runs == 5){
      x <- c(1:d)
      y <- cumulateFunction(d, tpd, wr, ts, ls)
      y1 <- cumulateFunction(d, tpd, wr, ts, ls)
      y2 <- cumulateFunction(d, tpd, wr, ts, ls)
      y3 <- cumulateFunction(d, tpd, wr, ts, ls)
      y4 <- cumulateFunction(d, tpd, wr, ts, ls)
      
      DF<- data.frame(1:d, matrix(c(y, y1, y2, y3, y4), ncol=5))
      colnames(DF) <- c('Day', paste0('Run', 2:ncol(DF)-1))
      DF.TS <- ts(DF[-1], start = 1, frequency = 1)
      
      ts.obj <- ts(x)
      lowess.obj <- lowess(ts.obj, f = 1)
      plot(DF.TS, plot.type = "single", ylab="Total Equity ($)", col=1:ncol(DF.TS))
      legend("topleft", colnames(DF.TS), col=1:ncol(DF), lty =1, cex=0.65)
      
    }
    else if (runs == 20){
      x <- c(1:d) #what follows could be a lot prettier but this is the quick and dirty version
      y <- cumulateFunction(d, tpd, wr, ts, ls)
      y1 <- cumulateFunction(d, tpd, wr, ts, ls)
      y2 <- cumulateFunction(d, tpd, wr, ts, ls)
      y3 <- cumulateFunction(d, tpd, wr, ts, ls)
      y4 <- cumulateFunction(d, tpd, wr, ts, ls)
      y5 <- cumulateFunction(d, tpd, wr, ts, ls)
      y6 <- cumulateFunction(d, tpd, wr, ts, ls)
      y7 <- cumulateFunction(d, tpd, wr, ts, ls)
      y8 <- cumulateFunction(d, tpd, wr, ts, ls)
      y9 <- cumulateFunction(d, tpd, wr, ts, ls)
      y10 <- cumulateFunction(d, tpd, wr, ts, ls)
      y11 <- cumulateFunction(d, tpd, wr, ts, ls)
      y12 <- cumulateFunction(d, tpd, wr, ts, ls)
      y13 <- cumulateFunction(d, tpd, wr, ts, ls)
      y14 <- cumulateFunction(d, tpd, wr, ts, ls)
      y15 <- cumulateFunction(d, tpd, wr, ts, ls)
      y16 <- cumulateFunction(d, tpd, wr, ts, ls)
      y17 <- cumulateFunction(d, tpd, wr, ts, ls)
      y18 <- cumulateFunction(d, tpd, wr, ts, ls)
      y19 <- cumulateFunction(d, tpd, wr, ts, ls)
      
      #need to fix this ugly as sin code at some point
      DF<- data.frame(1:d, matrix(c(y, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19), ncol=20))
      colnames(DF) <- c('Day', paste0('Run', 2:ncol(DF)-1))
      DF.TS <- ts(DF[-1], start = 1, frequency = 1)
      
      ts.obj <- ts(x)
      lowess.obj <- lowess(ts.obj, f = 1)
      plot(DF.TS, plot.type = "single", ylab="Total Equity ($)", col=1:ncol(DF.TS))
      legend("topleft", colnames(DF.TS), col=1:ncol(DF), lty =1, cex=0.5)

    }
    
      
  })
  
})

