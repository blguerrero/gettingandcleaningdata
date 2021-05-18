#Getting and Cleaning Data
#Week 1
#swirl exercise
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()
#In this lesson, you'll learn how to manipulate data using dplyr
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
#remember to always load the dplyr package
library(dplyr)
packageVersion("dplyr")
#The first step of working with data in dplyr is to load the data into what the package authors 
#call a 'data frame tbl' or 'tbl_df
cran <- tbl_df(mydf)
#to remove the original data from your workspace
rm("mydf")
cran
#The dplyr philosophy is to have small functions that each do one thing well." 
#Specifically, dplyr supplies five 'verbs' that cover most fundamental data manipulation 
#tasks: select(), filter(), arrange(), mutate(), and summarize()
?select
#select only the ip_id, package, and country variables from the cran dataset
select(cran, ip_id, package, country)
5:20
#select() allows you to specify a sequence of columns this way, which can save a bunch of typing
select(cran, r_arch:country)
select(cran, country:r_arch)
cran
#we can also specify the columns we want to throw away
select(cran, -time)
-(5:20)
select(cran, -(X:size))
#to select all rows for which the package variable is equal to "swirl"
filter(cran, package == "swirl")
#The == operator asks whether the thing on the left is equal to the thing on the right. If yes, then it returns TRUE
#filter() then returns only the rows of cran corresponding to the TRUEs
#return all rows of cran corresponding to downloads from users in the US running R version 3.1.1
filter(cran,r_version == "3.1.1", country == "US")
?Comparison
filter(cran,r_version <= "3.0.2", country == "IN")
#gives us all rows for which the country variable equals either "US" or "IN"
filter(cran, country == "US" | country == "IN")
filter(cran, size > 100500, r_os == "linux-gnu")
filter(cran, is.na(r_version))
is.na(c(3, 5, NA, 10))
!is.na(c(3, 5, NA, 10))
#Use filter() to return all rows of cran for which r_version is NOT NA
filter(cran, !is.na(r_version))
#arrange() orders the rows of a dataset according to the values of a particular variable
cran2 <- select(cran, size:ip_id)
#to order the ROWS of cran2 so that ip_id is in ascending order (from small to large)
arrange(cran2, ip_id)
#order in descending order
arrange(cran2, desc(ip_id))
#arrange by packaged names alphabetically
arrange(cran2, package, ip_id)
#means that if there are multiple rows with the same value for package, they will be sorted by ip_id
#Arrange cran2 by the following three variables, in this order: country (ascending), r_version
#(descending), and ip_id (ascending).
arrange(cran2, country, desc(r_version), ip_id)
cran3 <- select(cran, ip_id, package, size)
cran3
#mutate() to create a new variable based on the value of one or more variables already in a dataset
#add a column called size_mb that contains the download size in megabytes
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
#All of the values in cran3 are 1000 bytes less than they should be. Using cran3, create just one new column called correct_size that contains the correct size
mutate(cran3, correct_size = size + 1000)
summarize(cran, avg_bytes = mean(size))
#summarize() is most useful when working with data that has been grouped by the values of a particular variable