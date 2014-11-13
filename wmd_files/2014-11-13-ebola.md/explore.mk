read.Rout: data.xlsx read.R
	$(run-R)

clean.Rout: read.Rout clean.R
	$(run-R)

plot.Rout: clean.Rout plot.R
	$(run-R)

