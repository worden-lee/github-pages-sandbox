data.xlsx: download.mk
	wget -O $@ "http://data.hdx.rwlabs.org/storage/f/2014-10-28T12%3A23%3A19.044Z/data-ebola-public.xlsx"
	touch $@
