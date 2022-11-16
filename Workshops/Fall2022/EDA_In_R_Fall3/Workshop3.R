# Workshop - EDA in R #3 Data Transformation
# Author: Greg Chism
# Date: 2022-10-17
# Description: 

# Install packages
install.packages("pacman")

pacman::p_load(dlookr,
               formattable,
               forecast,
               here,
               missRanger,
               tidyverse,
               magrittr,
               remotes)

remotes::install_github()
library(forecast)


# Load data
dataset <- read.csv(
  here("Data7_EDA_In_R_Book", "data", "diabetes.csv")) %>% 
  dplyr::mutate(Age_group = ifelse(Age >= 21 & Age <= 30, "Young",
                            ifelse(Age > 30 & Age <= 50, "Middle",
                                   "Elderly")))

# What does the data look like
formattable(
  head(
    dataset
    )
)

# Test skewness
dataset %>%
  select(Glucose, Insulin) %>%
  describe() %>%
  select(described_variables, skewness) %>%
  formattable()

# Test normality
dataset %>%
  plot_normality(Glucose, Insulin)


# Test normality within groups
dataset %>%
  group_by(Age_group) %>%
  select(Glucose, Insulin) %>%
  plot_normality()

# Transform data 
InsMod <- dataset %>%
  filter(Insulin > 0)

# Square-root transformation 
sqrtIns_data <- InsMod %>%
  mutate(sqrtIns = transform(Insulin, method = "sqrt"))

summary(sqrtIns_data$sqrtIns)

# Plot sqrt transformation
plot(sqrtIns_data$sqrtIns)


# Log + 1 transformation
log1Ins_data <- InsMod %>%
  mutate(Log1Ins = transform(Insulin, method = "log+1"))

summary(log1Ins_data$Log1Ins)

# Plot log+1 transformation
plot(log1Ins_data$Log1Ins)

# Test log+1 transformation data 
log1Ins_data %>%
  plot_normality(Log1Ins)

# Box-Cox Transformation
InvIns_data <- InsMod %>%
  mutate(BCIns = transform(Insulin, method = "Box-Cox"))
  
summary(InvIns_data$InvIns)

# Plot Box-Cox Transformation
plot(InvIns_data$InvIns)




