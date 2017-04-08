## REPORT FOLDER
if (!dir.exists("Reports")) {
  dir.create("Reports")
}

if (file.exists("Reports/Newsletter.txt")){ file.remove("Reports/Newsletter.txt")}

if (file.exists("Reports/PlanterUnionMessage.txt")){file.remove("Reports/PlanterUnionMessage.txt")}
if (file.exists("Reports/RoasterUnionMessage.txt")){file.remove("Reports/RoasterUnionMessage.txt")}
if (file.exists("Reports/PackerUnionMessage.txt")){file.remove("Reports/PackerUnionMessage.txt")}
if (file.exists("Reports/RetailerUnionMessage.txt")){file.remove("Reports/RetailerUnionMessage.txt")}

## GENERAL

Overview <- data.frame(cbind(Game$Period, Game$Weather.Conditions,
                             Game$Economic.Conditions,
                             Retailer$Demand, Game$Sales,
                             Game$Total.Revenue, Game$Gini,
                             Game$Salary.Mean, Game$Total.Stock, Game$Total.Product.Loss))
colnames(Overview) <- c("Period", "Weather", "Economy",
                        "Demand", "Sales", "Total.Revenue", "Coef.Gini", "Mean.Salary",
                        "Total.Stock", "Total.Product.Loss")
Overview <- Overview[1:j,] # Triming the dataset to the current period
write.csv(Overview, file = "Reports/Overview.csv")

##PLAYERS

### PLANTER
PlanterResults <- data.frame(cbind(Game$Period,
                                   Planter$Cash, Planter$LoanInterest,
                                   Planter$Fields, Planter$Machinery,
                                   Planter$Labor, Planter$Salary,
                                   Planter$Stock, Planter$Production,
                                   Planter$Sales, Planter$Product.Loss,
                                   Planter$Price, Planter$Revenue))
colnames(PlanterResults) <- c("Period", "Cash", "Loan.Interest", "Fields", "Machinery",
                              "Labor", "Salary", "Stock", "Production", "Sales", "Product.Loss",
                              "Price", "Revenue")
PlanterResults <- PlanterResults[1:(j+1),] # Triming the dataset to the current period
write.csv(PlanterResults, file = "Reports/PlanterReport.csv")

### ROASTER
RoasterResults <- data.frame(cbind(Game$Period,
                                   Roaster$Cash, Roaster$LoanInterest,
                                   Roaster$Pans, Roaster$Labor, Roaster$Salary,
                                   Roaster$Crude, Roaster$Stock, Roaster$Production,
                                   Roaster$Sales, Roaster$Product.Loss,
                                   Roaster$Price, Roaster$Revenue))
colnames(RoasterResults) <- c("Period", "Cash", "Loan.Interest", "Pans",
                              "Labor", "Salary", "Crude", "Stock", "Production", "Sales", "Product.Loss",
                              "Price", "Revenue")
RoasterResults <- RoasterResults[1:(j+1),] # Triming the dataset to the current period
write.csv(RoasterResults, file = "Reports/RoasterReport.csv")

### PACKER
PackerResults <- data.frame(cbind(Game$Period,
                                  Packer$Cash, Packer$LoanInterest,
                                  Packer$Lines, Packer$Labor, Packer$Salary,
                                  Packer$Crude, Packer$Stock, Packer$Production,
                                  Packer$Sales, Packer$Product.Loss,
                                  Packer$Price, Packer$Revenue))
colnames(PackerResults) <- c("Period", "Cash", "Loan.Interest", "Lines",
                             "Labor", "Salary", "Crude", "Stock", "Production", "Sales", "Product.Loss",
                             "Price", "Revenue")
PackerResults <- PackerResults[1:(j+1),] # Triming the dataset to the current period
write.csv(PackerResults, file = "Reports/PackerReport.csv")

### RETAILER
RetailerResults <- data.frame(cbind(Game$Period,
                                  Retailer$Cash, Retailer$LoanInterest,
                                  Retailer$POS, Retailer$Labor, Retailer$Salary,
                                  Retailer$Crude, Retailer$Stock,
                                  Retailer$Sales, Retailer$Product.Loss,
                                  Retailer$Price, Retailer$Revenue))
