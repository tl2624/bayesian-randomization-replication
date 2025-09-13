# Setup -------------------------------------------------------------------

## Clear R environment
rm(list = ls())

# Install packages --------------------------------------------------------

source("install_packages.R")

# Code for simulation -----------------------------------------------------

source("code_and_output/simulation.R")

# Code to create Figure 1 in manuscript -----------------------------------

source("code_and_output/fig_1_code.R")

# Reproducibility Best Practices ------------------------------------------

## Print session info to console
cat("\n--- SESSION INFO ---\n")
print(sessionInfo())

## OPTIONAL: Save session info to a text file for submission
sink("sessionInfo.txt")
cat("--- SESSION INFO ---\n")
print(sessionInfo())
sink()