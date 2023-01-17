## Third Programming Assignment

The file "DataAssignment.R" contains the work of the third assignment made by A. Carpignani for the course in **R Programming** by **Coursera**. 

### Instructions

Download the file `ProgAssignment3-data.zip` file containing the data for Programming Assignment 3 from the Coursera website. Unzip the file in a directory that will serve as your working directory. When you start up R make sure to change your working directory to the directory where you unzipped the data.

The data for this assignment come from the Hospital Compare web site (<http://hospitalcompare.hhs.gov>) run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset es- sentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining whether hospitals should be fined for not providing high quality care to patients (see <http://goo.gl/jAXFX> for some background on this particular topic).

The Hospital Compare web site contains a lot of data and we will only look at a small subset for this assignment. The zip file for this assignment contains three files

- `outcome-of-care-measures.csv`: Contains information about 30-day mortality and readmission rates for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.  

- `hospital-data.csv`: Contains information about each hospital.  

- `Hospital_Revised_Flatfiles.pdf`: Descriptions of the variables in each file (i.e the code book).  

A description of the variables in each of the files is in the included PDF file named `Hospital_Revised_Flatfiles.pdf`. This document contains information about many other files that are not included with this programming assignment. You will want to focus on the variables for Number 19 (`outcome-of-care-measures.csv`) and Number 11 (`hospital-data.csv`). You may find it useful to print out this document (at least the pages for
Tables 19 and 11) to have next to you while you work on this assignment. In particular, the numbers of the variables for each table indicate column indices in each table (i.e. “Hospital Name” is column 2 in the `outcome-of-care-measures.csv` file).

### Plot the 30-dat mortality rates for hear attack

Read the outcome data into R via the `read.csv` function and look at the first few rows.

```{r}
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
```

There are many columns in this dataset. You can see how many by typing `ncol(outcome)` (you can see the number of rows with the nrow function). In addition, you can see the names of each column by typing names(outcome) (the names are also in the PDF document.

To make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset), run

```{r}
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])
```

Because we originally read the data in as character (by specifying `colClasses = "character"` we need to coerce the column to be numeric. You may get a warning about NAs being introduced but that is okay.

### Finding the best hospital in a state

Write a function called best that take two arguments: the 2-character abbreviated name of a state and an outcome name. The function reads the `outcome-of-care-measures.csv` file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in that state. The hospital name is the name provided in the `Hospital.Name` variable. The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular outcome should be excluded from the set of hospitals when deciding the rankings.

**Handling ties.** If there is a tie for the best hospital for a given outcome, then the hospital names should be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”, and “f” are tied for best, then hospital “b” should be returned).

The function should use the following template.

```{r}
best <- function(state, outcome) {
        ## Read outcome data

		## Check that state and outcome are valid

		## Return hospital name in that state with lowest 30-day death
		
		## rate
}
```

The function should check the validity of its arguments. If an invalid `state` value is passed to `best`, the function should throw an error via the `stop` function with the exact message “invalid state”. If an invalid outcome value is passed to best, the function should throw an error via the stop function with the exact message “invalid outcome”.

Here is some sample output from the function.

```{r}
> source("best.R")
> best("TX", "heart attack")
[1] "CYPRESS FAIRBANKS MEDICAL CENTER"

> best("TX", "heart failure")
[1] "FORT DUNCAN MEDICAL CENTER"

> best("MD", "heart attack")
[1] "JOHNS HOPKINS HOSPITAL, THE"

> best("MD", "pneumonia")
[1] "GREATER BALTIMORE MEDICAL CENTER"

> best("BB", "heart attack")
Error in best("BB", "heart attack") : invalid state

> best("NY", "hert attack")
Error in best("NY", "hert attack") : invalid outcome
```

Save your code for this function to a file named `best.R`.
