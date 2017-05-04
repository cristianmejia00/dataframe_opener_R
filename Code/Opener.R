# 20161001
# Read files in R

# Depending the source of the file some issues may raise when reading it.
# This file summarizes the reading process that successfully read files depending
# such sources.
# This code was done in Windows 10, R version 3.3.1

library(data.table)

##################################################################
# WEB OF SCIENCE (Tab delimited, UTF8, windows)
##################################################################
# .txt from Web of Science 
data <- read.table(file.choose(), header=T, sep="\t", fill= T, quote ="", 
                   row.names = NULL, stringsAsFactors = F, check.names=F)
colnames(data) <- c("PT", colnames(data)[3:length(colnames(data))], "END")
data["END"] <- NULL


##################################################################
# THOMSON INNOVATION
##################################################################
# .csv downloaded from Thomson innovation (Safer but slower than FREAD)
data <- read.csv(file.choose(), skip=1, header=TRUE, check.names = FALSE, stringsAsFactors = FALSE)

# Column displacement correction
first_column <- row.names(data)
data2 = cbind(first_column, data)
data2$first_column = as.character(data2$first_column)
names(data2) = c(names(data), "final_column" )
data <- data2
data <- data[,-56]
data <- unique(data)

# Notes:
# Encoding problem raises when Thomson Innovation interface is in Japanese, using English interface is advised.
# Always check headers, and adjust "skip" when needed (skip = 1; is the default)

##################################################################
# FUKAN SYSTEM
##################################################################
# Read the result files from Fukan System (tsv files)
orphans <- fread(file.choose(), header = TRUE, stringsAsFactors = FALSE, quote = "")

##################################################################
# ANY OTHER .CSV FILE
##################################################################
# OPTION 1 
challenge <- fread(file.choose(), header = TRUE, stringsAsFactors = FALSE, quote = '')

# OPTION 2
edges <- read.csv(file.choose(), header = TRUE, check.names = FALSE, stringsAsFactors = FALSE)

##################################################################
# ANY OTHER .tsv (.txt) FILE
##################################################################
edges <- read.csv(file.choose(), header = TRUE, sep = "\t", check.names = FALSE, stringsAsFactors = FALSE)

##################################################################
# CHECK HEADER and choose folder to save the file again
##################################################################
names(data)
setwd(choose.dir())

#################################################################
# To Fukan System again
#################################################################
# When we change the dataset and want to upload again to the fukan system for analysis
write.table(data_FO2, 
            file="funded_robotics.tsv", 
            row.names = FALSE, 
            sep = "\t", 
            quote = FALSE)
getwd()


