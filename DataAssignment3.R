# Set working directory
setwd("~/Desktop/Coursera R Programming/Data Assignment 3/")
getwd()


# Assignment 1
outcome <- read.csv("outcome-of-care-measures.csv",
                    header = TRUE, na.strings = "Not Available")
hist(outcome[,11])


# Assignment 2
best <- function(state, outcome){
    # Available outcomes
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    # load data
    df <- read.csv("outcome-of-care-measures.csv",
                   header = TRUE, na.strings = "Not Available")
    data <- as.data.frame(df[,c(2, 7, 11, 17, 23)])
    names(data) <- c("hospital", "state", outcomes)
    # check for state and outcome
    if (!state %in% unique(data$state)) {
        return(print("Invalid state"))
    } else if (!outcome %in% outcomes) {
        return(print("Invalid outcome"))
    } else {
        # Since both checks have passed, we can
        # filter for the right state:
        filter <- data$state == state
        filtered.data <- data[filter,]
        # Find the minimum for the outcome required
        minimizer <- which.min(filtered.data[,outcome])
        result <- filtered.data[minimizer,"hospital"]
        return(result)
    }
}

# Check

best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")


# Assignment 3
rankhospital <- function(state, outcome, num = "best"){
    # Available outcomes
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    # load data
    df <- read.csv("outcome-of-care-measures.csv",
                   header = TRUE, na.strings = "Not Available")
    data <- as.data.frame(df[,c(2, 7, 11, 17, 23)])
    names(data) <- c("hospital", "state", outcomes)
    # check for state and outcome
    if (!state %in% unique(data$state)) {
        return(print("Invalid state"))
    } else if (!outcome %in% outcomes) {
        return(print("Invalid outcome"))
    } else {
        # Since both checks have passed, we can
        # filter for the right state:
        filter <- data$state == state & complete.cases(data)
        filtered.data <- data[filter,]
        # Reordering filtered.data to take the right number
        ordering <- order(filtered.data[,outcome], filtered.data$hospital)
        ordered.data <- filtered.data[ordering,]
        if(num == "best"){
            return(ordered.data[1,"hospital"])
        } else if(num == "worst"){
            return(ordered.data[nrow(ordered.data),"hospital"])
        } else {
            return(ordered.data[num,"hospital"])
        }
    }
}

# Check:

rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)


# Assignment 4
rankall <- function(outcome, num = "best"){
    # Available outcomes
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    # load data
    df <- read.csv("outcome-of-care-measures.csv",
                   header = TRUE, na.strings = "Not Available")
    data <- as.data.frame(df[,c(2, 7, 11, 17, 23)])
    names(data) <- c("hospital", "state", outcomes)
    # check for outcome
    if (!outcome %in% outcomes) {
        return(print("Invalid outcome"))
    } else {
        # Since the outcome is valid, we can now start ranking
        # we can now select all states and loop to rank all states
        states <- sort(unique(data$state))
        # Initialising the output data frame
        out.data <- data.frame()
        # Run a loop over the states
        for(st in states){
            # Filter the data frame by state
            filter <- data$state == st
            filtered.data <- data[filter,]
            # When num = "worse" rank from worse to best
            if(num == "worst"){
                ordering <- order(filtered.data[,outcome], filtered.data$hospital, decreasing = TRUE)
                ordered.data <- filtered.data[ordering,]
                out.data <- rbind(out.data, ordered.data[1,c("hospital", "state")])
            } else {
                # Otherwise, rank from best to worse, "best" = 1
                if(num == "best") num <- 1
                ordering <- order(filtered.data[,outcome], filtered.data$hospital)
                ordered.data <- filtered.data[ordering,]
                out.data <- rbind(out.data, ordered.data[num,c("hospital", "state")])
            }
        }
    }
    return(out.data)
}


# Check:

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
