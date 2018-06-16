# gitroot!
### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

# Content

######################################################################

# stuff

Sources += Makefile .ignore

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

Sources += $(ms)
Makefile: $(ms) $(ms)/Makefile
$(ms):
	git submodule add -b master https://github.com/dushoff/$@.git

$(ms)/%.mk: $(ms)/Makefile ;
$(ms)/Makefile: 
	git submodule update -i

######################################################################

## Repo lists
## Work on refactoring (there should be code to sub, and the lists should be cleaner)

Ignore += dushoff_repos.mk friends.mk sites.mk
Makefile: dushoff_repos.mk friends.mk sites.mk
dushoff_repos.mk friends.mk sites.mk:
	$(LNF) makestuff/repos/$@ .

######################################################################

## Should clones start with makestuff.sub or makestuff.clone?
clonecommand = subclone
clonecommand = justclone
clone: $(clonecommand)

######################################################################

justclone:
	git clone $(repo)$(user)/$(target).git

%.setup:
	$(MAKE) $*
	$(MAKE) $*/Makefile
	$(MAKE) $*/target.mk

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

Sources += clone.mk sub.mk

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

clonelist:
	@echo $(clonedirs)

######################################################################

### Makestuff

-include $(ms)/repos/sites.mk
-include $(ms)/repos/dushoff_repos.mk
-include $(ms)/repos/friends.mk

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk

