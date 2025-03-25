GE <- read_csv('countries.csv')
View(GE)

# Remove unwanted columns
SP1 <- SP %>%
  select(-subject_id, -cohort, -demo_firstgen, -demo_race, -demo_gender) 

#Compare all columns against each other
ggpairs(GE, cardinality_threshold = NULL)

  

GE %>%
  ggplot(aes(x = Region, y = `Total Ecological Footprint`, )) + 
  geom_image(aes(image = 'Seabear.png')) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90))


# UGLY PLOT ####
library(png)
read_
img <- readPNG('Seabear.png')

face_img <- rasterGrob(img, interpolate = T)


Patrick <- ggplot(GE, aes(x = `GDP per Capita`, y = `Fish Footprint`)) +
  background_image(img) +
  geom_point(size = 10, shape = sample(0:25, nrow(GE), replace = TRUE), 
             color = sample(colors(), nrow(GE), replace = TRUE)) +  # Random colors & shapes
  geom_text(aes(label = sample(LETTERS, nrow(GE), replace = TRUE)), 
            angle = sample(0:360, nrow(GE), replace = TRUE), size = 8) +  # Random letters
  theme(
    panel.background = element_rect(fill = sample(colors(), 1)),  # Random background
    legend.position = 'right',
    axis.text = element_text(size = 2, angle = 90, color = sample(colors(), 1)),  # Tiny unreadable text
    axis.title = element_text(size = 5, face = "bold", color = "red")  # Ugly axis labels
  ) +
  ggtitle("gdp vs. country vs.", "PATRICK THE ANNIHILATOR") +
  theme(plot.title = element_text(size = 10, face = "italic", color = "darkgreen")) +
  theme(plot.subtitle = element_text(size = 30, face = "bold", color = 'darkred'))

ggsave('Country GDP vs Fish Footprint, super chill plot.jpg', plot = Patrick, dpi = 300) # can add after plot -> , width = x, height = 8, dpi = 300

