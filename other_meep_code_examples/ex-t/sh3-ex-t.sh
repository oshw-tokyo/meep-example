meep ipac-proc.ctl
convert 1-obliq-t-ex-out/ex-00*.png 1-obliq-t-ex-out/ex.gif
#rm 1-obliq-t-ex-out/*.png
h5topng -S4 -0y -0 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-0.png
h5topng -S4 -0y -1 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-1.png
h5topng -S4 -0y -2 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-2.png
h5topng -S4 -0y -5 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-5.png
h5topng -S4 -0y -10 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-10.png
h5topng -S4 -0y -20 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex-20.png
