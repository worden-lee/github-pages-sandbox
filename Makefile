# LW rules to run the wmd processor to make HTML blog posts from
# .wmd blog post source
WW_DIR = /usr/local/src/workingwiki

_posts/% : _posts_wmd/%.wmd $(WW_DIR)/wmd/wmd.php
	php $(WW_DIR)/wmd/wmd.php --pre --process-inline-math --project-directory=wmd_files/$* $< $@
	php $(WW_DIR)/wmd/wmd.php --post --project-directory=wmd_files/$* $< $@

WW_CSS_TO_USE = $(patsubst %,$(WW_DIR)/resources/%,ext.workingwiki.latexml.css ext.workingwiki.latexml.customization.css)
css/auto-generated-from-ww.css : $(WW_CSS_TO_USE)
	cat $(WW_CSS_TO_USE) > $@
