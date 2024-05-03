#!/bin/zsh
#
# This script downloads the raw data files and does some initial munging

# First we need to Download the data from Google Health
echo "********** DOWNLOAD FULL AGGREGATED DATA FILE FROM GOOGLE **********"
curl https://storage.googleapis.com/covid19-open-data/v3/aggregated.csv.gz -o aggregated.csv.gz

# Unzip the file
echo "********** UNZIPPING FULL DATA FILE **********"
gunzip ./aggregated.csv.gz

# create skeleton of US only data file with the proper header
echo "********** CREATE US ONLY DATA FILE **********"
head -1 ./aggregated.csv > google_data_us_aggregated.csv

# Add only those rows that start with US
grep ^US ./aggregated.csv >> ../Data/google_data_us_aggregated.csv

# Delete the full data file
rm ./aggregated.csv

echo "********** COMPLETED GOOGLE DATA BUILD **********"




