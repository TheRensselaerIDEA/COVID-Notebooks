

# Import p values for states
states.all_p <- readRDS("StateSummaries/ALL_P.rds")

# Import c values for states
states.all_c <- readRDS("StateSummaries/ALL_C.rds")

# Import p values for states
states.all_merged <- readRDS("StateSummaries/ALL_merged.rds")

# Import model input data
model_input <- readRDS('Preprocessing_FTS_Outputs/06-28-2020data.Rds')

# Import national model summary
national <- readRDS('Modules/combined.summary.July8.Rds')

statenames = c("WY", "WV", "WI", "WA", "VT", "VA", "UT", "TX", "TN", "SD", "SC", "PA", "OR", "OK", "OH", "NY", "NV", "NM", "NJ", "NH", 
           "NE", "ND", "NC", "MT", "MS", "MO", "MN", "MI", "ME", "MD", "MA", "LA", "KY", "KS", "IN", "IL", "ID", "IA", "GA", "FL",
           "DE", "CT", "CO", "CA", "AZ", "AR", "AL")

for (state in statenames) {
  fname <- paste("./StateSummaries/",state,".summary.rda",sep="")
  load(fname)
 # model_output <- eval(as.name(b))
#  model_output
}

# adjusted p vals
states.adjusted_p <- readRDS("AdjustedStateSummaries/ALL_P.rds")


states.adjusted_c <- readRDS("AdjustedStateSummaries/ALL_C.rds")

