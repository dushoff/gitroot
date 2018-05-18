
## See makestuff/repos.def ## makestuff/repos.mk

###################
## dushoff_github

## This is meant to be actually destroyed!!
dushoff_github += creation

## Not sure how to use this one
dushoff_github += Sandbox

$(dushoff_github):
	$(MAKE) target=$@ repo=$(github) user=dushoff clone
