
current: target
-include target.mk

##################################################################

## Kind of deprecated now ☺
ms = makestuff

Sources += Makefile README.md

## Used by Steve to link data to right place
Ignore += local.mk
-include local.mk

######################################################################

Sources += $(wildcard *.R *.rmd *.tex)
Ignore += class_livecodes

######################################################################

## Assignments:
## Homework 2: https://mac-theobio.github.io/DataViz/assignments.html

hw2.html: hw2.rmd
# vaccine_data.csv: hw2.html;

## Copy the final output to the Output dir

move_output:
	make hw2.html
	cp hw2.html HW2/

clean: 
	rm -f *Rout.*  *.Rout .*.RData .*.Rout.* .*.wrapR.* .*.Rlog *.RData *.wrapR.* *.Rlog *.rdeps *.rda .*.rdeps .*.rda *.vrb *.toc *.out *.nav *.snm *.log *.aux

######################################################################

### Makestuff

Ignore += makestuff
msrepo = https://github.com/dushoff
Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls $@

-include makestuff/os.mk
-include makestuff/visual.mk
-include makestuff/projdir.mk
-include makestuff/texdeps.mk
-include makestuff/pandoc.mk
-include makestuff/stepR.mk
-include makestuff/git.mk
