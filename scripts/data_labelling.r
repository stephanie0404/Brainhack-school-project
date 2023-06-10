library(readr)
library(tidyverse)
library(ggplot2)

# import filtered eeg file produced by eeg_filtering_ipynb
filtered_eeg <- read_csv("../data/eeg/raw-filt.csv") %>% 
  as_tibble()

# import raw eeg file
#eeg_raw <- read_csv("../data/eeg/raw_eeg_subset.csv # subset file for testing purposes
eeg_raw <- read_csv("../data/eeg/OpenBCI-RAW-2017-02-22_13-04-57.txt") %>%
  as_tibble() %>%
  rename(raw_eeg_data = `%OpenBCI Raw EEG Data`) %>% # comment this out if using the subset
  filter(!str_detect(raw_eeg_data, "^%")) %>%
  separate(raw_eeg_data, into = paste0("col", 1:13), sep = ",", extra = "merge") %>%
  rename(sample_index = col1,
         F3 = col2,
         F4 = col3,
         Fz = col4,
         FCz = col5,
         Cz = col6,
         Pz = col7,
         O1 = col8,
         O2 = col9,
         accel1 = col10,
         accel2 = col11,
         accel3 = col12,
         time_stamp = col13) %>%
  mutate(sample_index = as.numeric(sample_index),
         F3 = as.numeric(F3),
         F4 = as.numeric(F4),
         Fz = as.numeric(Fz),
         FCz = as.numeric(FCz),
         Cz = as.numeric(Cz),
         Pz = as.numeric(Pz),
         O1 = as.numeric(O1),
         O2 = as.numeric(O2),
         accel1 = as.numeric(accel1),
         accel2 = as.numeric(accel2),
         accel3 = as.numeric(accel3),
         time_stamp = str_replace_all(time_stamp, "^\\s", ""))

# select only important columns
#eeg_raw2 <- eeg_raw %>%
#  select(-c(sample_index, accel1, accel2, accel3))

# append time_stamp column from eeg_raw onto filtered_eeg
#filtered_with_time <- filtered_eeg %>%
#  bind_cols(time_stamp = eeg_raw$time_stamp)

# if number of rows don't match, try this which ignores extra rows
filtered_with_time <- filtered_eeg %>%
  bind_cols(time_stamp = slice(eeg_raw, 1:nrow(filtered_eeg))$time_stamp)


# make new column with time down to seconds accuracy only (not milliseconds)
filtered_with_time_secs <- filtered_with_time %>%
  mutate(by_the_sec = str_replace_all(time_stamp, "\\....$", ""))

# import data_labels containing timestamps and image data
data_labels <- read_csv("../data/ahk/data_labels_clean.txt") %>% 
  as_tibble() %>%
  mutate(time_stamp = str_replace_all(images, "^20170222", "")) %>%
  mutate(time_stamp = str_replace_all(time_stamp, "\\.png", "")) %>%
  mutate(hours = str_sub(time_stamp, start = 1, end = 2),
         minutes = str_sub(time_stamp, start = 3, end = 4),
         seconds = str_sub(time_stamp, start = 5, end = 6),
         milliseconds = str_sub(time_stamp, start = 7, end = 9)) %>%
  unite(time_stamp, hours, minutes, seconds, milliseconds, sep = ":") %>%
  mutate(time_stamp = str_replace_all(time_stamp, "\\:(...)$", "\\.\\1")) %>%
  mutate(by_the_sec = str_replace_all(time_stamp, "\\....$", ""))

# merge data_labels and filtered_with_time_secs
merged_tibble <- left_join(filtered_with_time_secs, data_labels, by = "by_the_sec")  %>%
  filter(!is.na(images)) %>% # keep only rows where there is an image filename
  select(-c(images, time_stamp.y)) %>%
  rename(time_stamp = time_stamp.x)

## IMPORTANT: OUTPUT
# save merged_tibble
write_csv(merged_tibble, file = "../data/eeg/filtered_eeg_labelled.csv")


# extract the relevant columns for plotting
plot_data <- merged_tibble[, c("time_stamp", "by_the_sec", "F3", "F4", "Fz", "FCz", "Cz", "Pz", "O1", "O2")] %>%
  filter(by_the_sec == "13:33:38") %>%
  mutate(F3 = F3 * 1e6,
         F4 = F4 * 1e6,
         Fz = Fz * 1e6,
         FCz = FCz * 1e6,
         Cz = Cz * 1e6,
         Pz = Pz * 1e6,
         O1 = O1 * 1e6,
         O2 = O2 * 1e6)

# convert time_stamp to POSIXct format
plot_data$time_stamp <- strptime(plot_data$time_stamp, format = "%H:%M:%OS")

# plot F3 electrode
ggplot(plot_data, aes(x = as.POSIXct(time_stamp), y = F3)) +
  geom_line() +
  xlab("Time") +
  ylab("Voltage (μV)") +
  ggtitle("EEG Waves - F3")

# plot Cz electrode
ggplot(plot_data, aes(x = as.POSIXct(time_stamp), y = Cz)) +
  geom_line() +
  xlab("Time") +
  ylab("Voltage (μV)") +
  ggtitle("EEG Waves - Cz")