# Title: EDA in R - Diagnosing like a data doctor
# Author: Greg Chism
# Date: 2023-01-23
# Description: R Script associated with the EDA in R #1 workshop

# Installing required packages
install.packages("pacman")

library(pacman)

p_load(dlookr, # EDA package
       formattable, # HTML tables from R outputs
       RCurl, # Read raw data into R
       tidyverse) # Metapackage for data science 

# Read in csv from the web
data <- getURL("https://raw.githubusercontent.com/Gchism94/Data7_EDA_In_R_Workshops/main/Data7_EDA_In_R_Book/data/Data_Fig2_Repo.csv")
data <- read.csv(text = data)

# First 6 rows of data
formattable(head(data))
head(data) %>%
  formattable()


# Diagnose our data
data %>%
  diagnose() %>%
  formattable()

# Summary Statistics
data %>%
  diagnose_numeric() %>%
  formattable()

# Diagnose Outliers
diagnose_outlier(data) %>%
  filter(outliers_ratio > 0) %>%
  formattable()

# Plot Outliers
data %>%
  plot_outlier()


# Diagnose NAs
# list(Good = 0.05, OK = 0.33, NotBad = 0.5, Bad = 0.75, Remove = 1) (Diagnose issue)
data %>%
  plot_na_pareto(only_na = TRUE, plot = FALSE) %>%
  formattable()

# Plot NAs
data %>%
  plot_na_intersect(only_na = TRUE)

# Diagnose Categorical Variables
data %>%
  diagnose_category() %>%
  formattable()

# HTML Summary of a Data Set
diagnose_web_report(data)
?diagnose_web_report
# Check Error: pandoc document conversion failed with error 1