# Exam 2
# You’re going to be looking at UNICEF data regarding child mortality rates for children under 5 years old. The file “unicef-u5mr.csv” contains this data set.
# “U5MR” refers to ‘under-5 years old mortality rate,’ and there is a time component to the data, which is also broken down by country, region, and continent.
# The mortality rate values are expressed as number of deaths (before age 5) per 1000 live births.
# It’s a sombering set of data at first glance, but actually tells a mostly encouraging story. It’s up to you to uncover that story. To do so, you will have to clean, plot, and model the data.

# 1. Read in the unicef data (10 pts) ####
library(tidyverse)
library(ggplot2)
library(easystats)
library(janitor)

uni <- read.csv(file = 'unicef-u5mr.csv')
str(uni)
View(uni)

# 2. Get it into tidy format (10 pts) ####
uni1 <- uni %>%
  pivot_longer(starts_with('U5MR'),
               names_to = 'year',
               values_to = 'U5MR') %>%
  mutate(year = str_remove(year, 'U5MR\\.')) %>%
  clean_names()

View(uni1)
str(uni1)

uni2 <- uni1 %>%
  mutate(year = as.numeric(year)) %>%
  mutate(continent = factor(continent))

View(uni2)
str(uni2)

# 3. Plot each country’s U5MR over time (20 points) ####
Plot_1 <- uni2 %>%
  ggplot(aes(x = year, y = u5mr, group = country_name)) +
  geom_line(color = 'black', size = 0.5) +
  facet_wrap(~continent) +
  theme_bw() +
  scale_x_continuous(limits = c(1945, 2020),
                    minor_breaks = seq(1950, 2020, by = 10),
                     breaks = c(1960, 1980, 2000)) +
  labs(x = 'Year', y = 'U5MR')

Plot_1

# 4. Save this plot as LASTNAME_Plot_1.png (5 pts) ####
ggsave('WILSON_Plot_1.png', plot = Plot_1)

# 5. Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)
uni3 <- uni2 %>%
  filter(!is.na(u5mr)) %>%
  group_by(continent, year) %>%
  summarise(mean_u5mr = mean(u5mr))

Plot_2 <- uni3 %>%
  ggplot(aes(x = year, y = mean_u5mr, color = continent, group = continent)) +
  geom_line(size = 2) + 
  theme_bw() +
  scale_x_continuous(limits = c(1945, 2020),
                     minor_breaks = seq(1950, 2020, by = 10),
                     breaks = c(1960, 1980, 2000)) +
  labs(x = 'Year', y = 'Mean_U5MR', color = 'Continent')

Plot_2 

# 6. Save that plot as LASTNAME_Plot_2.png (5 pts) ####
ggsave('WILSON_Plot_2.png', plot = Plot_2)

# 7. Create three models of U5MR (20 pts) ####
mod1 <- uni2 %>%
  filter(!is.na(u5mr)) %>%
  glm(.,
      formula = u5mr ~ year,
      family = gaussian())

performance(mod1)
  
mod2 <- uni2 %>%
  filter(!is.na(u5mr)) %>%
  glm(.,
      formula = u5mr ~ year + continent,
      family = gaussian())

performance(mod2) 
  
mod3 <- uni2 %>%
  filter(!is.na(u5mr)) %>%
  glm(.,
      formula = u5mr ~ year * continent,
      family = gaussian())

performance(mod3) 

# 8. Compare the three models with respect to their performance ####
compare_models(mod1, mod2, mod3)
compare_performance(mod1, mod2, mod3)
 ## mod3 is best, it has the lowest AIC, AICc, BIC, RMSE, sigma, and the highest R2.

# 9. Plot the 3 models’ predictions like so: (10 pts) ####
uni4 <- uni2 %>%
  filter(!is.na(u5mr))

uni5 <- uni4 %>%
  mutate(
    mod1_pred = predict(mod1, uni4, type = 'response'),
    mod2_pred = predict(mod2, uni4, type = 'response'),
    mod3_pred = predict(mod3, uni4, type = 'response')
  ) %>%
  pivot_longer(cols = starts_with('mod'),
               names_to = 'model',
               values_to = 'pred_u5mr') %>%
  mutate(model = recode(model, 'mod1_pred' = 'Model_1', 
                        'mod2_pred' = 'Model_2', 
                        'mod3_pred' = 'Model_3'))
View(uni5)
  
uni5 %>%
  ggplot(aes(x = year, y = pred_u5mr, color = continent)) +
  geom_line() +
  facet_wrap(~ model) +
  theme_bw() +
  labs(x = 'Year', y = 'Predicted U5MR', color = 'Continent')
  
# 10. BONUS - Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. How far off was your model prediction??? ####
df <- data.frame(year = 2020, 
                 continent = 'Americas')

df$continent <- factor(df$continent, levels = levels(uni2$continent))

predicted_u5mr <- predict(mod3, newdata = df, type = 'response')

predicted_u5mr # -10.58, that definitely can't be right

actual_u5mr <- 13

error1 <- abs((predicted_u5mr - actual_u5mr) / actual_u5mr * 100)

error1 # 181% off from actual!!! Yikes...

#tried making the model into a log model to avoid negative values, predicted the value as 11.99, but R2 was -0.933, which I learned means the model is TERRIBLE.
   ##learned that the log model does not handle very small values (0-1) which are present in my data set, which is likely why I got a -R2 value.

#learned online that a gamma regression with a log link will keep values positive and better account for u5mr values between 0 and 1.
mod3_gamma <- glm(u5mr ~ year * continent, data = uni2, family = Gamma(link = 'log'))

performance(mod3_gamma) # R2 value is now 0.788 which is much better

predicted_u5mr1 <- predict(mod3_gamma, newdata = df, type = "response")

predicted_u5mr1 # predicted value is 14.4!! 

error2 <- abs((predicted_u5mr1 - actual_u5mr) / actual_u5mr * 100)

error2 # 10.89% off from actual! Way better!

#For fun, I will try making a new model only for Ecuador

mod4 <- uni2 %>%
  filter(!is.na(u5mr)) %>%
  filter(country_name == 'Ecuador') %>%
  glm(.,
      formula = u5mr ~ year,
      family = Gamma(link = 'log')) # Yeah Guassian gets me a negative predicted value, Gamma log linked seems to work much better

performance(mod4) # R2 = 0.992 Can you tell I was wearing my glasses when I did this? lol.

predicted_u5mr2 <- predict(mod4, newdata = df, type = 'response')

predicted_u5mr2 #. 16.62, this must be what Dr. Zahn did

error3 <- abs((predicted_u5mr2 - actual_u5mr) / actual_u5mr * 100)

error3 #27.8% off
