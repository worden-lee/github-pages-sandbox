WW_DIR = /usr/local/src/workingwiki

WW_CSS_TO_USE = $(patsubst %,$(WW_DIR)/resources/%,ext.workingwiki.latexml.css ext.workingwiki.latexml.customization.css)

css/auto-generated-from-ww.css : $(WW_CSS_TO_USE)
	cat $(WW_CSS_TO_USE) > $@
