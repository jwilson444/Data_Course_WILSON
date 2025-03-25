# 3/18/25 Notes ####
# Final presentation April 22nd, 
## ignore what it says our assigned final date/time is
# No class 4/1

## Assignment 6 ####
# Use skimr pkg skim() - tells you data distribution and other details

## Clean this data set ####
Bird <- read.csv('Data/Bird_Measurements.csv')
skim(Bird)

##. clean bird measurement data
## keeep: family species_number, species_name, english_name
## Cluth size, egg mass, mating system

keep = c('Family', 'Species_number', 'Species_name', 'English_name', 'Clutch_size',
         'Egg_mass', 'Mating_System')

Male <- Bird %>%
  select(keep, starts_with('M_'), -ends_with('_N')) %>%
  mutate(sex = 'male') %>%
  View()

Unsexed <- Bird %>%
  select(keep, starts_with('unsexed_'), -ends_with('_N')) %>%
  mutate(sex = 'unsexed') %>%
  View()

Female <- Bird %>%
  select(keep, starts_with('F_'), -ends_with('_N')) %>%
  mutate(sex = 'female') %>%
  View()

joined_birds <- full_join(Male, Female)

joined_birds1 <- full_join(joined_birds1, unsexed)
# now lots of NA values in cols, because each sex has M, N, or Unsexed ruining combining the cols


#fixing the names of the cols 
names(Male) #all contain variable and M_, get rid of M_

names(Male) <- names(Male) %>% str_remove('M_')
names(Female) <- names(Female) %>% str_remove('F_')
names(Unsexed) <- names(Unsexed) %>% str_remove('Unsexed_')

#rejoin the data sets to get data without separate cols for M_, F_, Unsexed_

joined_birds <- full_join(Male, Female)

joined_birds1 <- full_join(joined_birds, Unsexed)

View(joined_birds1)

Clean <- Male %>%   # same as joining data sets above, but using pipe function instead
  full_join(Female) %>%
  full_join(Unsexed)

View(Clean)

identical(names(Male), names(Female)) # tells you whether all col names are identical or not between data sets
identical(letters[1:3], c('a', 'b', 'c')) # Example of function?

## Clean this data set ####
## Worst Data Storage Ever

Worst <- read_xlsx('Worst Data Storage Ever.xlsx')

everything()
mean()
sd()
read.csv(argument1, argument2, ...etc)

### Making your own commands/functions ####
#Useful for saving your cleaning codes/commands so you don't have to start fromo 0 everytime

Weather <- function(){
  print('it is cold')
}

Weather() # New function from above code, now everytime I do weather(), it will put out 'it is cold'

add_numbers <- function(a,b){
  result <- a + b
  return(result)
}

add_numbers() # new function from above code, realize its only in my global env. and must be re-entered to use in different/clean env.
add_numbers(2, 4)
add_numbers(2, 4, 5, 10, 6) # won't work because there are more than the number of variables given in original function
add_numbers(13456, 8765)

## Can save your custom function to a .R file to reuse later
#Makes it so you don't have to start from the beginning everytime you clean a data set

#1. Save your function to a new .R file, maybe 'My_Function.R'
#Can add your packages as well

#2. Source('My_Function.R')
#Puts your functions and whatever else you put in the file into your environment

#3. Use your function!
