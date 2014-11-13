library(gdata)

data <- read.xls(xls=input_files[[1]], sheet=2)
print(summary(data))
