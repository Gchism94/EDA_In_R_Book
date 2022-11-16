# Title: EDA in R - Imputing like a data scientist
# Author: Greg Chism
# Date: 2022-10-31
# Description: 

# Installing required packages
install.packages("pacman")

pacman::p_load(dlookr,
               formattable,
               here, 
               tidyverse)

# Set the number of sig figs to two - e.g., 0.01
options(digits = 2)


# load a data frame 
dataset <- read.csv(
  here("Data7_EDA_In_R_Book", "data", "diabetes.csv")
)

# What does the data look like? 
head(dataset)

# Add categorical variable
dataset_Agegroup <- dataset %>% 
  mutate(Age_group = ifelse(Age >= 21 & Age <= 30, "Young",
                            ifelse(Age > 30 & Age <= 50, "Middle",
                                   "Elderly")),
         Age_group = fct_rev(Age_group))

formattable(head(dataset_Agegroup))

# Diagnose our data
formattable(diagnose(dataset_Agegroup))

# Describe numerical columns
describe(dataset_Agegroup) %>%
  formattable()

# Diagnose outliers
dataset_Agegroup %>%
  diagnose_outlier() %>%
  filter(outliers_ratio > 0) %>%
  formattable()

# Visualize outliers
dataset_Agegroup %>%
  select(find_outliers(dataset_Agegroup)) %>%
  plot_outlier()


# Impute Insulin 
# Mean imputation: impute about the mean (consider the mean)
dataset_mean <- dataset %>%
  select(Insulin) %>%
  imputate_outlier(Insulin, method = "mean")

# If you want to add the imputed column to a data frame, first create a data frame with the imputed data
data.mean <- data.frame(BMI_imp_mean = dataset_mean)

# Example of combining imputed data with original data
dataset_mean_imp <- cbind(dataset, data.mean)

# Visualize the mean imputation
dataset_mean %>%
  plot()

# Median imputation: impute about the median (consider the median)
dataset_median <- dataset %>%
  select(Insulin) %>%
  imputate_outlier(Insulin, method = "capping")

# Visualize the median imputation
dataset_median %>%
  plot()

# Mode imputation: impute about the mode (consider the mode)
dataset_mode <- dataset %>%
  select(Insulin) %>%
  imputate_outlier(Insulin, method = "capping")

# Visualize the mode imputation
dataset_mode %>%
  plot()



