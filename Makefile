# gitroot
### Hooks for the editor to set the default target

current: target
-include target.mk

##################################################################

vim_session:
	bash -cl "vi Makefile screen.mk"

######################################################################

## Screen config

## Main
screen_session: gitroot.vscreen Lab_meeting.vscreen dushoff.github.io.vscreen notebook.vscreen mac-theobio.github.io.vscreen

gitroot: dir=../
gitroot: ; $(linkdir)

%.sd:
	cd $* && screen -t $*

######################################################################

## Resting and activating

## This is insanity; it's making shit just to rest it

rest = 708 stuff aphrc
rest: $(rest:%=resting/%)
resting/%:
	$(MAKE) resting
	$(MAKE) $*.all
	$(MV) $* $@

resting:
	$(mkdir)

######################################################################

## Needed (currently) to clone from repo lists
clonecommand = justclone

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

## things with special names
repodirs += labPages
labPages:
	git clone https://github.com/mac-theobio/mac-theobio.github.io.git $@

######################################################################

## New repo
#### add to friends.def or dushoff_repos.def (linked to makestuff)
#### make <dirname.setup>
#### (default is a cloned makestuff… requires thought)

## make speedstrength.setup ##

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

## This is a pain. I need to reinvent hierarchy, too
alldirs += makestuff
alldirs +=  $(wildcard $(repodirs))

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

