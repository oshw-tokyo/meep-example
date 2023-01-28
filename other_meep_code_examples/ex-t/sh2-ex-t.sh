meep 1-obliq-t-ex.ctl
convert 1-obliq-t-ex-out/ex-00*.png 1-obliq-t-ex-out/ex.gif
rm 1-obliq-t-ex-out/*.png
h5topng -0x -0 -Zc dkbluered 1-obliq-t-ex-out/ey.h5
h5topng -0x -0 -Zc dkbluered 1-obliq-t-ex-out/ex.h5 
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex0.png
h5topng -0x -1 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex1.png
h5topng -0x -2 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex2.png
h5topng -0x -3 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex3.png
h5topng -0x -4 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex4.png
h5topng -0x -5 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex5.png
h5topng -0x -6 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex6.png
h5topng -0x -7 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex7.png
h5topng -0x -8 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex8.png
h5topng -0x -9 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex9.png
h5topng -0x -10 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex10.png
h5topng -0x -15 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex15.png
h5topng -0x -20 -Zc dkbluered 1-obliq-t-ex-out/ex.h5
mv 1-obliq-t-ex-out/ex.png 1-obliq-t-ex-out/ex20.png

