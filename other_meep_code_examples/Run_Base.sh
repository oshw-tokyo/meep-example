meep Base1_800nm-n146_45deg.ctl
h5topng -S10 -t 0:154 -R -Zc dkbluered -a yarg -A Base1_800nm-n146_45deg-out/eps-000000.00.h5 Base1_800nm-n146_45deg-out/ex.h5 
convert Base1_800nm-n146_45deg-out/ex.t*.png Base1_800nm-n146_45deg_test.gif
##scheme のプログラミングにエラーがあるときは下記一行目,２行目　で確かめられるらしい
#export GUILE_WARN_DEPRECATED="detailed"
#guile
#export GUILE_WARN_DEPRECATED="no"
