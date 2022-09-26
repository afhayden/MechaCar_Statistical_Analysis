#Load Libraries
library(dplyr)
library(tidyverse)
library(car)

#Deliverable 1: Linear Regression to Predict MPG

#Import and read MechaCar_mpg.csv dataset
mpg_table <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)
head(mpg_table)

#Using Linear Regression to predict mpg of a car based on other characteristics
lm(mpg ~ vehicle_length,mpg_table) #create linear model for mpg based on vehicle_length
#Which results in the formula: mpg = 4.673vehicle_length -25.062

summary(lm(mpg~vehicle_length,mpg_table)) #summarize linear model
#Mutiple R-squared: 0.3715 which means that roughly 37% of the variability of
#the mpg (dependent variable) is explained using this linear regression.
#p-value: 2.632e-06 which is much smaller than the assumed significance level of 0.05%
#Therefore, there is sufficient evidence to reject our null hypothesis, which means
# that the slope of the linear model is not zero

model <- lm(mpg ~ vehicle_length,mpg_table) #create linear model
yvals <- model$coefficients['vehicle_length']*mpg_table$vehicle_length +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mpg_table,aes(x=vehicle_length,y=mpg)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model

#Perform Multiple Linear Regression for all six(6) variables
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mpg_table) #generate multiple linear regression model

#Perform summary statistics
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=mpg_table)) #generate summary statistics
model <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,mpg_table) #create linear model
avPlots(model)


#Deliverable 2: Visualizations for the Trip Analysis

#Import and read Suspension_Coil.csv dataset
suspension_table <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F)
head(suspension_table)
total_summary <- summarize(suspension_table, Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
lot_summary <- suspension_table %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep') #create summary table with multiple columns

#Deliverable 3: T-Tests on Suspension Coils
t.test(suspension_table$PSI,mu=1500) #compare sample versus population means

lot1_tbl <- subset(suspension_table, Manufacturing_Lot=="Lot1")
lot2_tbl <- subset(suspension_table, Manufacturing_Lot=="Lot2")
lot3_tbl <- subset(suspension_table, Manufacturing_Lot=="Lot3")

t.test(lot1_tbl$PSI,mu=1500)
t.test(lot2_tbl$PSI,mu=1500)
t.test(lot3_tbl$PSI,mu=1500)


#Deliverable 4: Comparing the MechaCar to the Competition

