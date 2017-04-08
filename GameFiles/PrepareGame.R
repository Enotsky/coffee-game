setwd("C:/Users/Volod/Documents/R/CoffeeGame")


PlanterForm <- data.frame(Fields = 0, Machinery = 0, Labor = 0, Salary = 0, Price = 0)
write.csv(PlanterForm, file = "Input/PlanterForm.csv")
  
RoasterForm <- data.frame(Supply = 0, Pans = 0, Labor = 0, Salary = 0, Price = 0)
write.csv(RoasterForm, file = "Input/RoasterForm.csv")
  
PackerForm <- data.frame(Supply = 0, Lines= 0, Labor = 0, Salary = 0, Price = 0)
write.csv(PackerForm, file = "Input/PackerForm.csv")
  
RetailerForm <- data.frame(Supply = 0, POS = 0, Labor = 0, Salary = 0, Price = 0)
write.csv(RetailerForm, file = "Input/RetailerForm.csv")