library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)
library(skimr)
library(MASS)

# Write a script that: ####
## 1. loads the “/Data/mushroom_growth.csv” data set ####
shrooms <- read.csv('../../Data/mushroom_growth.csv')

## 2. creates several plots exploring relationships between the response and predictors ####
View(shrooms)
glimpse(shrooms)

Plot1 <- shrooms %>%
  ggplot(aes(x = Light, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~Species)

Plot2 <- shrooms %>%
  ggplot(aes(x = Nitrogen, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~Species)

Plot3 <- shrooms %>%
  ggplot(aes(x = Humidity, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~Species)

Plot4 <- shrooms %>%
  ggplot(aes(x = Temperature, y = GrowthRate)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  facet_wrap(~Species)

## 3. defines at least 4 models that explain the dependent variable “GrowthRate” ####
Continuous: Regression, ANOVA, ANCoVA
Catergorical: ANOVA
Proportion: Logistic regression
Count: Log-Linear model
Binary: Binary logistic

mod1 <- glm(data = shrooms,
            formula = GrowthRate ~ Temperature * Nitrogen * Humidity)
performance(mod1)
summary(mod1)

mod2 <- glm(data = shrooms,
            formula = GrowthRate ~ Temperature + Humidity + Nitrogen)
performance(mod2)
summary(mod2)

mod3 <- aov(data = shrooms,
               formula = GrowthRate ~ Temperature * Nitrogen * Humidity + Light)
performance(mod3)
summary(mod3)

mod4 <- aov(data = shrooms,
            formula = GrowthRate ~ (Temperature * Nitrogen * Humidity) * Light)
performance(mod4)
summary(mod4)

compare_performance(mod1, mod2, mod3, mod4)

## 4. calculates the mean sq. error of each model ####
Actual <- shrooms$GrowthRate

pred1 <- predict(mod1, newdata = shrooms)
pred2 <- predict(mod2, newdata = shrooms)
pred3 <- predict(mod3, newdata = shrooms)
pred4 <- predict(mod4, newdata = shrooms)
  
MSE1 <- mean((Actual - pred1)^2) #7604.919
MSE2 <- mean((Actual - pred2)^2) #7757.249
MSE3 <- mean((Actual - pred3)^2) #5578.881
MSE4 <- mean((Actual - pred4)^2) #5119.339


## 5. selects the best model you tried ####
compare_performance(mod1, mod2, mod3, mod4) %>% plot()
#mod 4 is the best 

## 6. adds predictions based on new hypothetical values for the independent variables used in your model ####
df = data.frame(Temperature = c(27, 30, 40, 27, 30, 40),
                Humidity = as.character(c('Low', 'Low', 'Low', 'High', 'High', 'High')),
                Nitrogen = c(55, 65, 75, 55, 65, 75),
                Light = c(30, 50, 70, 30, 50, 70))


prednew <- predict(mod4, newdata = df)

## 7. plots these predictions alongside the real data ####
shrooms$Type <- 'Actual'
df$Type <- 'Hypothetical'
df$GrowthRate <- prednew

actual_plot_data <- shrooms[, c("Temperature", "GrowthRate", "Type", "Humidity")]

hypothetical_plot_data <- df[, c("Temperature", "GrowthRate", "Type", "Humidity")]

combined_plot_data <- rbind(actual_plot_data, hypothetical_plot_data)

combined_plot_data %>%
  ggplot(aes(x = Temperature, y = GrowthRate, color = Type, shape = Type)) +
  geom_point(size = 2) +
  facet_wrap(~Humidity) +
  labs(title = "Actual vs Hypothetical Predictions (Model 4)",
       x = "Temperature",
       y = "Growth Rate") +
  theme_minimal()


## 8. Upload responses to the following as a numbered plaintext document to Canvas: ####


### a. Are any of your predicted response values from your best model scientifically meaningless? Explain. ####
Some of the predicted response values from my best model were scientifically meaningless. For example, when humidity is high, the linear model predicts a decrease in growth rate as temperature increases. As temperature reaches 30 and 40 degrees celsius, the predicted growth rate is negative. A negative growth rate is not possible and is thus meaningless.

### b. In your plots, did you find any non-linear relationships? Do a bit of research online and give a link to at least one resource explaining how to deal with modeling non-linear relationships in R. ####
I believe there was a non-linear relationship between humidity and the other factors. I say this because when the values are plotted together for the given values in my new data set, it appears exponential in nature.
https://noamross.github.io/gams-in-r-course/

### c. Write the code you would use to model the data found in “/Data/non_linear_relationship.csv” with a linear model (there are a few ways of doing this) ####
nonlinear <- read.csv('../../Data/non_linear_relationship.csv')
summary(nonlinear)
View(nonlinear)

plot(nonlinear$predictor, nonlinear$response,
     main = 'Response vs Predictor',
     xlab = 'Predictor',
     ylab = 'Response',
     pch = 19, col = 'blue')

model_raw <- lm(response ~ predictor, data = nonlinear)
abline(model_raw, col = "red", lwd = 2) 
summary(model_raw)

nonlinear$predictor_sq <- nonlinear$predictor^2
model_quad <- lm(response ~ predictor + predictor_sq, data = nonlinear)
summary(model_quad)

pred_vals <- seq(min(nonlinear$predictor), max(nonlinear$predictor), length.out = 100)
pred_df <- data.frame(predictor = pred_vals, predictor_sq = pred_vals^2)
lines(pred_vals, predict(model_quad, newdata = pred_df), col = "darkgreen", lwd = 2)

compare_performance(model_raw, model_quad) %>% plot()
