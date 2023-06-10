library(readr)
library(tidyverse)

labels <- read_csv("../data/ahk/data_labels_raw.txt") %>% 
  as_tibble()

labels <- labels %>%
  mutate(correct = !str_detect(images, ".*\\(wrong\\),$")) %>% # detect if an image contains a right or wrong
  mutate(images = str_replace_all(images, "\\(wrong\\),$", "\\,")) %>% # remove "(wrong)" from image names
  mutate(images = str_replace_all(images, "^.+\\\\([^\\\\]+)$", "\\1")) %>% # remove file path prefixes
  mutate(images = str_replace_all(images, "(\\s)?,(\\s)?", "")) # remove ending commas

write_csv(labels, file = "../data/ahk/data_lables_clean.txt")
