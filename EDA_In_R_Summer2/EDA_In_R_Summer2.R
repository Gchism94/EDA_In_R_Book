####################################################################
### Project: Exploratory data analysis in R - Exploring like a data adventurer
### Author: 
### Email: 
### Date: 2022/05/09
####################################################################
## Purpose of workshop
# Exploring the normality of numerical columns in a novel data set and producing publication quality tables and reports

## Objectives:
# 1. Use summary statistics to better understand individual columns in a data set.
# 2. Assess data normality in numerical columns.
# 3. Produce a publishable HTML with summary statistics and normality tests for columns within a data set.

#### REQUIRED SETUP
# Sets the repository to download packages from
options(repos = list(CRAN = "http://cran.rstudio.com/"))

# Sets the number of significant figures to two - e.g., 0.01
options(digits = 2)

# Required package for quick package downloading and loading 
install.packages("pacman")

# Downloads and load required packages
pacman::p_load(dlookr, # Exploratory data analysis
               formattable, # HTML tables from R outputs
               kableExtra, # Alternative to formattable
               knitr, # Needed to write HTML reports
               nycflights13, # Holds the flights data set
               tidyverse) # Powerful data wrangling package suite


# load in the flights data
data("flights")

# HTML output of first six rows
formattable(head(flights))

# Alternative HTML with kableExtra
flights %>% 
  head() %>%
  kableExtra::kbl() %>%
  kableExtra::kable_styling()

# Properties of the flights data set
formattable(diagnose(flights))

# Summary statistics of flights data set
formattable(describe(flights))

# Refined summary statistics table
RefinedTable <- flights %>%
  describe() %>%
  select(variable, n, na, mean, sd, IQR)

formattable(RefinedTable)


# Describe categorical columns
formattable(diagnose_category(flights))

# Group level descriptive statistics
GroupTable <- flights %>%
  group_by(carrier) %>% 
  select(carrier, dep_delay) %>%
  describe()

formattable(GroupTable)


# Testing normality

# Shapiro-Wilk test
# NOTE: sample size must be > 20

# departure delay, arrival delay, air time 
FlightsNorm <- flights %>%
  select(dep_delay, arr_delay, air_time)

# Shapiro-Wilk test
formattable(normality(FlightsNorm))

# Q-Q plots 
FlightsNorm %>%
  plot_normality() 

# Normality within groups
NormCarrierTable <- flights %>%
  group_by(carrier) %>%
  select(carrier, dep_delay) %>%
  normality()

formattable(NormCarrierTable)

# Grouped Q-Q plot
flights %>%
  group_by(carrier) %>%
  select(carrier, dep_delay) %>%
  plot_normality()

# HTML in browser with interactive EDA report 
eda_web_report(FlightsNorm)

# NOTE: possible error with 'forecast' package when running the eda_web_report() function
# Use the following fix

# WINDOWS
# utils::setInternet2(TRUE)
# options(download.file.method = "internal")

# MAC OS X
# options(download.file.method = "curl")

# LINUX 
# options(download.file.method = "wget")

# install.packages("forecast")
# library(forecast)

# Then re-run the eda_web_report() function
