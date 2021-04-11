library(tidyverse)
library(ggpubr)

tibble(numeric_continuous_var_count = 2:100) %>%
      rowwise() %>%
      mutate(pairwise_cor_count = choose(numeric_continuous_var_count, 2)) %>%
      ggplot(aes(x=numeric_continuous_var_count,
                 y=pairwise_cor_count)) +
      geom_line(color="dodgerblue", size=2) +
      theme_minimal() +
      labs(title="Roughly 5k pairwise correlations can be 
generated from 100 numeric variables",
           y="Pairwise Correlation Count",
           x="Number of Continuous Variables")
ggsave("Figs/pairwise_correlations.png", width = 5, height = 4, dpi = 300, units = "in", device='png')

cor_df <- tibble(Month = c("June", "July", "August", "September"),
             Ice_cream_sales_thousands = c(7, 9, 10, 11),
             Shark_attacks_count = c(7.5, 8, 9.5, 10)) %>%
      mutate(Month = factor(Month, levels = c("June", "July", "August", "September")))

cor_df %>% 
      gather(key="var" , value="value", -Month) %>%
      ggplot(aes(x=Month,
           y=value,
           color=var,
           group=var)) +
      geom_point() +
      geom_line(size=1) +
      theme_minimal() +
      theme(legend.position = "top") +
      labs(title="Yikes! Ice cream sales and shark attacks 
are positively correlated",
           subtitle="Be cautious to conclude that X causes Y when they move together.",
           caption="Plot trickery applied to enchance key point.",
           y="Variable Units",
           x="Month",
           color="Variable")
ggsave("Figs/ice_cream_and_shark_attacks.png", width = 5, height = 4, dpi = 300, units = "in", device='png')
