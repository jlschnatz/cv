#!/bin/bash

R -e 'source("R/skill_chart.R")'
R -e 'pagedown::chrome_print("index.Rmd")'

