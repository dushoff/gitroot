# gitroot
### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

# default (gitroot) screen

screen_session: Planning.screen linux_config.screen Lab_meeting.screen dushoff.github.io.screen notebook.screen mac-theobio.github.io.screen

Planning.screen: Planning
	cd $< && screen -t "$<" bash -cl "nvim" ##

%.screen: %
	cd $< && screen -t "$<" bash -cl "vmt" ##

######################################################################

## Config for here 

vim_session: 
	bash -cl "vi Makefile dushoff_repos.def friends.def"

# other screens

Sources += screen.mk
include screen.mk

%.sd:
	cd $* && screen -t $*

######################################################################

# stuff

Sources += Makefile README.md

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

## New repo
#### add to friends.def or dushoff_repos.def (linked to makestuff)
#### make <dirname.setup>
#### (default is a cloned makestuff… requires thought)

## make branches.setup ##

## Current setup makes something with a cloned makestuff (already)
## Good for containers, etc. 
# talks.setup
%.setup:
	$(MAKE) $*
	$(MAKE) $*/Makefile

## This is meant to override the clone setup
%.sub: %
	cd $* && $(MAKE) makestuff.sub

## start.mk is what we're using. Other startmks deleted 2018 Oct 25 (Thu)
## git rm substart.mk subdir.mk ##
Sources += start.mk
Sources += clone.mk sub.mk up.mk
%/Makefile:
	echo "# $*" > $@
	cat clone.mk >> $@
	cd $* && $(MAKE) Makefile && $(MAKE) target.mk

## Makefiles for repos?

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

