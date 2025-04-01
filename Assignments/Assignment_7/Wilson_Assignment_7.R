# 1. Import the Assignment_7/Utah_Religions_by_County.csv data set ####
rel <- read.csv(file = 'Utah_Religions_by_County.csv')

# 2. Clean it up into “tidy” shape ####
library(janitor)
library(tidyverse)

rel1 <- rel %>%
  clean_names()
View(rel1)

rel2 <- rel1 %>%
  pivot_longer(cols = 5:17,
               names_to = 'denomination',
               values_to = 'occurence') %>%
  pivot_longer(cols = 3:4,
               names_to = 'religious',
               values_to = 'proportion')
View(rel2)

# 3. Explore the cleaned data set with a series of figures (I want to see you exploring the data set) ####
rel2 %>%
  ggplot(aes(x = occurence, 
             y = pop_2010, 
             color = denomination)) +
  geom_point() +
  facet_wrap(~county)
# Realized not a great way to view data as population is the same across the plot... try again
rel2 %>%
  ggplot(aes(x = occurence, 
             y = pop_2010, 
             color = denomination)) +
  geom_point()
  
View(rel3)

## Address the questions:
## a) “Does population of a county correlate with the proportion of any specific religious group in that county?” ####
Mod1 <- rel2 %>%
  glm(data = .,
      formula = pop_2010 ~ occurence + denomination)

summary(Mod1)
performance(Mod1)

## b) “Does proportion of any specific religion in a given county correlate with the proportion of non-religious people?” ####


## Just stick to figures and maybe correlation indices…no need for statistical tests yet ####
## Add comment lines that show your thought processes _____________ ####