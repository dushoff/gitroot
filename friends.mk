
## PulliamLab-UFL
## https://github.com/PulliamLab-UFL/competenceFramework.git

## Lord competence
PulliamLab += competenceFramework

$(PulliamLab):
	$(MAKE) target=$@ repo=$(github) user=PulliamLab-UFL clone

