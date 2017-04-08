library(ineq)
n <- 0L
while (n < 1) {
  q <- readline("How many periods to wish to play? ")  
  n <- as.integer(q)
  if (n < 1) {print("Sorry, the value is incorrect. Please enter an integer.")}
}

n <- as.integer(q) + 1L
  
# CONDITION CONSTANTS
Weather <- as.factor(c(hot = 0.8, cold = 0.85, good = 0.9, excelent = 1))
Economics <- factor(c(increase = 1.05, stability = 1, decrease = 0.95))

# OPERATIONAL CONSTANTS
StockCost <- 0.1
InterestRate <- 0.1
RoastIndex <- 0.9

FieldFertility <- 50
MachineryCapacity <- 50
PanCapacity <- 40
LineCapacity <- 30
ShopCapacity <- 20

OptimalCapacity <- 0.8

LaborCapacity.Planter <- 7
LaborCapacity.Roaster <- 5
LaborCapacity.Packer <- 4
LaborCapacity.Retailer <-3

MaxOverload <- 2

## COSTS

NewField <- 30 
MachineryCost <- 4
PanCost <- 3
LineCost <- 2 
POSCost <- 1

# REFERENCE CONSUMPTION INDEX
BalancedConsumptionIndex <- function(price, balance = 2, elasticity = 1){
  ReferencePrice <- balance*2 ## Lower difficulty
  if (price < ReferencePrice){
    ReferencePrice/price
  } else {
    ReferencePrice/price*elasticity 
  }

}
  
# BASIC GAME PARAMETERS
Game <- data.frame(row.names = 1:n)
Game$Period <-c(1:n)
Game$Trend <- c(0)
Game$Economic.Conditions<- c("")
Game$LossIndex <- c(0)
Game$ElasticityIndex <- c(0)
Game$Demand <- c(0L)
Game$Weather <- c(0)
Game$Weather.Conditions <- c("")
Game$Salary.Mean <- c(0)
Game$LaborIncome.Total <- c(0)
Game$Sales <- c(0L)
Game$Balanced.Price <- c(0)
Game$Total.Revenue <- c(0)
Game$Gini <- c(0)
Game$Total.Stock <-c(0L)
Game$Total.Product.Loss <- c(0L)

# PLAYERS DATAFRAMES
Planter <- data.frame(row.names = 1:n)
Roaster <- data.frame(row.names = 1:n)
Packer <- data.frame(row.names = 1:n)
Retailer <- data.frame(row.names = 1:n)

# ZERO PERIOD VALUES
## PLANTER
Planter$Cash <- c(0)
Planter$LoanInterest <- c(0)
Planter$Fields <- c(0)
Planter$Machinery <- c(0)
Planter$Labor <- c(0)
Planter$Salary <- c(0)
Planter$Workload <- c(0)
Planter$Strike <- c(0)
Planter$LaborStatement <- c(TRUE)
Planter$UnionClaim <- c(0)
  
Planter$Price<- c(0)
Planter$Production <- c(0L)
Planter$ForSale <- c(0L)
Planter$Product.Loss <- c(0L)
Planter$Demand <- c(0L)
Planter$Sales <- c(0L)
Planter$Stock <- c(0L)
Planter$Revenue <- c(0)


## ROASTER
Roaster$Cash <- c(0)
Roaster$LoanInterest <- c(0)
Roaster$Pans <- c(0L)
Roaster$Labor <- c(0L)
Roaster$Salary <- c(0)
Roaster$Workload <- c(0)
Roaster$Strike <- c(0)
Roaster$LaborStatement <- c(TRUE)
Roaster$UnionClaim <- c(0)

Roaster$Price <- c(0)
Roaster$Crude <- c(0)
Roaster$Production <- c(0L)
Roaster$ForSale <- c(0L)
Roaster$Product.Loss <- c(0L)
Roaster$Supply <- c(0L)
Roaster$Demand <- c(0L)
Roaster$Sales <- c(0L)
Roaster$Stock <- c(0L)
Roaster$Revenue <- c(0)
  
  
## PACKER
Packer$Cash <- c(0)
Packer$LoanInterest <- c(0)
Packer$Lines <- c(0L)
Packer$Labor <- c(0L)
Packer$Salary <- c(0)
Packer$Workload <- c(0)
Packer$Strike <- c(0)
Packer$LaborStatement <- c(TRUE)
Packer$UnionClaim <- c(0)

Packer$Price <- c(0)
Packer$Crude <- c(0)
Packer$Production <- c(0L)
Packer$ForSale <- c(0L)
Packer$Product.Loss <- c(0L)
Packer$Supply <- c(0L)
Packer$Demand <- c(0L)
Packer$Sales <- c(0L)
Packer$Stock <- c(0L)
Packer$Revenue <- c(0)

## RETAILER
Retailer$Cash <- c(0)
Retailer$LoanInterest <- c(0)
Retailer$POS <- c(0L)
Retailer$Labor <- c(0L)
Retailer$Salary <- c(0)
Retailer$Workload <- c(0)
Retailer$Strike <- c(0)
Retailer$LaborStatement <- c(TRUE)
Retailer$UnionClaim <- c(0)

Retailer$Price <- c(0)
Retailer$Crude <- c(0)
Retailer$ForSale <- c(0L)
Retailer$Product.Loss <- c(0L)
Retailer$Supply <- c(0L)
Retailer$Demand <- c(0L)
Retailer$Sales <- c(0L)
Retailer$Stock <- c(0L)
Retailer$Revenue <- c(0)

  
# FIRST PERIOD PARAMETERS
## GENERAL GAME PARAMETERS
Game$Demand[1] <- 50 # First period demand
Game$Salary.Reference[1] <- 1 # Reference mean workers salary for peiod one
Game$Total.Stock[1] <- Planter$Stock[1] + Roaster$Stock[1] + Packer$Stock[1] + Retailer$Stock[1] # Total Supply Chain Stock

## PLANTER
Planter$Fields[1] <- 1
Planter$Stock[1] <- 10

## ROASTER
Roaster$Pans[1] <- 2
Roaster$Stock[1] <- 10

## PACKER
Packer$Lines[1] <- 2
Packer$Stock[1] <- 10

## RATAILER
Retailer$POS[1] <- 2
Retailer$Stock[1] <- 10