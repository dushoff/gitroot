### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

## Defs

Sources += Makefile

######################################################################

## Retrofit

ms = makestuff
Sources += $(ms)
Makefile: $(ms)/Makefile

$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile:
	git submodule update -i

-include $(ms)/os.mk
# -include $(ms)/perl.def

######################################################################

## This ¶ can be deleted once makestuff is set up
msrepo = https://github.com/dushoff
$(ms)/Makefile: $(ms)
$(ms):
	git submodule add -b master $(msrepo)/$(ms)

######################################################################

## Content

######################################################################

### Makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

