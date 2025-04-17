# Use the data set “/Data/GradSchool_Admissions.csv” ####
# You will explore and model the predictors of graduate school admission ####
# the “admit” column is coded as 1=success and 0=failure (that’s binary, so model appropriately) ####
# the other columns are the GRE score, the GPA, and the rank of the undergraduate institution, where I is “top-tier.” ####
# Document your data explorations, figures, and conclusions in a reproducible R-markdown report ####
# That means I want to see, in your html report, your process of model evaluation and selection. Here’s an example ####
# Upload your self-contained R project, including knitted HTML report, to GitHub in your Assignment_9 directory ####
library(gapminder)
library(tidyverse)
library(patchwork)
library(GGally)
library(ggplot2)
library(dplyr)
library(grid)
library(easystats)
library(janitor)
library(skimr)
library(MASS)
library(caret)
library(ggpubr)

admits <- read.csv('../../Data/GradSchool_Admissions.csv')

ggpairs(admits)
# Weak positive correlation between gre and gpa, start there with models

mod1 <- glm(data = admits,
            formula = as.logical(admit) ~ gre + gpa,
            family = 'binomial')
performance(mod1)

mod2 <- glm(data = admits,
            formula = as.logical(admit) ~ gre * gpa,
            family = 'binomial')
performance(mod2)

mod3 <- glm(data = admits,
            formula = as.logical(admit) ~ gre * gpa * rank,
            family = 'binomial')
performance(mod3)

mod4 <- aov(data = admits,
             formula = as.logical(admit) ~ gre * gpa * rank,
             family = 'binomial')
performance(mod4)

mod5 <- glm(data = admits,
            formula = as.logical(admit) ~ (gre + gpa) * rank,
            family = 'binomial')           
performance(mod5)

mod6 <- glm(data = admits,
            formula = as.logical(admit) ~ (gre * gpa) + rank,
            family = 'binomial')           
performance(mod6)

full_model <- glm(data = admits,
                  formula = as.logical(admit) ~ gre * gpa * rank,
                  family = 'binomial')

stepwise_mod <- stepAIC(full_model, direction = 'both')

best_model <- glm(data = admits,
                  formula = stepwise_mod$formula,
                  family = 'binomial')

compare_performance(mod1, mod2, mod3, mod4, mod5, mod6, best_model) %>% plot()

# Exploring nonlinear relationships
#polynomial
mod_poly <- glm(as.logical(admit) ~ gre + I(gre^2) + gpa + I(gpa^2) + rank,
                data = admits,
                family = "binomial")

performance(mod_poly)
compare_performance(mod1, mod2, mod3, mod4, mod5, mod6, best_model, mod_poly) %>% plot()
#Nope
#log transform
admits_log <- admits %>%
  mutate(log_gre = log(gre),
         log_gpa = log(gpa))

mod_log <- glm(as.logical(admit) ~ log_gre + log_gpa + rank,
               data = admits_log,
               family = "binomial")

performance(mod_log)
compare_performance(mod1, mod2, mod3, mod4, mod5, mod6, best_model, mod_log)
#Nope
#Splines
library(splines)

mod_spline <- glm(as.logical(admit) ~ ns(gre, 3) + ns(gpa, 3) + rank,
                  data = admits,
                  family = "binomial")

performance(mod_spline)
compare_performance(mod1, mod2, mod3, mod4, mod5, mod6, best_model, mod_spline) %>% plot()
#Nope
#GAMs
library(mgcv)

mod_gam <- gam(as.logical(admit) ~ s(gre) + s(gpa) + rank,
               data = admits,
               family = binomial)

summary(mod_gam)
compare_performance(mod1, mod2, mod3, mod4, mod5, mod6, best_model, mod_gam) %>% plot()
#Nope
#No obvious nonlinear relationships

#Cross_Validation
library(boot)
cv.glm(admits, best_model)

#Look for correlation in gpe * gre against acceptance
admits2 <- admits %>%
  mutate(gregpa = gpa * gre)

admits2 %>%
  ggplot(aes(x = gregpa, y = admit)) +
  geom_point() +
  facet_wrap(~rank)

#make predictions based on best model
admits$pred1 <- predict(mod6, admits, type = 'response')

admits$pred1 %>% summary() 
#  Min.   1st Qu.   Median    Mean    3rd Qu.   Max. 
#0.01922  0.19732  0.31679  0.31750  0.42447  0.64593 

#### Unsure If I need this admits <- admits %>%
#  mutate(accepted = case_when(admit = 1 ~ T, ))

admits <- admits %>%
  mutate(outcome = case_when(pred1 > 0.42 ~ 'Admit',
                             pred1 <= 0.42 ~ 'Denied')) %>%
  mutate(accurate = case_when(admit == 1 & outcome == 'Admit' ~ T,
                              admit == 0 & outcome == 'Denied' ~ T,
                              T ~ F))

overall_accuracy <- admits %>%
  summarise(accuracy = mean(accurate)) %>%
  pull(accuracy)

print(paste0("Overall model accuracy: ", round(overall_accuracy * 100, 2), "%"))

#Plotting the model/predictions
#GRE
gre_seq <- seq(min(admits$gre), max(admits$gre), length.out = 100)

plot_data_gre <- expand.grid(
  gre = gre_seq,
  gpa = mean(admits$gpa),
  rank = unique(admits$rank))

plot_data_gre$pred <- predict(mod6, newdata = plot_data_gre, type = "response")

ggplot(plot_data_gre, aes(x = gre, y = pred, color = factor(rank))) +
  geom_line(size = 1) +
  labs(title = "Predicted Admission vs GRE by Rank",
       x = "GRE Score",
       y = "Predicted Admission Probability",
       color = "Rank") +
  theme_minimal()

#GPA
gpa_seq <- seq(min(admits$gpa), max(admits$gpa), length.out = 100)
plot_data_gpa <- expand.grid(
  gre = mean(admits$gre),
  gpa = gpa_seq,
  rank = unique(admits$rank))

plot_data_gpa$pred <- predict(mod6, newdata = plot_data_gpa, type = "response")

ggplot(plot_data_gpa, aes(x = gpa, y = pred, color = factor(rank))) +
  geom_line(size = 1) +
  labs(title = "Predicted Admission vs GPA by Rank",
       x = "GPA",
       y = "Predicted Admission Probability",
       color = "Rank") +
  theme_minimal()


# Graph 2
new_data <- expand_grid(
  gre = seq(min(admits$gre), max(admits$gre), length.out = 50),
  gpa = quantile(admits$gpa, probs = c(0.25, 0.5, 0.75)),  # use a few fixed GPA values
  rank = 1:4)

new_data <- new_data %>%
  mutate(pred = predict(mod6, newdata = new_data, type = "response"))

ggplot(new_data, aes(x = gre, y = pred, color = factor(gpa))) +
  geom_line() +
  facet_wrap(~ rank) +
  labs(title = "Predicted Probability by GRE, GPA, and Rank",
       x = "GRE Score", y = "Predicted Admission Probability", color = "GPA") +
  theme_minimal()

