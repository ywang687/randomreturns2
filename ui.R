library(shiny)

shinyUI(fluidPage(
  titlePanel(h1("Randomness of Returns (portfolio version)")),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select inputs for this simulation. Assume values 
               are after consideration of trading fees. Default values are set to 10% trade size, 30% winrate, 
               with 10% avg profit and 5% avg loss over 100 days."), 
      
      sliderInput("tSize", 
                   label = "Trade Size (% of portfolio at risk per trade):", 
                   value = 10,
                   min = 1, 
                   max = 100,
                   step = 1), 
      
      sliderInput("winRate", 
                  label = "Win Rate (% of trades that are good):", 
                  min = 0, max = 100, value = 30),
      
      numericInput("wSize", 
                  label = "Win Size (mean % earned per good trade):", 
                  value = 10,
                  min = 1, 
                  max = 100,
                  step = 1), 
      
      numericInput("lSize",
                  label = "Loss size (mean % lost in a bad trade):", 
                  value = 5,
                  min = 1, 
                  max = 100,
                  step = 1), 
      
      sliderInput("days", 
                  label = "Trading days in consideration:", 
                  min = 10, max = 1000, value = 100), 
      
      sliderInput("tradesPerDay", 
                  label = "Trades per day:", 
                  min = 1, max = 100, value = 1), 
      
      selectInput("runs", 
                  label = "Number of runs:",
                  choices = list("1 run" = 1, "5 runs" = 5, 
                                 "20 runs" = 20), selected = 5)
      
      
    ),
      
    mainPanel(p("Like the original Randomness of Returns app, this is meant to demonstrate how factors 
beyond your control can have a significant effect (maybe as significant as the efficacy of your
actual strategy) on your trading. The difference is, in this app, I wanted to focus on the 
people who are not daytraders scalping for that microprofit many times a day (something I realize is not 
everyone's cup of tea). This is for the people 
with portfolios, who have a slightly different approach when it comes to evaluating risk. Namely, 
if you're an investor, you're much more likely to look at % gains and losses, and % of capital at 
risk in any single trade, as opposed to dollar values. As a non-daytrader, you might think that randomness will have a lower impact 
on your activity. Play around with the app, and see if your current strategy produces the equity curves you desire. For example, 
                I learned that even if your profits are twice as big as your losses (10% vs 5%), you will still end up losing money on most 
                equity curves if your winrate is only 30%."), 
              
              h2("Output:"), 
              textOutput("text1"), 
              plotOutput("pnl"), 
              br(),p("Back to ", a("TradingFever", href="http://tradingfever.com"))
              
              )
    )
))

#deployment shortcut
#require('devtools')
#require('shinyapps')
#shinyapps::setAccountInfo(name='tradingfever', token='2DCFA525202F7F728966BB01936EE9F9', secret='yourSecretHere')
#setwd('/Users/wei/workspace/randomreturns2')
#deployApp()