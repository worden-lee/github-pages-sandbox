module Jekyll
	class WMDConverter < Converter
		safe true
		priority :low
		
		def matches(ext)
			@ext1 = ext
			ext =~ /.wmd$/i
		end

		def output_ext(ext)
			@ext2 = ext
			#ext.sub( /\.wmd$/i, '.html' )
			''
		end

		def convert(content)
			puts "ruby debug statement #{@ext1} #{@ext2}\n"
			'WMD Converted Content [link here](http://google.com)'
		end
	end
end
