def pipe_text_through( text, command )
	open('|'+command, 'w+') do |subprocess|
		subprocess.write( text )
		subprocess.close_write
		return subprocess.read
	end
end

module Jekyll
	class WMDGenerator < Jekyll::Generator
		safe true
		priority :low
		@project_lookup = Hash.new
		
		def self.record_project( title, value )
			@project_lookup[title] = value
		end

		def self.lookup_project( title )
			@project_lookup[title]
		end

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
			post.name.gsub!(/\.wmd$/, '')
			WMDGenerator.record_project(post.title, post.name)
			post.slug.gsub!(/\.wmd$/, '')
			post.ext = post.slug.match(/\..*?$/)[0]
			post.slug.gsub!(/\..*?$/, '')
			puts "Calling wmd.php --pre on #{post.slug}"
			post.content = pipe_text_through( post.content, "php /usr/local/src/workingwiki/wmd/wmd.php --pre --default-project-name=#{post.name} --cache-dir=/usr/local/src/jekyll-test/github-pages-sandbox/wmd_files --process-inline-math" )
		end
	end

	module WMDFilter
		def wmd_postprocess(text)
			if ! text.match(/UNIQ/)
				return text
			end
			title = @context.registers[:page]['title']
			name = WMDGenerator.lookup_project(title)
			puts "Calling wmd.php --post on #{name}"
			baseurl = @context.registers[:site].baseurl
			text = pipe_text_through( text, "php /usr/local/src/workingwiki/wmd/wmd.php --post --default-project-name=#{name} --cache-dir=/usr/local/src/jekyll-test/github-pages-sandbox/wmd_files --project-file-base-url=#{baseurl}/wmd_files" )
			if Dir.exists?( "wmd_files/#{name}" )
				@context.registers[:site].read_directories( "wmd_files/#{name}" )
			end
			return text
		end
	end
end

Liquid::Template.register_filter(Jekyll::WMDFilter)
