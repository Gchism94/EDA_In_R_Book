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
               knitr,
               nycflights13,
               tidyverse)

# Objective 1.0: loading a data set and producing tables
data("flights")

# HTLM table of head(flights)
formattable(head(flights))


# What are the properties of the data
formattable(diagnose(flights))

# Properties of our numeric data columns
formattable(diagnose_numeric(flights))

# 2.0 Diagnosing outliers and missing values
formattable(diagnose_outlier(flights) %>%
  filter(outliers_ratio > 0)) 

# Plotting all columns with and without outliers
flights %>% 
  plot_outlier()

# Plotting only columns with outliers
flights %>%
  plot_outlier(diagnose_outlier(flights) %>%
                 filter(outliers_ratio > 0) %>%
                 select(variables) %>%
                 unlist()
  )

# Selecting desired columns to plot outliers
flights %>%
  select(dep_delay, air_time, arr_delay) %>%
  plot_outlier()

# Categorical variables
formattable(diagnose_category(flights))

# Create the NA table
NA.Table <- plot_na_pareto(flights, only_na = TRUE, plot = FALSE)

# HTML table of NAs
formattable(NA.Table)

# Plot NA intersect of the columns with missing values
plot_na_intersect(flights, only_na = TRUE)

# 3.0 Producing an HTML summary 
diagnose_web_report(flights)

