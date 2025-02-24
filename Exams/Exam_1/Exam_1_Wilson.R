# I. Read the cleaned_covid_data.csv file into an R data frame. (20 pts) ####
cleaned_covid_data <- read.csv('cleaned_covid_data.csv')


# II. Subset the data set to just show states that begin with “A” and save this as an object called A_states. (20 pts) ####
# Use the tidyverse suite of packages. Selecting rows where the state starts with “A” is tricky (you can use the grepl() function or just a vector of those states if you prefer)
library(tidyverse)
A_states <- cleaned_covid_data %>%
  filter(grepl('A', Province_State))


# III. Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts) ####
# Create a scatterplot
# Add loess curves WITHOUT standard error shading
# Keep scales “free” in each facet
A_states %>%
  mutate(Last_Update = as.Date(Last_Update, format = "%Y-%m-%d")) %>%
  filter(!is.na(Last_Update), !is.na(Deaths), !is.na(Province_State)) %>%
           ggplot(aes(x = Last_Update,
                      y = Deaths)) +
           geom_point(size = 0.5, alpha = 0.5) + 
           geom_smooth(method = 'loess', se = F, color = 'orange') +
           theme_minimal() +
           facet_wrap(scales = 'free', ~Province_State) +
  labs(title = 'Deaths Over Time',  x = 'Date', y = 'Deaths')


# IV. (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)####
# I’m looking for a new data frame with 2 columns:
#  “Province_State”
# “Maximum_Fatality_Ratio”
# Arrange the new data frame in descending order by Maximum_Fatality_Ratio
# This might take a few steps. Be careful about how you deal with missing values!
State_Max_Fatality_Rate <- cleaned_covid_data %>%
  group_by(Province_State) %>%
  filter(!is.na(Case_Fatality_Ratio)) %>%
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio)) %>%
  arrange(desc(Maximum_Fatality_Ratio))


# V. Use that new data frame from task IV to create another plot. (20 pts) ####
# X-axis is Province_State
# Y-axis is Maximum_Fatality_Ratio
# bar plot
# x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
# X-axis labels turned to 90 deg to be readable
# Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.
State_Max_Fatality_Rate1 <- State_Max_Fatality_Rate %>%
  mutate(Province_State = fct_reorder(Province_State, Maximum_Fatality_Ratio, .desc = T))

State_Max_Fatality_Rate1 %>%
  ggplot(aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = 'Maximum Fatality Ratio by State', x = 'Province_State', y = 'Maximum_Fatality_Ratio')


# VI. (BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time ####
# You’ll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.

BO <- cleaned_covid_data %>%
  filter(!is.na(Last_Update), !is.na(Deaths), !is.na(Province_State)) %>%
  mutate(Last_Update = as.Date(Last_Update, format = "%Y-%m-%d")) %>%
  group_by(Last_Update) %>%
  summarise(Total_Deaths = sum(Deaths)) %>%
  arrange(Last_Update)

BO %>%
  ggplot(aes(x = Last_Update,
             y = Total_Deaths)) +
  geom_line(stat = 'identity') +
  theme_minimal() +
  labs(title = 'Deaths over Time in the US', x = 'Date', y = 'Deaths')
  

