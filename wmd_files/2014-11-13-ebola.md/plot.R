library(ggplot2)
theme_set(theme_bw())

print(
	ggplot(national, aes(x=Date, y=Value))
	+ geom_line(aes(color=Country, shape=Category))
	+ geom_point(aes(color=Country, shape=Category))
)
