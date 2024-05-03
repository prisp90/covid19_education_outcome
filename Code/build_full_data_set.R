################################################################################
# R Script to perform initial data munging
#
#

if (!require(data.table)) install.packages("data.table")
if (!require(stringr)) install.packages("stringr")
if (!require(magrittr)) install.packages("magrittr")


# Read in the exported excel -> csv files and sort the table by state name(state)
reading_4_2022 <- fread("../Data/naep/reading_4_2022.csv") %>% setkey(state)
reading_4_2019 <- fread("../Data/naep/reading_4_2019.csv") %>% setkey(state)
reading_8_2022 <- fread("../Data/naep/reading_8_2022.csv") %>% setkey(state)
reading_8_2019 <- fread("../Data/naep/reading_8_2019.csv") %>% setkey(state)
math_4_2022 <- fread("../Data/naep/math_4_2022.csv") %>% setkey(state)
math_4_2019 <- fread("../Data/naep/math_4_2019.csv") %>% setkey(state)
math_8_2022 <- fread("../Data/naep/math_8_2022.csv") %>% setkey(state)
math_8_2019 <- fread("../Data/naep/math_8_2019.csv") %>% setkey(state)

# Build single table of all scores, that's why we sorted
full_scores <- cbind(reading_4_2022, reading_4_2019[, 2], reading_8_2022[, 2]
                     , reading_8_2019[, 2], math_4_2022[, 2], math_4_2019[, 2]
                     , math_8_2022[, 2], math_8_2019[,2]) %>% setkey(state)

# Read in the google covid-19
google_data <- fread("../Data/google_data_us_aggregated.csv")

# Add state abbreviation and set it as the key for this table
google_data[, state.abb:=substr(location_key, 4, 5)] %>% setkey(state.abb)

# Build State Mapping
state_mapping <- as.data.table(cbind(state.name, state.abb))
colnames(state_mapping) <- c("state", "state.abb")

# Replace spaces in names with underscores
state_mapping[, state := str_replace(state, " ", "_")]
setkey(state_mapping, state)

# Merge state.abb into full_scores and drop all rows that are NA for abbrv
# rename state to state_name and state.abb to state, set key to state for future
# join to full google data
full_scores <- state_mapping[full_scores][!is.na(state.abb), ][, state_name := state][,
  state := state.abb] %>% setkey(state)
# TODO(GPOTTER): Drop the state.abb column

# Add the state level scores to the google data
google_data <- full_scores[google_data]
setkey(google_data, state_name, aggregation_level)

# Write separate files for different levels of analysis
fwrite(google_data, "../Data/google_data_full_w_scores.csv")
fwrite(google_data[aggregation_level == 1, ], "../Data/google_data_state_level_w_scores.csv")
fwrite(google_data[!is.na(state_name), ], "../Data/google_data_cleaned_full_w_scores.csv")
fwrite(google_data[!is.na(state_name) & aggregation_level == 1, ], "../Data/google_data_cleaned_state_level_w_scores.csv")
fwrite(full_scores, "../Data/response_data.csv")
