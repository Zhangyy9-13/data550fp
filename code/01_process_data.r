here::i_am(
  "code/01_process_data.R"
)

library(here)
library(dplyr)

raw_data <- read.csv(here("data", "raw_data.csv"), stringsAsFactors = FALSE)

derived_data <- raw_data %>%
  filter(grepl("subjective cognitive decline", Question, ignore.case = TRUE)) %>%
  mutate(Question_short = case_when(
    grepl("interferes with their ability", Question) ~ "Interferes w/ daily life",
    grepl("need assistance", Question) ~ "Needs assistance",
    grepl("talking with a health care professional", Question) ~ "Talked to doctor",
    grepl("happening more often", Question) ~ "Worsening symptoms",
    TRUE ~ Question
  ), Year = YearStart)

saveRDS(
  derived_data,
  file = here::here("output", "derived_data.rds")
)

trend_data <- derived_data %>%
  group_by(Year, Question_short) %>%
  summarise(Avg_Percentage = mean(Data_Value, na.rm = TRUE), .groups = "drop")

saveRDS(
  trend_data,
  file = here::here("output", "trend_data.rds")
)