# gitroot!
### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

# stuff

Sources += Makefile .ignore

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

Sources += $(ms)
Makefile: $(ms)
$(ms):
	git submodule add -b master https://github.com/dushoff/$@.git

$(ms)/%.mk: $(ms)/Makefile ;

$(ms)/Makefile:
	git submodule init $(ms) 
	git submodule update $(ms) 
	touch $@

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

