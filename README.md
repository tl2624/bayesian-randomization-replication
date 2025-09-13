# Overview
This file describes the replication material for Leavitt, T. (2023). Randomization-based, Bayesian inference of causal effects. _Journal of Causal Inference_, 11(1), 20220025. DOI: [10.1515/jci-2022-0025](https://doi.org/10.1515/jci-2022-0025)

## Computational Requirements

I ran the code on a 2023 MacBook Pro with an Apple M3 Max chip and 36 GB memory. The operating system is Sonoma 14.3.1. The R version is 4.4.2.

The R packages are ggplot2 (version 4.0.0), dplyr (version 1.1.4), magrittr (version 2.0.4), and gridExtra (version 2.3).

## Code and Output

To reproduce results, clone this repository and run `master.R` from the project root. All file paths are relative to the repository root, so there is no need to change the working directory manually.

Files: "install_packages.R", "fig_1_code.R", "simulation.R", "master.R" and "fig_1.pdf".

Description: The file "install_packages.R" installs ggplot2 (version 4.0.0), dplyr (version 1.1.4), magrittr (version 2.0.4), and gridExtra (version 2.3). The running time of "install_packages.R" is 23.2 seconds. The file "simulation.R" runs the simulation that eventually yields Figure 1 in the manuscript. The running time of "simulation.R" is 0.05 seconds. The file "fig_1_code.R" produces Figure 1 in the manuscript. The running time of "fig_1_code.R" is 1.38 seconds. The total running time of "master.R" is 23.51 seconds. The file "likelihoods_posteriors.pdf" is Figure 1 in the manuscript.