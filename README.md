Research topic: "Using Combined RSP and HSRL-2 Measurements to Estimate Cloud Droplet Number Concentration"

This repository includes sample work from working as a Research Intern at NASA's Goddard Institute for Space Studies during Summer 2020.

File summary:

F20200227_2260.m - Analyzes a given flight (Februrary 27th, 2020) for a specific bandwidth (2260nm). Includes: reading files in, cleaning misformatted values, creating subplots (optical thickness, effective radius, effective variances, water vapor, cloud top height, cloud top temperature, extinction, extinction cross-section, droplet concentration), as well as scatterplots comparing combined method values and MODIS values (using 2260nm band) for water droplet concentration.

Nd_Intern_Presentation_Final.pdf - PDF of my final presentation for the summer. Includes: 1. Droplet Concentration Review 2. Methods Overview 3. Instruments 4. ACTIVATE Campaign 5. Results 6. Discussion & Conclusions 7. Future Work.

Quicklooks.m - brief plotting script to get an overview sense (a "quick look") of the water droplet statistics for a given section of a flight for NASA King Air B200 flights

falcon_quicklooks_v2.m - similar to the above quicklooks file, but for NASA HU-25 Falcon flights

longmaster.m - reads in all required variables for a given flight/file, cleans misformatted values, downloads HSLR and RSP data, combines data for both HSLR and RSP for all dates of interest 
