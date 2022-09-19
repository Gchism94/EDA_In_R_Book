## Name: Greg Chism
## Date: 2022-09-19
## Topic: EDA in R workshop 1
## Description:

# Set significant digits to 2
options(digits = 2)

# Install pacman
install.packages("pacman")

# Downloads and load required packages
pacman::p_load(dlookr, # Exploratory data analysis
               formattable, # HTML tables from R outputs
               here, # Standardizes paths to data
               kableExtra, # Alternative to formattable
               knitr, # Needed to write HTML reports
               missRanger, # To generate NAs
               tidyverse) # Powerful data wrangling package suite

# load in data 
dataset <- read.csv(here("Data7_EDA_In_R_Book", 
                         "data",
                         "daily_summary.csv"))

# Look at first six rows
dataset %>%
  head() %>%
  formattable()

# Data diagnostics 
dataset %>%
  diagnose() %>%
  formattable()

# Numerical summary statistics
dataset %>%
  diagnose_numeric() %>%
  formattable()

# Outlier plot
dataset %>%
  plot_outlier()


# Outlier statistics
diagnose_outlier(dataset) %>%
  formattable()


# Missing values
dataset %>%
  generateNA(p = 0.3) %>%
  plot_na_pareto(only_na = TRUE, plot = FALSE) 

# Missing values intersect plot
dataset %>%
  generateNA(p = 0.3) %>%
  select(test_type, test_result, test_count) %>%
  plot_na_intersect(only_na = TRUE)

# Diagnose categories
dataset %>%
  diagnose_category() %>%
  formattable()

# Diagnostic web report
diagnose_web_report(dataset)

# Describe numerical columns
dataset %>%
  describe() %>%
  formattable()

# Grouped summary statistics
dataset %>%
  group_by(test_type) %>%
  describe() %>%
  formattable()

# Test normality: Shapiro-Wilk
dataset %>%
  normality() %>%
  formattable()

# Test normality: Q-Q plot
dataset %>%
  select(test_count) %>%
  plot_normality()

# Grouped test normality: Shapiro-Wilk
dataset %>%
  group_by(test_type) %>%
  normality() %>%
  formattable()

# Grouped test normality: Q-Q plot
dataset %>%
  group_by(test_type) %>%
  plot_normality()

# Summary statistic report
eda_web_report(dataset)

# Outlier removal IQR
# Values taken from the describe() function
IQR_data = 16 # IQR

Qualifier = IQR_data * 1.5 # Qualifier

Upper_limit = 16 + Qualifier # Upper limit

Lower_limit = 0 - Qualifier # Lower limit

# Remove outliers
DataNoOutlier <- 
  dataset %>%
  filter(test_count >= Lower_limit & test_count <= Upper_limit)

# Normality plots without outliers
DataNoOutlier %>%
  plot_normality()


