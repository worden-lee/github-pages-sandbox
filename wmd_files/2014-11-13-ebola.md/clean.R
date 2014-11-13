class(data$Date)
data <- within(data, {
	Date <- as.Date(Date, format="%Y-%m-%d")
	Value <- as.numeric(as.character(Value))
})

national <- subset(data, Localite=="National")

print(summary(data))
