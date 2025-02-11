Users/jeremywilson/Desktop/Data_Course_WILSON/Data_Course_WILSON.Rproj

# Final Project/Website ####
#Don't use palmerpenguins or iris


# Basics ####
# getwd() -- tell me where I am!
# list.files() -- same as above
list.files(path = 'Data/', recursive = T) #search the subdirectories as well
list.files(path = 'Data/', recursive = F) #don't search past the current directory level
# list.files(path = 'Data/', pattern = '.txt') -- will find all .txt files in the Data 
# list.files(path = 'Data/', pattern = '.txt', recursive = T) 
# recursive - descend down the path for search
# pattern - search within a directory/file
## ‘^’ ^ = means beginning with
## '$' = ending with

## regex — to learn more, search regex (regular expression)

# readLines() 

## line = 

df_rent_by_state = read.csv('Data/wide_income_rent.csv')
dim(df_rent_by_state)


df_rent_by_state = read.csv('Data/wide_income_rent.csv', header = F)
df_rent_by_state

getwd

# Vectors: one dim with same type (numeric, character, logical) of ####
# c()
# numeric vector
vec_num <- c(1:3, 2:4)
vec_num2 <- c(1,2,3,2,3,4)
vec_num[2] # 2nd element in the vector

#character vector
vec <- 'apple','banana','kiwi'
vec_chr <- c('apple', 'banana', 'kiwi')
vec_chr [2]

#logical vector (TRUE/FALSE)
thre <- c(TRUE, TRUE, FALSE)

#mix vectors
vec_mix <- c(1, 'apple', TRUE)


#Types of Objects in R ####
# 1. vector (one dim, same type)
# 2. matrix (two dim, same type of data)
# 3. array (multiple dim, same type of data)
# 4. data frame (two dim, diff type of data)
# 5. list (multi dim, different type of data)
# 6. function (store a function)
    ## sum --> make this into a function
     ### Ex: sum(iris$Sepal.Length)
#Ex:
mat <- matrix(1:6, nrow = 3)
mat[2,1]
is.matrix(mat)



head(dat)

# Reading lines in a data set
readLines(file1, n =1)

# Loops ####
  ## while loop
     ## while assumption is true, do x (if you have ice cream, keep eating it until you run out)
  ## for Loop
     ## for each variable, do x (every monday, eat one scoop of ice cream)
for (variable in vector)  {command for each variable}
for (index in c(1,2,3,4,5,6,7,8,9,10)) {print(index)}
vec <- c('apple','banana','kiwi')
for (fruit in vec) {print(fruit)}
for (i in vec) {
  out = paste('I like')
  print(out)
}


##write a for loop to print out 12 month

Months <- c('January','February','March','April','May','June','July','August','September','October','November','December')
for (Month in Months) {
  print(months)
}


# 1/28/24 Warm-Up/Review ####

##Load 'mtcars' dataset
str(mtcars)
class(mtcars)
View(mtcars)
## 1. What type of object is this?
     # data.frame

## 2. Find cars with an mpg greater than 20 and 4 cyl,
## then save them to a new object
mtcars <- mtcars[mtcars$mpg>20,]
dim(mtcars)
my_mtcars <- mtcars
my_mtcars <- my_mtcars[my_mtcars$mpg > 20 & my_mtcars$cyl == 4,]
my_mtcars

## 3. Convert mpg to a character data type
my_mtcars$mpg <- as.character(my_mtcars$mpg)
my_mtcars$new_col <- as.numeric(my_mtcars$mpg)
my_mtcars$new_col <- my_mtcars$gear * my_mtcars$cyl

## 4. Convert the entire data frame to character data type
str(mtcars)
names(mtcars)

for (col in names(my_mtcars)) {
  #print(col)
  my_mtcars[, col] <- as.character(my_mtcars[, col])
}

##apply() can be used to 
apply()
  
class(new_dat_w_new_ipubt)
new_dat <- as.data.frame(new_dat_w_new_ipubt)
class(new_dat)

# Packages ####
library(package)

## tidyverse ####
makes some things easier?

## palmerpenguins ####

# 1/30/25 Warm-Up/Notes ####
## load 'mtcars' dataset
str(mtcars)
class(mtcars)
View(mtcars)
## 1. Find cars with an wt greater than 3 and 8 cyl, then save them to a new object.
Heavy_V8s <- mtcars[mtcars$wt > 3 & mtcars$cyl == 8, ] 
subset(Heavy_V8s)

## 2. Calculate the average mpg of the new object
mean(Heavy_V8s$mpg)

# 3. Create a new numeric vector object named "hp.cyl" which is calculated by dividing hp by cyl.
names(Heavy_V8s)
Heavy_V8s$hp.cyl <- Heavy_V8s$hp/Heavy_V8s$cyl
names(Heavy_V8s)

# HELP HELP ####
# 4. Save this as a .csv file on your laptop. and open it.
write.csv(Heavy_V8s, '/Users/jeremywilson/Desktop/Data_Course_WILSON/Heavy_V8s.csv')
Open(Heavy_V8s.csv)
# HELP HELP

## Find something in dataset ####
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>%
  View()

## Calculate values/Group/Pluck ####
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>%
  pluck('body_mass_g') %>%
  mean()
# OR
mean(dat_bill$body_mass_g)
# OR
dat_bill$body_mass_g %>%
  mean()
