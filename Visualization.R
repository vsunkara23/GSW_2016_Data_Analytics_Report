ggplot(data = new_df) + 
  annotation_custom(background_img, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = Shot)) +
  ylim(-50,420) +
  ggtitle("2016 Season Golden State Warriors Players' Shot Charts") +
  labs(caption = "Visualization by: Vishal Sunkara\nSource: stats.nba.com") +
  theme_minimal() + facet_wrap(Player ~.)
