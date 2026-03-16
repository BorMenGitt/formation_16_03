system("mc cp s3/projet-formation/diffusion/bonnes-pratiques/data/RPindividus_24.csv RPindividus_24.csv")

rm(list = ls())
# setwd("/home/onyxia/formation-bonnes-pratiques-R")

if (!require('ggplot2')) install.packages('ggplot2')
if (!require('stringr')) install.packages('stringr')
if (!require('dplyr')) install.packages('dplyr')
if (!require('tidyverse')) install.packages('tidyverse')

install.packages('lintr')
install.packages('styler')
getwd()
library(tidyverse)
library(ggplot2)
library(stringr)
library(dplyr)
library(lintr)
library(styler)

lintr::use_lintr(type="tidyverse")
lintr::lint("scripts/script_1.R")

styler::style_file("scripts/script_1.R")

MASS::polr
