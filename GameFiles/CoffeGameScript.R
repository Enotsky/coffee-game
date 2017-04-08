# MACROPARAMETERs
Game$Weather[j] <- as.numeric(sample(levels(Weather), 1))
Game$Weather.Conditions[j] <- labels(Weather[levels(Weather) == Game$Weather[j]])

Game$Salary.Mean[j] <- sum(c(Planter$Salary[j],
                             Roaster$Salary[j],
                             Packer$Salary[j],
                             Retailer$Salary[j]),
                           na.rm = TRUE)/
  sum(c(Planter$Labor[j],
        Roaster$Labor[j],
        Packer$Labor[j],
        Retailer$Labor[j]),
      na.rm = TRUE)

Game$Balanced.Price[j] <- Game$Salary.Mean[j]
  
Game$Trend[j] <- as.numeric(sample(levels(Economics), 1))
Game$Economic.Conditions[j] <- labels(Economics[levels(Economics) == Game$Trend[j]]) 

# SUPPLY CHAIN PARAMETERS
Game$LossIndex[j] <- max(1, (1 - Roaster$Salary[j]/Roaster$Labor[j] + 1.2*Game$Salary.Mean[j]))
Game$ElasticityIndex[j] <- 1 + Packer$Salary[j]/Packer$Labor[j] - 1.2*Game$Salary.Mean[j]
  
# PRODUCTION AND LABOR
Planter$Production[j] <- round(min(Planter$Fields[j] * FieldFertility * Game$Weather[j],
                                   Planter$Machinery[j] * MachineryCapacity,
                                   Planter$Labor[j]*LaborCapacity.Planter*MaxOverload), 0)

if (Planter$Labor[j] != 0) {
  Planter$Workload[j] <- Planter$Production[j]/Planter$Labor[j]/LaborCapacity.Planter
  Planter$Strike[j] <- max(0, (1-(Planter$Salary[j]/Planter$Labor[j] - Planter$UnionClaim[j])/Game$Salary.Mean[j]))
} else {
  Planter$Workload[j] <- 0
  Planter$Strike[j] <- 0
}
Planter$LaborStatement[j] <- sample(c(TRUE, FALSE), 1, prob = c((1 - Planter$Strike[j]), Planter$Strike[j]))

Planter$Production[j] <- Planter$Production[j] * as.numeric(Planter$LaborStatement[j])
Planter$UnionClaim[j+1] <- max(0, Planter$Workload[j]-1)*Game$Salary.Mean[j]
Planter$ForSale[j] <- Planter$Stock[j] + Planter$Production[j]
Planter$Product.Loss[j] <- Planter$Stock[j] + Planter$Production[j] - Planter$ForSale[j]

Roaster$Crude[j] <- min(Roaster$Supply[j], Planter$ForSale[j])

Roaster$Production[j] <- round(min(Roaster$Crude[j],
                                   Roaster$Pans[j]*PanCapacity,
                                   Roaster$Labor[j]*LaborCapacity.Roaster*MaxOverload)*RoastIndex, 0)

if (Roaster$Labor[j] != 0){
  Roaster$Workload[j] <- Roaster$Production[j]/Roaster$Labor[j]/LaborCapacity.Roaster
  Roaster$Strike[j] <- max(0, (1-(Roaster$Salary[j]/Roaster$Labor[j] - Roaster$UnionClaim[j])/Game$Salary.Mean[j]))
} else {
  Roaster$Workload[j] <- 0
  Roaster$Strike[j] <- 0  
}
Roaster$LaborStatement[j] <- sample(c(TRUE, FALSE), 1, prob = c((1 - Roaster$Strike[j]), Roaster$Strike[j]))
Roaster$Production[j] <- Roaster$Production[j] * as.numeric(Roaster$LaborStatement[j])
Roaster$UnionClaim[j+1] <- max(0, Roaster$Workload[j]-1)*Game$Salary.Mean[j]
Roaster$ForSale[j] <- round(((Roaster$Stock[j] + Roaster$Production[j])/Game$LossIndex[j]), 0)
Roaster$Product.Loss[j] <- Roaster$Stock[j] + Roaster$Production[j] - Roaster$ForSale[j]

