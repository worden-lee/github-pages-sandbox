# LW rules to run the wmd processor to make HTML blog posts from
# .wmd blog post source
WW_DIR = /usr/local/src/workingwiki

_posts/%.html : _posts_wmd/%.html.wmd $(WW_DIR)/wmd/wmd.php
	php $(WW_DIR)/wmd/wmd.php --pre --process-inline-math --project-directory=wmd_files/$* $< $@
	php $(WW_DIR)/wmd/wmd.php --post --project-directory=wmd_files/$* $< $@
