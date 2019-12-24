# Data Cleansing 
columns_in_csv = c("character", "character", "integer", "integer", "integer", "integer", "factor","character","factor","integer","character", "integer", "integer")
steph_curry <- read.csv("data_extracted/stephen-curry.csv", stringsAsFactors = F, colClasses = columns_in_csv)
kevin_durant <- read.csv("data_extracted/kevin-durant.csv", stringsAsFactors = F, colClasses = columns_in_csv)
klay_thompson <- read.csv("data_extracted/klay-thompson.csv", stringsAsFactors = F, colClasses = columns_in_csv)
draymond_green <- read.csv("data_extracted/draymond-green.csv", stringsAsFactors = F, colClasses = columns_in_csv)
andre_iguodala <- read.csv("data_extracted/andre-iguodala.csv", stringsAsFactors = F, colClasses = columns_in_csv)
names(steph_curry)
names(kevin_durant)
names(klay_thompson)
names(draymond_green)
names(andre_iguodala)
steph_curry <- mutate(steph_curry, Player = "Stephen")
kevin_durant <- mutate(kevin_durant,Player  = "Kevin")
klay_thompson  <- mutate(klay_thompson, Player = "Klay")
draymond_green <- mutate(draymond_green, Player = "Draymond")
andre_iguodala <- mutate(andre_iguodala, Player = "Andre")
new_df <- rbind(steph_curry, kevin_durant, klay_thompson, draymond_green, andre_iguodala)
write.csv(new_df, file = "data_extracted/GSW_Players_Shot_Data.csv")

# Visualization 
ggplot(data = new_df) + 
  annotation_custom(background_img, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = Shot)) +
  ylim(-50,420) +
  ggtitle("2016 Season Golden State Warriors Players' Shot Charts") +
  labs(caption = "Visualization by: Vishal Sunkara\nSource: stats.nba.com") +
  theme_minimal() + facet_wrap(Player ~.)

# Analysis
temp_df <- read.csv("/data_extracted/GSW_Players_Shot_Data.csv", stringsAsFactors = F)
shot_two <- select(filter(temp_df, Shot_Point == "2PT Field Goal"), Player, Shot)
points_two = shot_two %>%
  group_by(Player) %>%
  summarise(Total = n(), Shots_Made = sum(Shot == "Yes")) 
points_two <- arrange(mutate(points_two, Shots_Made_Percentage = round((Shots_Made/Total)*100)), desc(Shots_Made_Percentage))
points_two <- as.data.frame(points_two)
shot_three <- select(filter(temp_df, Shot_Point == "3PT Field Goal"), Player, Shot)
points_three = shot_three %>%
  group_by(Player) %>%
  summarise(Total = n(), Shots_Made = sum(Shot == "Yes")) 
points_three <- arrange(mutate(points_three, Shots_Made_Percentage = round((Shots_Made/Total)*100)), desc(Shots_Made_Percentage))
points_three <- as.data.frame(points_three)
all <- select(temp_df, Player, Shot)
all_points = all %>%
  group_by(Player) %>%
  summarise(Total = n(), Shots_Made = sum(Shot == "Yes")) 
all_points <- arrange(mutate(all_points, Shots_Made_Percentage = round((Shots_Made/Total)*100)), desc(Shots_Made_Percentage))
all_points <- as.data.frame(all_points)
