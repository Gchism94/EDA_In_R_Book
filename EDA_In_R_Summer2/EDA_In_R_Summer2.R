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