Packer$Crude[j] <- min(Packer$Supply[j], Roaster$ForSale[j])
Packer$Production[j] <- round(min(Packer$Crude[j],
                                  Packer$Lines[j]*LineCapacity,
                                  Packer$Labor[j]*LaborCapacity.Packer*MaxOverload), 0)

if (Packer$Labor[j] != 0){
  Packer$Workload[j] <- Packer$Production[j]/Packer$Labor[j]/LaborCapacity.Packer
  Packer$Strike[j] <- max(0, (1-(Packer$Salary[j]/Packer$Labor[j] - Packer$UnionClaim[j])/Game$Salary.Mean[j]))
} else {
  Packer$Workload[j] <- 0
  Packer$Strike[j] <- 0
}
Packer$LaborStatement[j] <- sample(c(TRUE, FALSE), 1, prob = c((1 - Packer$Strike[j]), Packer$Strike[j]))
Packer$Production[j] <- Packer$Production[j] * as.numeric(Packer$LaborStatement[j])
Packer$UnionClaim[j+1] <- max(0, Packer$Workload[j]-1)*Game$Salary.Mean[j]
Packer$ForSale[j] <- round(((Packer$Stock[j] + Packer$Production[j])/Game$LossIndex[j]), 0)
Packer$Product.Loss[j] <- Packer$Stock[j] + Packer$Production[j] - Packer$ForSale[j]

Retailer$Crude[j] <- min(Retailer$Supply[j], Packer$ForSale[j])
Retailer$ForSale[j] <- round((Retailer$Stock[j] + Retailer$Crude[j])/Game$LossIndex[j], 0)
Retailer$Product.Loss[j] <- Retailer$Stock[j] + Retailer$Crude[j] - Retailer$ForSale[j]

if (Retailer$Labor[j] !=0){
  Retailer$Workload[j] <- Retailer$Sales[j]/Retailer$Labor[j]/LaborCapacity.Retailer
  Retailer$Strike[j] <- max(0, (1-(Retailer$Salary[j]/Retailer$Labor[j] - Retailer$UnionClaim[j])/Game$Salary.Mean[j]))
} else {
  Retailer$Workload[j] <- 0
  Retailer$Strike[j] <- 0
}
Retailer$LaborStatement[j] <- sample(c(TRUE, FALSE), 1, prob = c((1 - Retailer$Strike[j]), Retailer$Strike[j]))
Retailer$ForSale[j] <- Retailer$ForSale[j] * as.numeric(Retailer$LaborStatement[j])
Retailer$UnionClaim[j+1] <- max(0, Retailer$Workload[j]-1)*Game$Salary.Mean[j]

Game$LaborIncome.Total[j] <- Planter$Salary[j]+Roaster$Salary[j]+Packer$Salary[j]+Retailer$Salary[j]

# SUPPLY CHAIN
Retailer$Demand[j] <- round((Game$Demand[j] *
                               BalancedConsumptionIndex(Retailer$Price[j],
                                                        Game$Balanced.Price[j],
                                                        Game$ElasticityIndex[j])), 0)


if (j > 1) {
  Retailer$Demand[j] <- round((Game$Demand[j] * BalancedConsumptionIndex(Retailer$Price[j],
                                                                         Game$Balanced.Price[j],
                                                                         Game$ElasticityIndex[j])), 0)
}



Retailer$Sales[j] <- round(min(Retailer$ForSale[j],
                               Retailer$Demand[j],
                               Retailer$POS[j]*ShopCapacity,
                               Retailer$Labor[j]*LaborCapacity.Retailer*MaxOverload),0)
Retailer$Revenue[j] <- Retailer$Sales[j]*Retailer$Price[j]
Retailer$Stock[j+1] <- Retailer$ForSale[j] - Retailer$Sales[j]
  
