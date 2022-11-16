# Title: Exploratory data analysis in R - Imputing NAs
# Author: Greg Chism
# Date: 2022-11-14
# Description: EDA in R workshop on imputing missing values

# installing packages
install.packages("pacman")

library(pacman)

pacman::p_load(dlookr,
               formattable,
               here, # reproducibility, paths
               palmerpenguins,
               tidyverse) 

# loading in a dataset 
data(penguins)

formattable(head(penguins)) 

# Diagnosing our data
penguins %>%
  diagnose() %>%
  formattable()

# Analyze missing values
penguins %>%
  plot_na_pareto(only_na = TRUE, plot = FALSE) %>%
  formattable()

# Visualize missing values
penguins %>%
  plot_na_intersect(only_na = TRUE)

# Imputing NAs (mean)
mean_na_imp_peng <- penguins %>%
  imputate_na(bill_depth_mm, method = "mean")

# Visualizing imputed NAs
mean_na_imp_peng %>%
  plot()

# Combining imputed data to original
imp_billdepth <- data.frame(imp_billdepth_mm = tibble(mean_na_imp_peng))

mean_impdata_peng <- cbind(penguins, imp_billdepth)
mean_impdata_peng1 <- mean_impdata_peng %>%
  rename(imp_billdepth_mm = mean_na_imp_peng)

# Imputing NAs (mean)
mode_na_imp_peng <- penguins %>%
  imputate_na(sex, method = "mode")

mode_na_imp_peng %>%
  plot()

# Imputing NAs (rpart)
rpart_na_imp_peng <- penguins %>%
  imputate_na(sex, method = "rpart")

rpart_na_imp_peng %>%
  plot()

# Imputing NAs (MICE)
mice_na_imp_peng <- penguins %>%
  imputate_na(sex, method = "mice")

mice_na_imp_peng %>%
  plot()




