# 1. Load and clean FacultySalaries_1995.csv file and Re-create the graph below… ####
# Please pay attention to what variables are on this graph. This task is really all about whether you can make a tidy dataset out of something a bit wonky. Refer back to the video where we cleaned “Bird_Measurements.csv” if you need a refresher.
#FacultySalaries_1995.csv contains college faculty salaries and total compensation from 1995, by Ranks, Tier, and State (This is supposedly real data, but I’m not sure the scale. 600 definitely doesn’t mean $600,000, but it’s not important.)
#College faculty have 3 ranks: Assistant (not tenured), Associate (tenured), and Full (been around forever or something). College “Tier” refers to the amount of funding devoted to research vs the amount of funding for teaching, with Tier I being universities that spend more on research than teaching and award PhD degrees.
#Load libraries
library(gapminder)
library(tidyverse)
library(ggimage)
library(patchwork)
library(GGally)
library(ggplot2)
library(dplyr)
library(grid)
library(easystats)
library(janitor)
library(skimr)
library(caret)
library(broom)
library(purrr)
#Read in data
fac <- read.csv('FacultySalaries_1995.csv')
str(fac)
View(fac)

fac_cleaned <- fac %>%
  clean_names() %>%
  mutate(across(starts_with("avg_"), as.numeric)) %>%
  mutate(across(where(is.character), trimws)) %>%
  drop_na() # optional, depending on your goal

View(fac_cleaned)

fac1 <- fac_cleaned %>%
  pivot_longer(cols = c(avg_full_prof_salary, avg_assoc_prof_salary, avg_assist_prof_salary),
               names_to = 'rank',
               values_to = 'salary') %>%
  mutate(rank = case_when(rank == 'avg_full_prof_salary' ~ "Full",
                          rank == 'avg_assoc_prof_salary' ~ "Assoc",
                          rank == 'avg_assist_prof_salary' ~ "Assist",
                          T ~ rank))
View(fac1)

fac1_plot <- fac1 %>%
  filter(tier %in% c('I', 'IIA', 'IIB')) %>%
  ggplot(aes(x = rank, y = salary, fill = rank)) +
  geom_boxplot() +
  theme_minimal() +
  facet_wrap(~tier) +
  labs(x = 'Rank', y = 'Salary', fill = 'Rank') +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
fac1_plot

# 2. Build an ANOVA model and display the summary output in your report. ####
# The ANOVA model should test the influence of “State”, “Tier”, and “Rank” on “Salary” but should NOT include any interactions between those predictors.
fac_mod <- aov(data = fac1,
           formula = salary ~ state + rank + tier)

summary(mod)

# 3. The rest of the test uses another data set. The “Juniper_Oils.csv” data. Get it loaded and take a look. Then tidy it! (show the code used for tidying in your report) ####
#It’s not exactly tidy either. Get used to that. It’s real data collected as part of a collaboration between Young Living Inc. and UVU Microbiology. A number of dead cedar trees were collected and the chemical composition of their essential oil content was measured. The hypothesis was that certain chemicals would degrade over time since they died in fires. So there are a bunch of columns for chemical compounds, and a column for “YearsSinceBurn.” The values under each chemical are Mass-Spec concentrations. Those are the ones the columns we care about for the purposes of this exam. Guess what, I’m giving you a nicely formatted list of the chemical compounds:
#  c("alpha-pinene","para-cymene","alpha-terpineol","cedr-9-ene","alpha-cedrene","beta-cedrene","cis-thujopsene","alpha-himachalene","beta-chamigrene","cuparene","compound 1","alpha-chamigrene","widdrol","cedrol","beta-acorenol","alpha-acorenol","gamma-eudesmol","beta-eudesmol","alpha-eudesmol","cedr-8-en-13-ol","cedr-8-en-15-ol","compound 2","thujopsenal")
jun <- read.csv('Juniper_Oils.csv')
str(jun)
View(jun)

names(x = jun)

jun_cleaned <- jun %>%
  clean_names() %>%
  pivot_longer(cols = c("alpha_pinene","para_cymene","alpha_terpineol","cedr_9_ene","alpha_cedrene","beta_cedrene","cis_thujopsene","alpha_himachalene","beta_chamigrene","cuparene","compound_1","alpha_chamigrene","widdrol","cedrol","beta_acorenol","alpha_acorenol","gamma_eudesmol","beta_eudesmol","alpha_eudesmol","cedr_8_en_13_ol","cedr_8_en_15_ol","compound_2","thujopsenal"),
               names_to = 'chemical',
               values_to = 'concentration') %>%
  mutate(concentration = as.numeric(concentration),
         years_since_burn = as.numeric(years_since_burn))

View(jun_cleaned)
str(jun_cleaned)

# 4. Make me a graph of the following: ####
# x = YearsSinceBurn
# y = Concentration
# facet = ChemicalID (use free y-axis scales)
# See example figure for an idea of what I’m looking for:

jun_plot <- jun_cleaned %>%
  ggplot(aes(x = years_since_burn, y = concentration)) +
  geom_smooth() +
  facet_wrap(~chemical, scales = 'free_y') +
  theme_minimal() +
  labs(x = "Concentration", y = "Years Since Burn")
jun_plot

#5. Use a generalized linear model to find which chemicals show concentrations that are significantly (significant, as in P < 0.05) affected by “Years Since Burn”. ####
#Use the tidy() function from the broom R package in order to produce a data frame showing JUST the significant chemicals and their model output (coefficient estimates, p-values, etc)
#I’ll show you what I mean…here’s the sort of data frame I need you to produce from your glm model (just the significant model terms from a much larger model output):

significant_chemicals <- jun_cleaned %>%
  group_by(chemical) %>%
  group_modify(~ tidy(glm(concentration ~ years_since_burn, data = .x))) %>%
  filter(term == "years_since_burn", p.value < 0.05) %>%
  select(chemical, term, estimate, std.error, statistic, p.value) %>%
  arrange(p.value)

print(significant_chemicals)

# 6. Commit and push all your code and files to GitHub. I’ll pull your repository and grade what I find in your html report. ####



# None of the tasks here should be too difficult. You’ve done them before. So take a bit of care to produce a report that looks clean. Please include the code used to produce plots or models, etc. In the future, feel free to hide your code to make your reports for other projects look cleaner, but since we’re learning R in this course, I still mostly want to see your code where applicable. In other words, don’t use ‘echo=FALSE’ in every code chunk.
  