colnames(RetailerResults) <- c("Period", "Cash", "Loan.Interest", "POS",
                             "Labor", "Salary", "Crude", "Stock", "Sales", "Product.Loss",
                             "Price", "Revenue")
RetailerResults <- RetailerResults[1:(j+1),] # Triming the dataset to the current period
write.csv(RetailerResults, file = "Reports/RetailerReport.csv")

## STRIKE MESSAGES
StockMessage <- paste("Total stock in supply chain for the next period equals",
                      as.character(Game$Total.Stock[j+1]),
                      'units', sep = " ")
write (StockMessage, "Reports/Newsletter.txt", append = TRUE)

if (Planter$LaborStatement[j] == FALSE){
  PlanterMessage <- "BREAKING NEWS! Workers on coffee plantations refused to turn up to work due to underpayments. Coffee harvesting has been stopped."
  write (PlanterMessage, "Reports/Newsletter.txt", append = TRUE)
} else {
  PlanterMessage <- ""
}

if (Roaster$LaborStatement[j] == FALSE){
  RoasterMessage <- "BREAKING NEWS! Workers on coffee roasting manufacturing refused to turn up to work due to underpayments. Coffee production has been stopped."
  write (RoasterMessage, "Reports/Newsletter.txt", append = TRUE)
} else {
  RoasterMessage <- ""
}

if (Packer$LaborStatement[j] == FALSE){
  PackerMessage <- "BREAKING NEWS! Workers on coffee packing factories refused to turn up to work due to underpayments. Coffee packing has been stopped."
  write (PackerMessage, "Reports/Newsletter.txt", append = TRUE)
} else {
  PackerMessage <- ""
}

if (Retailer$LaborStatement[j] == FALSE){
  RetailerMessage <- "BREAKING NEWS! Workers on coffee distribution refused to turn up to work due to underpayments. Coffee sales has been stopped."
  write (RetailerMessage, "Reports/Newsletter.txt", append = TRUE)
} else {
  RetailerMessage <- ""
}

## LABOR UNION MESSAGE

if (Planter$Workload[j] > 1){
  PlanterUnionMessage <- "Your workers have been working for extra hours. You should pay overtime. Yours, Labor Union."
  write(PlanterUnionMessage, "Reports/PlanterUnionMessage.txt")
}

if (Planter$LaborStatement[j] & Planter$Strike[j] > 0.3) {
  PlanterStrikeAlarm <- "Labor Union is planning a stike, you'd better review you salary fund."
  write(PlanterStrikeAlarm, "Reports/PlanterUnionMessage.txt", append = TRUE)
}


if (Roaster$Workload[j] > 1){
  RoasterUnionMessage <- "Your workers have been working for extra hours. You should pay overtime. Yours, Labor Union."
  write(RoasterUnionMessage, "Reports/RoasterUnionMessage.txt")
}

if (Roaster$LaborStatement[j] & Roaster$Strike[j] > 0.3) {
  RoasterStrikeAlarm <- "Labor Union is planning a stike, you'd better review you salary fund."
  write(RoasterStrikeAlarm, "Reports/RoasterUnionMessage.txt", append = TRUE)
}

if (Packer$Workload[j] > 1){
  PackerUnionMessage <- "Your workers have been working for extra hours. You should pay overtime. Yours, Labor Union."
  write(PackerUnionMessage, "Reports/PackerUnionMessage.txt")
}

if (Packer$LaborStatement[j] & Packer$Strike[j] > 0.3) {
  PackerStrikeAlarm <- "Labor Union is planning a stike, you'd better review you salary fund."
  write(PlanterStrikeAlarm, "Reports/PackerUnionMessage.txt", append = TRUE)
}

if (Retailer$Workload[j] > 1){
  RetailerUnionMessage <- "Your workers have been working for extra hours. You should pay overtime. Yours, Labor Union."
  write(RetailerUnionMessage, "Reports/RetailerUnionMessage.txt")
}

if (Retailer$LaborStatement[j] & Retailer$Strike[j] > 0.3) {
  RetailerStrikeAlarm <- "Labor Union is planning a stike, you'd better review you salary fund."
  write(RetailerStrikeAlarm, "Reports/RetailerUnionMessage.txt", append = TRUE)
}