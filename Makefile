# gitroot
### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

# screen

screen_session: Planning.screen Lab_meeting.screen

Planning.screen: Planning
	- cd $< && $(MAKE) sync
	cd $< && screen -t "$<" bash -cl "nvim" ##

%.screen: %
	cd $< && screen -t "$<" bash -cl "vmt" ##

######################################################################

# stuff

Sources += Makefile

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

## These are links because we like editing them here, but want to save to makestuff
repolinks += dushoff_repos.mk friends.mk sites.mk
repolinks += dushoff_repos.def friends.def
Ignore += $(repolinks)
Makefile: $(repolinks)
$(repolinks):
	$(LNF) makestuff/repos/$@ .

## Repos that aren't ready for all.time yet
Ignore += dev

######################################################################

## Developing now in talks/
## Should have clonedirs use justclone, and mdirs (bad name?) use subclone (bad name, and does not exist) … investigate

## No idea what this is or whether I am using it.
## Should clones start with makestuff.sub or makestuff.clone?
## This is terrible; should move to git.mk as clone: and module:
## or as clone= and module=
clonecommand = justclone

######################################################################

## things with special names
repodirs += labPages
labPages:
	git clone https://github.com/mac-theobio/mac-theobio.github.io.git $@

######################################################################

## Current setup makes something with a cloned makestuff (already)
## Good for containers, etc. 
# talks.setup
%.setup:
	$(MAKE) $*
	$(MAKE) $*/Makefile
	$(MAKE) $*/target.mk

## This is meant to override the clone setup
%.sub: %
	cd $* && $(MAKE) makestuff.sub

## start.mk is what we're using. Other startmks deleted 2018 Oct 25 (Thu)
## git rm substart.mk subdir.mk ##
Sources += start.mk
%/Makefile:
	echo "# $*" > $@
	cat start.mk >> $@
	cd $* && $(MAKE) Makefile

Sources += clone.mk sub.mk

######################################################################

### development

creation:
recreation:
	cd creation && git clean -f -fd
	cd creation && git rm -rf Makefile *.* && git push -u origin
	-$(RMR) creation
	$(MAKE) creation

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

