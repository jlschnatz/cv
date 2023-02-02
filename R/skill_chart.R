if(!"pacman" %in% installed.packages()) {install.packages("pacman")}
pacman::p_load(tidyverse, glue, ggtext, sysfonts, showtext, readxl, here)
source(here("lib/str_wrap_html.R"))

font_add_google("Source Sans Pro", "ssp")
showtext_auto()
showtext_opts(dpi = 600)
bg_col <- "#F7F7F7"
highlight_col <- "#009FB7"
  
skills_data <- read_xlsx(here("data/cv-data.xlsx"), sheet = "skills")

proc_skill_data <- skills_data %>% 
  mutate(phrased_proficiency = str_wrap_html(phrased_proficiency, width = 30)) %>%
  mutate(language = glue("**{language}<br>**")) %>%
  mutate(language = str_c(language, phrased_proficiency, sep = " ")) %>%
  mutate(language = fct_reorder(language, proficiency)) %>%
  mutate(proficiency = map(proficiency, seq_len)) %>%
  unnest(proficiency) 

skill_data_full <- proc_skill_data %>%
  mutate(proficiency = 5) %>%
  mutate(proficiency = map(proficiency, seq_len)) %>%
  unnest(proficiency) 


proc_skill_data %>%
  ggplot(aes(x = proficiency, y = language)) + 
  geom_point(
    size = 4.5,
    color = highlight_col,
    fill = highlight_col,
    shape = 21
  ) + 
  geom_point(
    data = skill_data_full,
    mapping = aes(x = proficiency, y = language),
    size = 4.5,
    color = highlight_col,
    shape = 21
    ) + 
  facet_wrap(
    facets = ~type_skill, 
    scales = "free",
    nrow = 2
    ) +
  theme(
    text = element_text(family = "ssp", size = 16),
    axis.line = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_rect(fill = bg_col),
    plot.background = element_rect(fill = bg_col, colour = bg_col),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_markdown(
      margin = margin(r = 15), 
      color = "black",
      lineheight = 1.25),
    strip.background = element_rect(fill = highlight_col),
    strip.text = element_text(color = bg_col, face = "bold")
  )

ggsave(
  filename = here("img/language_skill.jpeg"), 
  width = 5, 
  height = 6, 
  dpi = 600
  )

