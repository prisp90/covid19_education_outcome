## Data Sources

For this project we will be using as a starting point the [Google COVID-19 Open Data](https://health.google.com/covid-19/open-data/) repository.  It is far too big to put in the repo. The zsn/bash scripts are setup to download the core data files and do some munging.  The r-scripts are for converting the raw CSV files into well formatted objects for R.

To build the raw underlying data files that are not commited to git (i.e. all the ones that are too big or have some preprocessing) run the build data script in the code directory.  There are 3 files, the `build_data.sh` file calls the other two.  The first, `build_raw_google_data.sh` pulls down the big aggregate data file from Google and strips it down to US only rows.  The second file, `build_full_data_set.R` imports all of the various tables and turns them into a series of CSV files that can be used for analytics.
 
TODO(GPOTTER): Make a `build_all.sh` script that runs both the zsh script and the R script and then deletes the big raw google file. 

### Links to sources
[Google COVID-19 Open Data Aggregated](https://storage.googleapis.com/covid19-open-data/v3/aggregated.csv.gz)
[The Nation's Report Card](https://www.nationsreportcard.gov/ndecore/xplore/NDE)

### Documentation for The Nation's Report Card

## Directory Structure
```
.
├── california (Data files for California's CAASP Testing)
└── neas (Data files from the federal government's National Report Card)
```

## File Definitions
* The excel files were downloaded June 26, 2023 from the NAEP website.  The 8 data files represent 2019 & 2022 for 4th/8th in Math and Writing.
1. [google_data_full_w_scores](../Data/google_data_full_w_scores.csv) contains all of the rows from the google_data_us_aggregated.csv file and state level scores.
2. [google_data_cleaned_full_w_scores](../Data/google_data_cleaned_full_w_scores) is the same as above, but with all states dropped that are not covered by the NAEP scores.
3. [google_data_state_level_w_scores](../Data/google_data_state_level_w_scores.csv) contains only rows from the google data where aggregation level == 1.  This pulls ~900 rows per state, aggregated at the state level, i.e. one row per state per day.  This roll-up was done by google and leaves out the US total roll-up and drops all the county level rows.
4. [google_data_cleaned_state_level_w_scores](../Data/google_data_cleaned_state_level_w_scores.csv) is the same file as above, but with all states not covered by the NAEP tests (Washington DC, Guam, etc.).

