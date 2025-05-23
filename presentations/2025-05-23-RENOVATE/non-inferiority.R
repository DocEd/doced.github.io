library(tidyverse)
library(simstudy)

set.seed(1987)

## Generate some data for a drug that increases your PaO2
## Oxy-action
## Oxy-action is much cheaper than the market leader "Oxygen"
# We don't need to know if oxy-action is better than oxygen, we need to know
# is it not worse?
# So our control group, treated with oxygen achives an average PaO2 of 10
# We decide that our non-inferiority margin is 1 kPa

def <- defData(varname = "male", dist = "binary", 
               formula = .5 , id="cid")
def <- defData(def, varname = "rx", dist = "trtAssign",
               formula = "1;1")
def <- defData(def, varname = "y", dist = "beta", 
               formula = "0.7 + 0.05*rx", variance = 10)

dtstudy <- genData(50, def)

dtstudy %>%
  as_tibble() %>%
  mutate(treatment = factor(rx,
                               levels = c(0, 1),
                               labels = c("Control", "Oxy-Action"))) %>%
  ggplot(aes(x = y, fill = treatment)) +
  geom_density(alpha = 0.5) +
  theme_bw() +
  theme(axis.title.y = element_blank()) +
  labs(x = "Oxygen Saturation")

ggsave("./2025-05-RENOVATE/non-inferior-1.png", height = 9, width = 16, units = "cm")

dtstudy <- genData(500, def)

dtstudy %>%
  as_tibble() %>%
  mutate(treatment = factor(rx,
                               levels = c(0, 1),
                               labels = c("Control", "Oxy-Action"))) %>%
  ggplot(aes(x = y, fill = treatment)) +
  geom_density(alpha = 0.5) +
  theme_bw() +
  theme(axis.title.y = element_blank()) +
  labs(x = "Oxygen Saturation")

ggsave("./2025-05-RENOVATE/non-inferior-2.png", height = 9, width = 16, units = "cm")

dtstudy <- genData(5000, def)

dtstudy %>%
  as_tibble() %>%
  mutate(treatment = factor(rx,
                               levels = c(0, 1),
                               labels = c("Control", "Oxy-Action"))) %>%
  ggplot(aes(x = y, fill = treatment)) +
  geom_density(alpha = 0.5) +
  theme_bw() +
  theme(axis.title.y = element_blank()) +
  labs(x = "Oxygen Saturation")

ggsave("./2025-05-RENOVATE/non-inferior-3.png", height = 9, width = 16, units = "cm")
