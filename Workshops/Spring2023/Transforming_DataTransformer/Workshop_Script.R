# Title: EDA in R - Transforming data
# Author: Greg Chism
# Date: 2023-02-13
# Description: Third workshop in EDA in R series - data transformation

# Install packages
install.packages("pacman")

library(pacman)

p_load(dlookr,
       forecast,
       formattable,
       RCurl,
       tidyverse)

# Importing data
data <- getURL("https://raw.githubusercontent.com/ua-data7/classical-machine-learning-workshops/main/Workshops/Spring2023/2023-Mar-29/FE_2021_Classification_mod.csv")
data <- read.csv(text = data)

data %>%
  head() %>%
  formattable()
  
# Describe our data
data %>%
  describe() %>%
  select(described_variables, skewness) %>%
  formattable()

# Testing normality
data %>%
  normality() %>%
  formattable()

# Q-Q plot
data %>%
  plot_normality()

# Grouped Q-Q Plot
data %>%
  group_by(Treatment) %>%
  plot_normality()

# Transform our data: sqrt
sqrtTransform <- data %>%
  mutate(sqrtER = transform(data$ER, method = "sqrt"))
         
sqrtTransform %>% 
  head()

hist(sqrtTransform$sqrtER)

# Transform: log
logTransform <- data %>%
  mutate(logER = transform(data$ER, method = "log+1"))

logTransform %>%
  head()

hist(logTransform$logER)

logER_summary <- transform(data$ER, method = "log+1")

summary(logER_summary)

# Plot log transformation
logER_summary %>% 
  plot()

# Inverse Transformation
invER <- transform(data$ER + 1, method = "1/x")

summary(invER)

invER %>% 
  plot()

BoxCoxER <- transform(data$ER + 1, method = "Box-Cox")

summary(BoxCoxER)

BoxCoxER %>%
  plot()

# HTML web report EDA
transformation_web_report(data)

