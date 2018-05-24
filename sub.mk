
Sources += Makefile .ignore 
Ignore += .gitignore

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

# -include $(ms)/perl.def

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git submodule -b master $(msrepo)/$(ms)

## Only meant to work with makestuff.sub
$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i
