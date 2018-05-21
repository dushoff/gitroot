
## PulliamLab-UFL
## https://github.com/PulliamLab-UFL/competenceFramework.git

## Lord competence
PulliamLab += competenceFramework

$(PulliamLab):
	$(MAKE) target=$@ repo=$(github) user=PulliamLab-UFL clone

Ignore += $(PulliamLab)

######################################################################

## Mike Li

######################################################################

## ICI3D

ICI3D += MMED MMEDparticipants 

$(ICI3D):
	$(MAKE) target=$@ repo=$(github) user=ICI3D clone

Ignore += $(ICI3D)
