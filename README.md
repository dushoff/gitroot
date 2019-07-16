## sink/mat 

These are meant to update everything I might have been working on.

They should be kept clean and not loopy

That probably means I should put a lot of stuff into a "resting" directory"

Branches are under sink/mat -- they should probably have their own resting directory

## setup

A directory that lives directly under gitroot should be on the sink pathway and have its own Makefile with all.time

These are currently listed in 
* dushoff_repos.def@
* friends.def@

It's not obviously good for these to be separate files

It's also not obvious when we want a directory to have a makestuff clone vs. subdirectory: the clone is more of a pain, but leads to better reproducibility. makestuff has been pretty good for back-compatibility, though.

If we have non-makey collaborators, we're probably better with clones. 
TODO: Try linking before cloning.

We're supposed to do:
* `make <dirname>.setup`, _or_
* `make <dirname>.sub` [maybe following? is this even current?]
	* Note: .setup already makes makestuff, is that a conflict?

## Subdir setup
* Copy ~/gitroot/up.mk to link to makestuff
	* This file is identical to makestuff/subdir.mk. Which one is better?
	* Keep up.mk because it reflects the function better. What about location?


