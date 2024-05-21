install.packages(c("tidyverse", "ggplot2"))
library(tidyverse)
library(ggplot2)


##n-terminal
data <- read.table("N-term.pepstat.tsv", header = T, sep = "\t")


data_long <- data[2:13] %>%
  pivot_longer(cols = -c(group), names_to = "Variable", values_to = "Value")

# Plotting
p <- ggplot(data_long, aes(x = group, y = Value, color = group)) +
  geom_point() +
  facet_wrap(~Variable, scales = "free_y", ncol = 6) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Show the plot
print(p)

##c-termial
c_data <-read.table("C-term.pepstat.tsv", header = T, sep = "\t")
c_data_long <- c_data[2:13] %>%
  pivot_longer(cols = -c(group), names_to = "Variable", values_to = "Value")
p <- ggplot(data_long, aes(x = group, y = Value, color = group)) +
  geom_point() +
  facet_wrap(~Variable, scales = "free_y", ncol = 6) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Show the plot
print(p)