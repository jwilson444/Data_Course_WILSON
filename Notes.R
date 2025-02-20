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

# 4. Save this as a .csv file on your laptop. and open it.
write.csv(Heavy_V8s, '/Users/jeremywilson/Desktop/Data_Course_WILSON/Heavy_V8s.csv')
read.csv(Heavy_V8s.csv)

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
  geom_bar(stat = 'identity')
#my attempt
penguins %>%
  ggplot(aes(x = s, y = count(body_mass_g > 5000, n = T))) +
  geom_bar()

# 2/11/25 Warm-Up/Notes ####
library(tidyverse)
library(palmerpenguins)

penguins %>%
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_bar(stat = 'identity') #counts how many

penguins %>%
  ggplot(aes(x = species, fill = island)) +
  geom_bar(stat = 'count')
#then add dodge
penguins %>%
  ggplot(aes(x = species, fill = island)) +
  geom_bar(stat = 'count', position = 'dodge') #default position is stack, dodge separates the stacks

penguins %>%
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_col() #default = stacked 

penguins %>%
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_col(position = 'dodge') 

penguins %>%
  group_by(species) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = T)) #na.rm = T removes NA from data calculation

## to show avg/degree of error on plot####
penguins %>%
  group_by(species) %>%
  summarise(avg_mass = mean(body_mass_g, na.rm = T),
            sd = sd(body_mass_g, na.rm = T)) %>%
  ggplot(aes(x = species, y = avg_mass)) +
  geom_bar(stat = 'identity') +
  geom_errorbar(aes(ymin = avg_mass - sd, #error bar function
                    ymax = avg_mass + sd),
                width = 0.2) # width changes width of error bars
  
## making an interesting graph for penguins data ####
# no using geom_point()
# Area off bills

penguins %>%
  group_by(species) %>%
  summarise(avg_bill_area = mean(bill_length_mm * bill_depth_mm, na.rm =T),
            sd = sd(body_mass_g, na.rm = T)) %>%
  ggplot(aes(x = species, y = avg_bill_area)) +
  geom_hex(
    mapping = NULL,
    data = NULL,
    stat = "binhex",
    position = "identity",
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = TRUE
  )

penguins %>%
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.2)

penguins %>%
  filter(!is.na(body_mass_g)) %>% #only adding this to remove the warning message from above code set
  ggplot(aes(x = body_mass_g, y = species)) +
  geom_density(alpha = 0.2)

### boxplots ####
penguins %>%
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_boxplot() + 
  geom_point() +
  geom_jitter # keeps points from overlapping

## Looking at penguins weights by year ####
penguins %>%
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = year, y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter() 
#above code doesn't show data well because year col is class of integer, so it averages the data
penguins %>%
  filter(!is.na(body_mass_g)) %>% 
  ggplot(aes(x = factor(year), y = body_mass_g)) +
  geom_boxplot() +
  geom_jitter()

install.packages('qrcode')
# making qr codes ####
library(qrcode)
url <- "https://www.reddit.com/r/datasets/comments/g4e7f3/hilarious_datasets/"
qr <- qrcode::qr_code(url)
plot(qr)

#github doesn't like lots of images and similar,
#use bioconductor.org or cran.r-project.org


# 2/13/25 Warm-UP/Notes ####
# Make a plot with 'flipper_length' on the x-axis and 'body mass' on y-axis
penguins %>%
  filter(!is.na(body_mass_g)) %>%
  filter(!is.na(flipper_length_mm)) %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_path() +
  geom_point() +
  stat_ellipse() + #makes a circle around data group
  geom_bin2d()
  
penguins %>%
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm)) %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_path() +
  geom_point() +
  stat_ellipse() + 
  geom_bin2d()

penguins %>%
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm)) %>%
  ggplot(aes(x = body_mass_g, fill = species)) +
  geom_histogram(alpha = 0.6)

penguins %>%
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm)) %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_density2d()

## Saving a plot as an object ####
my_plot <- penguins %>%
  filter(!is.na(body_mass_g), !is.na(flipper_length_mm)) %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_path() +
  geom_point() +
  geom_bin2d()

# Now I can add to it

my_2nd_plot <- my_plot + stat_ellipse()

# to export the plot as an image, use Zoom, adjust, screenshot
# OR Use below command to save a png
ggsave('wackypenguinsplot.jpg', plot = my_2nd_plot) # can add after plot -> , width = x, height = 8, dpi = 300

## loading a .tsv file ####
# load datasaurusDozen.tsv from data file

#read_tsv() reads tsv
DatasaurusDozen <- read_tsv('Data/DatasaurusDozen.tsv')

#read.delim() #tab delimited, function of tidyverse
DatasaurusDozen2 <- read.delim('Data/DatasaurusDozen.tsv')

dim(DatasaurusDozen) #can use these two functions to check dimensions and first lines
head(DatasaurusDozen)

summary(DatasaurusDozen$y) #summarise a variable?

DatasaurusDozen %>%
  group_by(dataset) %>%
  summarise(mean = mean(x),
            sd = sd(x),
            max = max(x),
            min = min(x))

DatasaurusDozen %>%
  ggplot(aes(x = x, fill = dataset)) +
  geom_density()

DatasaurusDozen %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  facet_wrap(~ dataset) # separates categories into their own plots

## Package GGally ####
install.packages('GGally')
library(GGally)

### BEST WAY TO FIRST LOOK AT A DATASET ####
ggpairs(penguins) #shows every variable as an x vs every other as a y, uses GGally
# Allows you to preview all data and look for correlations
# Best idea to clean the dataset before you do this to remove NA values and other things that will distort the data

