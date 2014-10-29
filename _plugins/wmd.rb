module Jekyll
	class WMDGenerator < Jekyll::Generator
		safe true
		priority :low
		
		def initialize(config)
			config['convert_wmd'] ||= true
		end

		def generate(site)
			@site = site
			site.posts.each do |post|
				if post.name.match(/\.wmd$/)
					convertWmd post
				end
			end
		end

		def convertWmd(post)
			post.content = "WMD Converted Content [link here](http://google.com)\n\n" + post.content
			puts "name is #{post.name}"
			post.name.gsub!(/\.wmd$/, '')
			post.name.gsub!(/\.markdown/, '.foo.markdown')
			puts "name becomes #{post.name}"
			puts "slug is #{post.slug}"
			post.slug.gsub!(/\.wmd$/, '')
			post.slug.gsub!(/\.markdown/, '.foo')
			puts "slug becomes #{post.slug}"
			puts "ext is #{post.ext}"
			post.ext = '.markdown'
		end
	end
end
