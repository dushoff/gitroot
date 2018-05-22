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

######################################################################

## Should clones start with makestuff.sub or makestuff.clone?
clonecommand = subclone
clonecommand = cloneclone
clone: $(clonecommand)

setclone:
	git clone $(repo)$(user)/$(target).git
	$(MAKE) $(target)/Makefile
	$(MAKE) $(target)/target.mk
	cd  $(target) && $(MAKE) Makefile

subclone:
	$(MAKE) setclone
	cd  $(target) && $(MAKE) makestuff.sub
	make $(target).push

cloneclone:
	$(MAKE) setclone
	make $(target).push

### Remember to change the Source/Ignore
### A perl script could do this for you!
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

Ignore += $(dushoff_github)
creation:
recreation:
	cd creation && git clean -f -fd
	cd creation && git rm -rf Makefile *.* && git push -u origin
	-$(RMR) creation
	$(MAKE) creation

now:
	@echo $(wildcard $(dushoff_github))

######################################################################

Ignore += $(repodirs)
clonedirs +=  $(wildcard $(repodirs))

######################################################################

### Makestuff

Sources += sites.mk dushoff_repos.mk
-include sites.mk
-include dushoff_repos.mk

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