## package gapminder ####
install.packages('gapminder')
library(gapminder)

# Assignment to remake the ggplot_reverse_engineering plot ####
# x = Bill depth (mm), y = Body mass (g), fill = sex, 3 dot plots by species
  
penguins %>%
  filter(!is.na(bill_depth_mm), !is.na(body_mass_g), !is.na(sex)) %>%
  ggplot(aes(x = bill_depth_mm,
             y = body_mass_g,
             color = sex)) +
  geom_point(size = 4, alpha = 0.7) +
  labs(x = 'Bill Depth (mm)', y = 'Body Mass (g)', color = 'Sex') +
  theme_minimal() +
  theme(panel.border = element_rect(color = "gray", linewidth = 0.75, fill = NA),
         text = element_text(family = 'Arial', face = 'bold')) +
  scale_color_manual(values = c(female = 'darkorchid4', male = 'palegreen3')) +
  facet_wrap(~species)

theme(axis.title = element_text(face = bold)) # Changing axis titles bold/italicized/size/etc...
strip.text = element_text(face = 'bold', size = )
#BOOM
#Run it back

penguins %>%
  filter(!is.na(bill_depth_mm), !is.na(body_mass_g), !is.na(sex)) %>%
  ggplot(x = bill_depth_mm, y = body_mass_g, color = sex) +
  geom_point(size = 3, alpha = 0.5) +
  theme_minimal() +
  facet_wrap(~species)



# Ugly Plot Contest Mar 4, 2025 ####



#Gapminder ####
Gap <- gapminder
data(gapminder)
GapPlot1 <- Gap %>%
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
           geom_point(aes(size = pop)) +
           facet_wrap(~continent)
ggsave('myGapPlot1.oong', plot = GapPlot1)


GDP_over_Time_by_country <- Gap %>%
  ggplot(aes(x = year, y = gdpPercap)) +
  geom_line() +
  facet_wrap(~continent)

GDP_over_Time_by_country

# TO VIEW PLOTS SIDE BY SIDE ####
p1 + p2
P1 / p2
(p1 + p2) / p3 + plot_annotation('Main title')

c1 <- ggplot(mtcars, aes(wt, mpg)) + geom_point() + ggtitle('Plot1')
c2 <- ggplot(mtcars, aes(disp, mpg)) + geom_point() + ggtitle('Plot2')
c3 <- ggplot(mtcars, aes(cyl, mpg)) + geom_point() + ggtitle('Plot3')

(c1 + c2) / c3 + 
  plot_annotation(
    title = 'Main title',
    tag_levels = 'A')

c3 + transition(time = year)


# 2/20/25 Warm-Up/Notes ####
## gganimate pkg ####
gganimate animates plots?
### making a gif/animation of data ####

df <- gapminder

p3 <- df %>%
  ggplot(aes(x=gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point()

p3

df$year %>% range
df$year %>% unique()

p3 + transition_time(time = year) +
  labs(title = 'Old People:{frame_time}')

p4 <- df %>%
  ggplot(aes(x = country,
             y = pop,)) +
  geom_col() +
  facet_wrap(~continent)
p4

p4gif <- p4 + transition_time(time = year) +
  labs(title = 'Pop over Time:{frame_time}')
#### saving a gif/animationo ####
anim_save('p4gif.gif')

# labeling dots with their country name
p3 <- df %>%
  ggplot(aes(x=gdpPercap,
             y = lifeExp,
             color = continent)) +
  geom_point()

p3

df$country %>% unique() 
my_country <- c('China', 'Malaysia', 'Singapore', 'Japan', 'Nepal', 
               'Iceland', 'Uganda', "Cote d'Ivoire", 'Rwanda')

df %>%
  mutate(my_countries = case_when(country %in% my_country ~ country)) %>%
  View()

df2 <- df %>%
  mutate(my_countries = case_when(country %>in% my_country ~ country)) %>%
  View()

p5 <- df %>%
  mutate(my_countries = case_when(country %in% my_country ~ country)) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  geom_text(aes(label = my_countries))


p5 + transition_time(time = year) +
  labs(title = 'Year')

# ggmap pkg ####
## https:://www.appsilon.com/post/r-ggmap
ggmap(nyc_map)

geocode('800 W University parkway, Orem, UT')


## make map ####

## plot map and add simple dots ####

##ggmagnify ####


# Practice (cleaning data) ####
df <- read_csv('Data/wide_income_rent.csv')
## read this data and plot rent for each state
## hint: x-axis = state, y-axis = rent, bar chart

df_t <- t(df) # BAD, variable, rent, incomee are included as data
df_t <- df_t[-1,1]
df_t$state <- row.names(df_t)
colnames(df_t) <- c('income', 'rent', 'state')

ggplot(df_t, aes(x = state, y = rent)) +
  geom_bar(state = 'identity') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
?pivot_longer
?pivot_wider

dat_ex <- data.frame(
  Id = c(1, 2, 3),
  Weight = c(78, 88, 100),
  Height = c(167, 180, 155))

dat_ex %>%
  pivot_longer(cols = c(Weight, Height), 
               names_to = 'Measure',
               values_to = 'Value') %>%
  View()


## Try to make longer data frame back to original using 'pivot wider'

#PACKAGES SHORTCUT ####
library(palmerpenguins)
library(gapminder)
library(tidyverse)
library(ggimage)
library(gganimate)
library(patchwork)
library(GGally)
library(ggplot2)
library(dplyr)

library(ggmap)



