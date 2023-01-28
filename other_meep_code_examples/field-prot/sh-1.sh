meep no-bend?=true 1-field.ctl | tee bend0.out
meep 1-field.ctl | tee bend.out
grep fux1: bend0.out > bend0.dat
grep fux1: bend.out > bend.dat
