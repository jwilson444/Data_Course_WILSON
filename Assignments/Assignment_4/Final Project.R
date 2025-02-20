SP <- read_csv('cmu-sleep.csv')
View(SP)

# Remove unwanted columns
SP1 <- SP %>%
  select(-subject_id, -cohort, -demo_firstgen, -demo_race, -demo_gender) 

#Compare all columns against each other
ggpairs(SP1)

SP2 <- SP1 %>%
  ggplot(aes(x = TotalSleepTime, y = cum_gpa)) +
  geom_point() +
  theme_minimal() +
  labs(title = 'Total sleep vs. GPA', x = 'Total Sleep Time (mins)', y = 'Cumulative GPA')

SP2


