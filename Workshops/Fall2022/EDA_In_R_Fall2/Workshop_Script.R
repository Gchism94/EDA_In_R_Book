# Title: Workshop materials for EDA in R 2
# Author: Greg Chism
# Date: 2022-10-03
# Purpose: Materials supplemental to the workshop EDA in R Fall #2

# Install required packages
install.packages("pacman")

pacman::p_load(dlookr,
               formattable,
               here,
               tidyverse)

# Load the dataset
dataset <- read.csv(here(
  "Data7_EDA_In_R_Book", "data", "Data_Fig2_Repo.csv"
))

# What does the data look like?
dataset %>% 
  tail() %>%
  formattable()

# Diagnose data
dataset %>%
  diagnose() %>%
  formattable()

# Describe numerical data
dataset %>%
  describe() %>%
  formattable()

# Describe categorical data
dataset %>%
  diagnose_category() %>%
  formattable()

# Test data normality
# Shapiro-Wilk test
dataset %>%
  normality() %>%
  formattable()

# Q-Q plot
dataset %>%
  plot_normality()

# HTML Normality report 
eda_web_report(dataset)


