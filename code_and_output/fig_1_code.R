library(ggplot2)
library(dplyr)
library(magrittr)
library(gridExtra)

weak_data <- weak_data %>% 
  group_by(m, dist) %>%
  mutate(bin_width = 2 * (IQR(prob) / length(prob)^(1/3))) 

# Likelihood plot
weak_data_lik <- filter(weak_data, dist == "Likelihood")
bws_lik <- unique(weak_data_lik$bin_width)

lp_hist_lik <- lapply(bws_lik, function(b) {
  geom_histogram(data = filter(weak_data_lik, bin_width == b),
                 mapping = aes(x = prob, fill = null),
                 binwidth = b)
})
p_hist_lik <- Reduce("+", lp_hist_lik, init = ggplot())

plot_lik <- p_hist_lik +
  scale_x_continuous(breaks = c(0, 0.4, 1)) +
  theme_bw() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10),
        legend.text = element_text(size = 8),
        legend.title = element_blank(),
        legend.position = "none") +
  scale_fill_grey() +
  scale_colour_manual(values = c("black", "gray")) +
  facet_grid(dist ~ m, scales = "fixed", space = "fixed") +
  labs(x = "Standard Normal density",
       y = "Randomization Probability")

# Posterior plot
weak_data_post <- filter(weak_data, dist == "Posterior")
bws_post <- unique(weak_data_post$bin_width)

lp_hist_post <- lapply(bws_post, function(b) {
  geom_histogram(data = filter(weak_data_post, bin_width == b),
                 mapping = aes(x = prob, fill = null),
                 binwidth = b)
})
p_hist_post <- Reduce("+", lp_hist_post, init = ggplot())

plot_post <- p_hist_post +
  scale_x_continuous(breaks = c(0, 0.4, 1)) +
  theme_bw() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10),
        legend.text = element_text(size = 8),
        legend.title = element_blank(),
        legend.position = "bottom",
        strip.background.x = element_blank(),
        strip.text.x = element_blank()) +
  scale_fill_grey() +
  scale_colour_manual(values = c("black", "gray")) +
  facet_grid(dist ~ m, scales = "fixed", space = "fixed") +
  labs(x = "Subjective probability",
       y = "Randomization Probability")

# Stack the two plots and save
likelihoods_posteriors <- grid.arrange(
  plot_lik,
  plot_post,
  nrow = 2
)

ggsave(plot = likelihoods_posteriors,
       file = "code_and_output/likelihoods_posteriors.pdf",
       width = 6,
       height = 6,
       units = "in",
       dpi = 600)