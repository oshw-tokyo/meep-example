#!/bin/bash
#
dif=5 #5 # 角度の変化分
dtsh=1 # will be 1/10 when processing
res=30 #30 #10 # shold be more greater than 15 when n=1.46, 30 when n=3.4, 20 when n=2.42
for ind in  "340" #"146"    "145" "242"
do
mkdir OI-DLA_n${ind}/
echo "directroy:OI-DLA_n${ind}/ ...made " 
for dep in "4" # "2" #100 for test of no grating (#: S式コメントアウト in scheme が便利 →使えない？)
do
mkdir OI-DLA_n${ind}/1ov${dep}-OIDLA/
echo "directroy:OI-DLA_n${ind}/1ov${dep}-OIDLA ...made " 
mkdir OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/
echo "directroy:OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/ ...made " 
for eng in "50" #"30"  "100" "130"
do
mkdir OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/
echo "directroy:OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ ...made " 
mkdir OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/
mkdir OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/out_res${res}-dt${dtsh}/
echo "directroy:OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/ & out_res${res}-dt${dtsh}/ ...made " 
th=40
while [ ${th} -le  85 ]
do
echo "; **************** 1ov${dep} OI-DLA ******************" > OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
echo "; ***** written by shell:: 1ov${dep}_${eng}keV_${th} ***" >> OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
echo "(define-param eng ${eng})" >> OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
echo "(define-param gl-ang ${th})" >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl
echo "(define-param nsh ${ind})" >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl
echo "(define-param hfac ${dep})" >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl
echo "(define-param res ${res})" >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl
echo "(define-param dtsh ${dtsh})" >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl
cat fram_n-deg-eng_any.ctl >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
#cat test.ctl >>  OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
echo "processing 1ov${dep}_ind${ind}_res${res}_dt${dtsh}_th${th}_${eng}keV_${deg} with MEEP..... "
cd OI-DLA_n${ind}/1ov${dep}-OIDLA/angle-scans/1ov${dep}-${eng}keV/out_res${res}-dt${dtsh}
mkdir th${th}-out/
meep ../ctl-files_res${res}-dt${dtsh}/th${th}.ctl 
cd th${th}-out/
for fld in ex ey hz
do
for dy in 0 5 15 30 60 120 #0 5 10 20 30 50 100 # -11 -16 -21 -26 -31 # h=1.086956522 in meep when n=1.46 and lm=1.0, h/2=5.43, resl=10
do
h5topng -0y ${dy} -S5 -Zc dkbluered ${fld}.h5
mv ${fld}.png 1ov${dep}_n${ind}_eng${eng}_th${th}-${fld}-dy${dy}.png
done
done
h5topng -t 260:300 -S5 -Zc dkbluered -a yarg -A eps-000000.00.h5 ex.h5
#h5topng -0y -35 -Zc dkbluered ex.h5
#h5topng -t 100:120 -S5 -Zc dkbluered -a yarg -A eps-000000.00.h5 ex.h5
cd ../
cd ../../../../../
echo -n "dep:${dep}, n:${ind}, eng${eng}, th:${th}" >> beta-scan_hist.txt
echo `...date '+%y/%m/%d %H:%M:%S'`　>> beta-scan_hist.txt
echo ".... 1ov${dep}_n${ind}_res${res}_dt${dtsh}_th${th}${eng}keV_${deg} process fin" 
echo `date '+%y/%m/%d %H:%M:%S'`　
th=`expr ${th} + ${dif}`
done
done
done
done
exit 0
#results of h5ls 2015-01-24:
#             Dataset {280, 280, 560/Inf}
