# Title: EDA in R - Imputating II
# Author: Greg Chism
# Date: 2023-03-13
# Description: Second of two workshops on imputation in R

# installing packages
install.packages("pacman")

pacman::p_load(cluster,
               dlookr,
               formattable,
               ggfortify,
               ggpubr,
               missRanger,
               plotly,
               rattle,
               RCurl,
               rpart,
               tidyverse,
               visdat)

# Global ggplot theme
theme_set(theme_pubclean(base_size = 14))
theme_update(axis.ticks = element_blank())

# Downloading data from a URL
data <- getURL("https://raw.githubusercontent.com/Gchism94/Data7_EDA_In_R_Workshops/main/Data7_EDA_In_R_Book/data/diabetes.csv")

data <- read.csv(text = data)

data %>% 
  head() %>%
  formattable()

# Diagnosing our data
data %>%
  diagnose() %>%
  formattable()

# Simulate NAs randomly
na.data <- data %>%
  drop_na() %>%
  generateNA(p = 0.3)

na.data %>%
  head() %>%
  formattable()

# Visualize missing values
na.data %>%
  plot_na_pareto(only_na = TRUE, plot = FALSE,
                 grade = list(Good = 0.1, OK = 0.2, NotBad = 0.3, Bad = 0.5, Remove = 1)) %>%
  formattable()

na.data %>%
  plot_na_intersect(only_na = TRUE)

# Interactive NA plot
na.data %>%
  vis_miss() %>%
  ggplotly()

# KNN plot
data.noNA <- data %>%
  drop_na() 

autoplot(clara(data.noNA, 3))

# KNN imputation
knn_na_imp_insulin <- na.data %>%
  imputate_na(Insulin, method = "knn")

knn_na_imp_insulin %>%
  plot()

# rpart
rpart_na_imp_insulin <- na.data %>%
  imputate_na(Insulin, method = "rpart")

rpart_na_imp_insulin %>%
  plot()

# mice 
mice_na_imp_insulin <- na.data %>%
  imputate_na(Insulin, method = "mice", seed = 123)

mice_na_imp_insulin %>%
  plot()