### Ex: Find and calculate mean body mass by species
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>%
  group_by(species) %>%
  summarise(mean_body_mass = mean(body_mass_g))

## Count ####
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>%
  group_by(species, island) %>%
  summarise(mean_body_mass = mean(body_mass_g), max_body_mass = max(body_mass_g), 
  count = n())

## Sort Data ####
penguins %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>%
  group_by(species, island) %>%
  summarise(mean_body_mass = mean(body_mass_g), max_body_mass = max(body_mass_g), 
            count = n()) %>%
  arrange(desc(mean_body_mass))

## Saving data as csv ####
write_csv(data, 'filepath')

# 2/4/5 Warm-Up/Notes ####
# 1.1 Find the fat penguins (body_mass > 5000)
fatties <- penguins %>%
  filter(body_mass_g > 5000)

# 1.2 Count how many are male and how many are female
penguins %>%
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarise(count = n())

# 1.3 Return the max body mass for male and female
penguins %>%
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarise(fattest = max(body_mass_g))

max(penguins$body_mass_g, na.rm = T)
#w/Tidyverse, you can do: penguins$body_mass_g %>%
  max(na.rm = T)

# 2.1 Add new column to penguins to dataset that says whether they're fat
## Adding a column ####
  # mutate(name_of_column = criteria) 
  # OR 
  # mutate(fat_or_not = case_when(body_mass_g > 5000 ~ 'fat', body_mass_g <=5000 ~ 'skinny'))

penguins %>%
  mutate(fat_or_not = body_mass_g > 5000) %>%
  View()

### MORE - defining more possible values for column ####
dat_peng <- penguins %>%
  mutate(fat_or_not = case_when(body_mass_g > 5000 ~ 'fat', 
                                body_mass_g <=5000 & body_mass_g > 3000 ~ 'medium',
                                body_mass_g <=3000 ~ 'skinny')) %>%
  View()
           
           
##Remove a column -> ???
penguins %>%
  names()
  
bad_dat <- penguins %>%
  mutate(yearrr = year + 20) %>%
  View()

bad_dat[, -(ncol(bad_dat)-1)]
ncol(bad_dat)
nrow(bad_dat)

bad_dat %>%
  select(-island)
bad_dat %>%
  select(-year)
bad_dat %>%
  select(-c(island,sex, year))

# NOTES:

## plotting (uses ggplot2 package) ####
# datacamp.com Introduction to ggplot2 cheat sheet, R graph gallery
plot(dat_peng$bill_length_mm, dat_peng$body_mass_g)

ggplot(data = dat_peng)

dat_peng %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = sex)) + 
  geom_point() +
  geom_smooth()

dat_peng %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = bill_length_mm,
             y = body_mass_g,
             color = sex,
             shape = fat_or_not)) +
  geom_point()

## aes = aesthetic
#linear line, removing error range
penguins %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = species)) + 
  geom_point() +
  geom_smooth(method = 'lm', se = F)  #lm = linear model, se = removes error range

#### Changing color and themes ####
# Can use Ghibli color "install.package(ghibli)
scale_color_#viridis_/manual(values = c(v1 = 'color', v2 = 'color2'))
theme_#many options
#Ex:
penguins %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_viridis_d() + # scale_color_vir, many options with different requirements
  geom_smooth(method = 'lm', se = F) 

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_manual(values = c(Gentoo = 'pink', Adelie = 'lightblue', Chinstrap = 'gray3')) + # scale_color_vir, many options with different requirements
  geom_smooth(method = 'lm', se = F) 

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_manual(values = c(Gentoo = 'pink', Adelie = 'lightblue', Chinstrap = 'gray3')) + # scale_color_vir, many options with different requirements
  geom_smooth(method = 'lm', se = F) +
  theme_classic()

penguins %>%
  ggplot(aes(x = bill_length_mm,
             y= body_mass_g,
             color = species)) + 
  geom_point() +
  scale_color_ghibli_d("LaputaMedium", direction = -1) +
  theme_dark() 

### bar graph #### 
penguins %>%
  ggplot(aes(x = flipper_length_mm,
             y= body_mass_g,
             fill = species)) +
  geom_col() # geom_col(position = 'dodge')

penguins %>%
  ggplot(aes(x = flipper_length_mm,
             y= body_mass_g,
             fill = species)) +
  geom_col(position = 'dodge')

## NA data ####
x <- c(1,2,3,NA,5,NA)
is.na(x) #
!is.na(x) #
x[!is.na(x)]

# 2/6/25 Warm-Up/Notes ####
# 1. Show a plot to show fat penguins and their species
penguins %>%
  filter(body_mass_g > 5000) %>%
  ggplot(aes(x = body_mass_g,
             color = species)) +
  geom_bar()
#OR
penguins %>%
  filter(body_mass_g > 3000) %>%
  group_by(species) %>%
  summarise(mean_body_mass_g = mean(body_mass_g)) %>%
  ggplot(aes(x = mean_body_mass_g,
             color = species)) +
  geom_bar()
#OR
penguins %>%
  filter(body_mass_g > 3000) %>%
  group_by(species, sex) %>%
  summarise(mean_body_mass_g = mean(body_mass_g),
            sd_body_mass_g = sd(body_mass_g)) %>%
  ggplot(aes(x = mean)) +
  geom_bar(stat = 'idnetiy')
#my attempt
penguins %>%
  ggplot(aes(x = species, y = count(body_mass_g > 5000, n = T))) +
  geom_bar()







