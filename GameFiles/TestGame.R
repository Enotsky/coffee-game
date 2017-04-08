# PLANTER
PlanterForm$Fields[1] <- 1
PlanterForm$Machinery[1] <- 2
PlanterForm$Labor[1] <- 10
PlanterForm$Salary[1] <- 10
PlanterForm$Price[1] <- 1

# ROASTER
RoasterForm$Supply[1] <- 50
RoasterForm$Pans[1] <- 2
RoasterForm$Labor[1] <- 10
RoasterForm$Salary[1] <- 10
RoasterForm$Price[1] <- 1.2

# PACKER
PackerForm$Supply[1] <- 50
PackerForm$Lines[1] <- 2
PackerForm$Labor[1] <- 10
PackerForm$Salary[1] <- 10
PackerForm$Price[1] <- 1.3

# RETAILER
RetailerForm$Supply[1] <- 50
RetailerForm$POS[1] <- 2
RetailerForm$Labor[1] <- 10
RetailerForm$Salary[1] <- 10
RetailerForm$Price[1] <- 1.4


#Writing test files
setwd("C:/Users/Volod/Documents/R/CoffeeGame")

write.csv(PlanterForm, file = "Input/PlanterForm.csv")
write.csv(RoasterForm, file = "Input/RoasterForm.csv")
write.csv(PackerForm, file = "Input/PackerForm.csv")
write.csv(RetailerForm, file = "Input/RetailerForm.csv")