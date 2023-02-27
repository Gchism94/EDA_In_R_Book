# Title: EDA in R - Imputing I (Outliers)
# Author: Greg Chism
# Date: 2023-02-27
# Description: EDA in R workshop on imputing outliers

# Install packages
install.packages("pacman")

pacman::p_load(dlookr, # for exploratory data analysis
               formattable,
               ggpubr,
               RCurl,
               tidyverse)

# Downloading and loading data
data <- getURL("https://raw.githubusercontent.com/Gchism94/Data7_EDA_In_R_Workshops/main/Data7_EDA_In_R_Book/data/Data_Fig2_Repo.csv")

data <- read.csv(text = data)

data %>%
  head() %>%
  formattable()

# Diagnose your data
data %>%
  diagnose() %>%
  formattable()

# Diagnose outliers
data %>%
  diagnose_outlier() %>%
  filter(outliers_ratio > 0) %>%
  formattable()

# Visualize outliers
data %>%
  select(find_outliers(data)) %>%
  plot_outlier()

# Visualize outliers within groups
data %>%
  filter(Group != "Drought-sens-canopy") %>%
  ggplot(aes(x = Sap_Flow, y = Group, fill = Group)) +
  geom_boxplot(width = 0.5, outlier.size = 2, outlier.alpha = 0.5) +
  theme_pubclean(base_size = 14) +
  theme(legend.position = "none")

# Imputations (mean)
meanImp_SapFlow <- data %>%
  select(Sap_Flow) %>%
  imputate_outlier(Sap_Flow, method = "mean")

meanImp_SapFlow %>%
  summary()

# Plot mean imputation
meanImp_SapFlow %>%
  plot()

# Attaching imputed values to main data
meanImp_SapFlow_df <- data.frame(meanImp = meanImp_SapFlow)

dataImp <- cbind(meanImp_SapFlow_df, data)

# Visualize imputed values within groups
dataImp %>%
  ggplot(aes(x = meanImp, y = Group, fill = Group)) +
  geom_boxplot(width = 0.5, outlier.size = 2, outlier.alpha = 0.5) +
  theme_pubclean(base_size = 14) +
  theme(legend.position = "none")

# Median imputation
medianImp_SapFlow <- data %>%
  select(Sap_Flow) %>%
  imputate_outlier(Sap_Flow, method = "median")

medianImp_SapFlow %>%
  summary()

# Plot median imputation
medianImp_SapFlow %>%
  plot()

# Mode imputation
modeImp_SapFlow <- data %>%
  select(Sap_Flow) %>%
  imputate_outlier(Sap_Flow, method = "mode")

modeImp_SapFlow %>%
  summary()

# Plot mode imputation
modeImp_SapFlow %>%
  plot()


# Capping imputation (aka Winsorizing)
cappingImp_SapFlow <- data %>%
  select(Sap_Flow) %>%
  imputate_outlier(Sap_Flow, method = "capping")

cappingImp_SapFlow %>%
  summary()

# Plot capping imputation
cappingImp_SapFlow %>%
  plot()

# Attaching imputed values to main data
cappingImp_SapFlow_df <- data.frame(cappImp = cappingImp_SapFlow)

dataImp_cap <- cbind(cappingImp_SapFlow_df, data) 

# Visualize imputed values within groups
dataImp_cap %>%
  ggplot(aes(x = cappImp, y = Group, fill = Group)) +
  geom_boxplot(width = 0.5, outlier.size = 2, outlier.alpha = 0.5) +
  theme_pubclean(base_size = 14) +
  theme(legend.position = "none")



