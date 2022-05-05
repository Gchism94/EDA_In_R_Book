####################################################################
### Project: Exploratory data analysis in R - Diagnosing like a data doctor
### Author: 
### Email: 
### Date: 2022/05/06
####################################################################
## Purpose of workshop
# Exploring a novel data set and produce publication quality tables and reports 

## Objectives
# 1. Load and explore a data set with publication quality tables
# 2. Diagnose outliers and missing values in a data set
# 3. Prepare an HTML summary report showcasing properties of a data set

#### REQUIRED SETUP
# Sets the repository to download packages from
options(repos = list(CRAN = "http://cran.rstudio.com/"))

# Sets the number of significant figures to two - e.g., 0.01
options(digits = 2)

# Required package for quick package downloading and loading 
install.packages("pacman")

# Downloads and load required packages
pacman::p_load(dlookr,
               formattable,
               nycflights13,
               tidyverse)