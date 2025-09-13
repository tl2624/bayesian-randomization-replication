weak_sim <- function(y_C, true_tau, p_n_T, false_weak_null, m, n_draws){
  
  y_C = c(y_C, rep(x = y_C, times = m - 1))
  N = length(y_C)
  n_T = p_n_T * N
  n_C = (1 - p_n_T) * N
  y_T = y_C + true_tau
  
  mean_y_C <- mean(y_C)
  mean_y_T = mean(y_T)
  var_y_C = mean((y_C - mean(y_C))^2)
  var_y_T = mean((y_T - mean(y_T))^2)
  cov_y_T_y_C = mean((y_T - mean(y_T)) * (y_C - mean(y_C)))
  
  diff_means_est_EV = mean_y_T - mean_y_C
  diff_means_est_var = 1 / (N - 1) * ( n_T * var_y_C / n_C +
                                         n_C * var_y_T / n_T +
                                         2 * cov_y_T_y_C)
  
  consv_asymp_var = (1 - p_n_T)/ p_n_T * var_y_T + p_n_T/(1 - p_n_T) * var_y_C + var_y_C + var_y_T
  
  ests = rnorm(n = n_draws, mean = diff_means_est_EV, sd = sqrt(diff_means_est_var))
  
  t_stats_true = sqrt(N) * (ests - (mean_y_T - mean_y_C)) / sqrt(consv_asymp_var)
  t_stats_false = sqrt(N) * (ests - false_weak_null) / sqrt(consv_asymp_var)
  
  liks_null_true = dnorm(x = t_stats_true, mean = 0, sd = 1)
  liks_null_false = dnorm(x = t_stats_false, mean = 0, sd = 1)
  
  prior_liks_null_true = (liks_null_true * (1/2))
  prior_liks_null_false = (liks_null_false * (1/2))
  
  prob_ev = prior_liks_null_true + prior_liks_null_false
  
  posts_null_true = prior_liks_null_true/prob_ev
  posts_null_false = prior_liks_null_false/prob_ev
  
  data = data.frame(
    prob = c(liks_null_true, liks_null_false, posts_null_true, posts_null_false),
    dist = c(rep("Likelihood", n_draws * 2),
             rep("Posterior", n_draws * 2)), 
    null = c(rep("True weak causal hypothesis", n_draws),
             rep("False weak causal hypothesis", n_draws),
             rep("True weak causal hypothesis", n_draws),
             rep("False weak causal hypothesis", n_draws)),
    m = paste0("N = ", N)
  )
  
  return(data)
}

#################################
##### Simulation Run #############
#################################

N <- 20
set.seed(1:5)
y_C <- rnorm(n = N, mean = 50, sd = 10)
p_n_T <- 0.5
true_tau <- 10
null_tau <- 5
n_draws <- 1000

weak_data_m_1 <- weak_sim(y_C, true_tau, p_n_T, null_tau, m = 1, n_draws)
weak_data_m_2 <- weak_sim(y_C, true_tau, p_n_T, null_tau, m = 5, n_draws)
weak_data_m_3 <- weak_sim(y_C, true_tau, p_n_T, null_tau, m = 10, n_draws)
weak_data_m_4 <- weak_sim(y_C, true_tau, p_n_T, null_tau, m = 50, n_draws)

weak_data <- rbind(weak_data_m_1, weak_data_m_2, weak_data_m_3, weak_data_m_4)
weak_data$m <- factor(x = weak_data$m,
                      levels = c(paste0("N = ", N * 1),
                                 paste0("N = ", N * 5),
                                 paste0("N = ", N * 10),
                                 paste0("N = ", N * 50)))
weak_data$null <- factor(x = weak_data$null,
                         levels = c("False weak causal hypothesis",
                                    "True weak causal hypothesis"))