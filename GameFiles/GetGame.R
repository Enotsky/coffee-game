if (exists('j')){
  j <- j + 1L
} else {
  j <- 1L
}

# PLANTER
PlanterForm <- read.csv('Input/PlanterForm.csv', row.names = 1)

Planter$Fields[j+1] <- PlanterForm$Fields[1] 
Planter$Machinery[j] <- PlanterForm$Machinery[1]
Planter$Labor[j] <- PlanterForm$Labor[1]
Planter$Salary[j] <- PlanterForm$Salary[1]
Planter$Price[j] <- PlanterForm$Price[1]


# ROASTER
RoasterForm <- read.csv('Input/RoasterForm.csv', row.names = 1)

Roaster$Supply[j] <- RoasterForm$Supply[1]
Roaster$Pans[j] <- RoasterForm$Pans[1]
Roaster$Labor[j] <- RoasterForm$Labor[1]
Roaster$Salary[j] <- RoasterForm$Salary[1]
Roaster$Price[j] <- RoasterForm$Price[1]

# PACKER
PackerForm <- read.csv('Input/PackerForm.csv', row.names = 1)

Packer$Supply[j] <- PackerForm$Supply[1]
Packer$Lines[j] <- PackerForm$Lines[1]
Packer$Labor[j] <- PackerForm$Labor[1]
Packer$Salary[j] <- PackerForm$Salary[1]
Packer$Price[j] <- PackerForm$Price[1]

# RETAILER
RetailerForm <- read.csv('Input/RetailerForm.csv', row.names = 1)

Retailer$Supply[j] <- RetailerForm$Supply[1]
Retailer$POS[j] <- RetailerForm$POS[1]
Retailer$Labor[j] <- RetailerForm$Labor[1]
Retailer$Salary[j] <- RetailerForm$Salary[1]
Retailer$Price[j] <- RetailerForm$Price[1]