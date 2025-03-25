# 1. Cleans this data into tidy (long) form ####
library(tidyverse)
rough <- read.csv("../../Data/BioLog_Plate_Data.csv")

# make absorbance times as one col 
smooth <- rough %>%
  rename('24' = Hr_24,
         '48' = Hr_48,
         '144' = Hr_144) %>%
  pivot_longer(cols = c('24','48','144'),
               names_to = 'Time',
               values_to = 'Absorbance') %>%
  mutate(Time = as.numeric(Time))
  View(smooth)
  str(smooth)


# 2. Creates a new column specifying whether a sample is from soil or water ####
smooth1 <- smooth %>%
    mutate(sample_type = case_when(Sample.ID == 'Clear_Creek' | Sample.ID == 'Waste_Water' ~ 'Water', Sample.ID == 'Soil_1' | Sample.ID == 'Soil_2' ~ 'Soil'))
View(smooth1)
  
# 3. Generates a plot that matches this one (note just plotting dilution == 0.1): ####
library(ggplot2)
smooth2 <- smooth1 %>%
  filter(Dilution == 0.100)
View(smooth2)

smooth2 %>%
  ggplot(aes(x = Time, y = Absorbance, color = sample_type)) +
  geom_smooth(se = F) +
  facet_wrap(~Substrate) +
  theme_minimal() + 
  labs(title = 'Just dilution 0.1', x = 'Time', y = 'Asborbance', color = 'Type')


# 4. Generates an animated plot that matches this one (absorbance values are mean of all 3 replicates for each group): \
# This plot is just showing values for the substrate “Itaconic Acid” ####
library(gganimate)
#x-axis - time
#y-axis - mean absorbance by sample.ID, Time, and Dilution
#color = sample (creek, soil 1,2, waste)
#facet_wrap = conc.

smooth3 <- smooth %>%
  filter(Substrate == 'Itaconic Acid') %>%
  group_by(Sample.ID, Time, Dilution) %>%
  summarise(Mean_Absorbance = mean(Absorbance, na.rm = T)) %>%
  ungroup()
View(smooth3)

smooth3 %>%
  ggplot(aes(x = Time, y = Mean_Absorbance, color = Sample.ID, group = Sample.ID)) +
  geom_line() +
  facet_wrap(~Dilution) +
  theme_minimal() +
  transition_reveal(Time)
