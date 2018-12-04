### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

## Defs

Sources += Makefile

msrepo = https://github.com/dushoff
ms = makestuff

Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git submodule add -b master $(msrepo)/$(ms)

$(ms)/%.mk: $(ms) $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i

-include $(ms)/os.mk
# -include $(ms)/perl.def

######################################################################

## Content

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

