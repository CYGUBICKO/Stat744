
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
Sources += images HW2 HW3 HW4
Sources += nwtsco_var_description.csv

Ignore += class_livecodes

######################################################################

## Assignments: https://mac-theobio.github.io/DataViz/assignments.html

## Homework 2
hw2.html: hw2.rmd
# vaccine_data.csv: hw2.html;

## Homework 3
hw3.html: hw3.rmd

## Homework 4
hw4.html: hw4.rmd

## Copy the final output to the Output dir
move_output:
	make hw4.html && cp hw4.html HW4/

clean: 
	rm -f *Rout.*  *.Rout .*.RData .*.Rout.* .*.wrapR.* .*.Rlog *.RData *.wrapR.* *.Rlog *.rdeps *.rda .*.rdeps .*.rda *.vrb *.toc *.out *.nav *.snm *.log *.aux

Ignore += *.rda
Ignore += *.Rhistory
Ignore += *.pdf *.html *.csv *.vrb *.png *.Rexit

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