Packer$Demand[j] <- Retailer$Suppl[j]
Packer$Sales[j] <- min(Packer$ForSale[j], Packer$Demand[j])
Packer$Revenue[j] <- Packer$Sales[j]*Packer$Price[j]
Packer$Stock[j+1] <- Packer$ForSale[j] - Packer$Sales[j]
  
Roaster$Demand[j] <- Packer$Supply[j]
Roaster$Sales[j] <- min(Roaster$ForSale[j], Roaster$Demand[j])
Roaster$Revenue[j] <- Roaster$Sales[j]*Roaster$Price[j]
Roaster$Stock[j+1] <- Roaster$ForSale[j] - Roaster$Sales[j]  
  
Planter$Demand[j] <- Roaster$Supply[j]
Planter$Sales[j] <- min(Planter$ForSale[j], Planter$Demand[j])
Planter$Revenue[j] <- Planter$Sales[j]*Planter$Price[j]
Planter$Stock[j+1] <- Planter$ForSale[j] - Planter$Sales[j]

# CASH FLOW
Planter$LoanInterest[j] <- min(0, Planter$Cash[j]*InterestRate)
Planter$Cash[j+1] <- (Planter$Cash[j]
                      - Planter$Salary[j]
                      - Planter$Machinery[j]*MachineryCost
                      - (Planter$Fields[j+1] - Planter$Fields[j])*NewField
                      - Planter$Stock[j]*StockCost
                      + Planter$Revenue[j] + Planter$LoanInteres[j])

Roaster$LoanInterest[j] <- min(0, Roaster$Cash[j]*InterestRate)  
Roaster$Cash[j+1] <- (Roaster$Cash[j]
                      - Roaster$Crude[j]*Planter$Price[j]
                      - Roaster$Salary[j]
                      - Roaster$Pans[j]*PanCost
                      - Roaster$Stock[j]*StockCost
                      + Roaster$Revenue[j] + Roaster$LoanInterest[j])

Packer$LoanInterest[j] <- min(0, Packer$Cash[j]*InterestRate)  
Packer$Cash[j+1] <- (Packer$Cash[j]
                     - Packer$Crude[j]*Roaster$Price[j]
                     - Packer$Salary[j]
                     - Packer$Lines[j]*LineCost
                     - Packer$Stock[j]*StockCost
                     + Packer$Revenue[j] + Packer$LoanInterest[j])

Retailer$LoanInterest[j] <- min(0, Retailer$Cash[j]*InterestRate)
Retailer$Cash[j+1] <- (Retailer$Cash[j]
                       - Retailer$Crude[j]*Packer$Price[j]
                       - Retailer$Salary[j]
                       - Retailer$POS[j]*POSCost
                       - Retailer$Stock[j]*StockCost
                       + Retailer$Revenue[j] + Retailer$LoanInterest[j])
  

# RESULTS AND NEXT PERIOD PARAMATERS
Game$Sales[j] <- Retailer$Sales[j]
Game$Total.Product.Loss[j] <- Planter$Product.Loss[j] + Roaster$Product.Loss[j] + Packer$Product.Loss[j] + Retailer$Product.Loss[j]
Game$Total.Revenue[j] <- sum(c(Planter$Revenue[j], Roaster$Revenue[j], Packer$Revenue[j], Retailer$Revenue[j]))
Game$Gini[j] <- Gini(c(Planter$Revenue[j], Roaster$Revenue[j], Packer$Revenue[j], Retailer$Revenue[j]))

if (Game$Demand[j] > Game$Sales[j]) {
  Game$Demand[j+1] <- round(mean(c(Game$Demand[j], Game$Sales[j])), 0)
}else{
  Game$Demand[j+1] <- round(Game$Demand[j]*1.1*Game$Trend[j], 0)
}

Game$Total.Stock[j+1] <- Planter$Stock[j+1] + Roaster$Stock[j+1] + Packer$Stock[j+1] + Retailer$Stock[j+1]



