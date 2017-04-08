rm(list = ls())
CoffeeStart <- function(){
  setwd("C:/Users/Volod/Documents/R/CoffeeGame")
  source("CoffeeGameControl.R")
  file.remove(c("Reports/Overview.csv", "Reports/PlanterReport.csv", "Reports/RoasterReport.csv",
                "Reports/PackerReport.csv", "Reports/RetailerReport.csv",
                "Reports/Newsletter.txt" ))
  source("GameFiles/InitializeGame.R")
  source("GameFiles/PrepareGame.R")
  
  "Ready to start!"
}

CoffeeTest <- function(){
  source("GameFiles/TestGame.R")
}  

CoffeeShow <- function(){
  View(Game)
  View(Planter)
  View(Roaster)
  View(Packer)
  View(Retailer)
}

CoffeeGet <- function(){
  source("GameFiles/GetGame.R")
}

CoffeeTact <- function(q){
  if (!exists('j') || (j < n-1)){
    if (exists('j')){
      print(paste(c("You are generation tact"), as.character(j+1)), sep = "")
    } else {
      print("You are starting the game")
      }
    
    q <- readline(prompt = "Are all players solutions saved? Input 1 and press Enter to proceed. ")    
    if (q == as.numeric(1)){
          CoffeeGet()
          source("GameFiles/CoffeGameScript.R")
    } else {
      print("Please save players solutions and call for CoffeTact() once more.")
            }
  }
  
  else {
    print("You've reached the final game period. Congrats!")
    }
  }
  
CoffeeReport <- function(){
  source("GameFiles/ReportGame.R")
}