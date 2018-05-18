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

clone:
	git clone $(repo)$(user)/$(target).git
	$(MAKE) $(target)/Makefile
	$(MAKE) $(target)/target.mk
	cd  $(target) && $(MAKE) push

### Remember to change the Source/Ignore
%.sub: %
	cd $* && $(MAKE) makestuff.sub

%.clone: %
	cd $* && $(MAKE) makestuff.clone


Sources += start.mk
%/Makefile:
	echo "# $*" > $@
	cat start.mk >> $@
	cd $* && $(MAKE) Makefile

######################################################################

### development

Ignore += $(dushoff_repos)
creation:
recreation:
	cd creation && git clean -fd && git clean -fX
	git rm -rf * && git push -u origin
	-$(RMR) creation
	$(MAKE) creation

######################################################################

### Makestuff

Sources += sites.mk dushoff_repos.mk
-include sites.mk
-include dushoff_repos.mk

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

