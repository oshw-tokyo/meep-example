

;
; ******************************************
; **** base for angle scaning of OI-DLA ****
; ******************************************
;(define-param gl-ang 45) ; in deg. <--To be changed via bash
;(define-param beta 0.413) ; for ini. 50 keV
;(define-param beta 0.3284) ;@ at around MPI, 30 keV
;(define-param beta 0.5482) ;@100keV
;(define-param beta 0.6037) ;@ 130keV, lg~1.5um



(define-param gm (+ 1 (/ eng 511.0))) ; eng and 511 are in keV
(define-param beta (sqrt (- 1 (/ 1 gm gm))) ) ;

(define-param nd (/ nsh 100.0)) ; index
(define-param dt (/ dtsh 10.0)) ; time step of output
;
;Def. of Domain
;
(define-param dpml 3.0)
(define-param len (+ 25 dpml))
(define-param wid (+ 25 dpml))
(set! geometry-lattice (make lattice (size wid len  no-size)))

;実験条件の定義
;使用する波長・屈折率、加速電場の速度、入射角

;（波長が単位長さになるので、簡単のため 1 とする。
;各寸法に波長をかければ実際の寸法が得られる）
;
(define-param lm 1.0) ; wavelength


(define-param gl-ang-rad (* (/ gl-ang 180) pi) ) ; 
(define-param D 20)  ; 光源の端（あたり）と回折格子(凸部)までの距離
(define-param shift 15)  ; 光源の端と回折格子の接触位置と中心との距離
;
;誘電体層、および回折格子のパラメータの定義
;
(define-param ep (* nd nd))
(define-param pit (* lm beta (/ 1 (- 1 (* nd beta (cos gl-ang-rad) ))) ) )
;  (/ (cos gl-ang-rad) (- (/ 1 (* nd beta)) (cos gl-ang-rad))) ) ;  1.051 :波長を 1 で規格化　nd=1.46　45 deg 入射で beta=0.413 の場合
(define-param h (/ lm (* hfac (- nd 1)))) ; ***1/4 OI-DLA*** 1.087 : nd=1.46 の場合
(define-param w_v (/ pit 2))
(define-param w_p (- pit w_v))
(define-param pit-num 100)
(define-param ac-gp (* pit-num pit))

;光源の分布の定義
;
;Def. of Sournce
;参考 url
;http://kenji-ishikawa.cocolog-nifty.com/plasma/2010/01/post-ea91.html
;
(define-param beam-waist  2.5  ) ; 光源（全体）の分布幅 
(define-param wd 3) ; 点光源として配置する各 gaussian-src のパルス幅 ???
(define-param src_list (list )) ; 空のリストで src_list を定義 <- append で list を追加する
(define-param source-points 100) ;点光源の数（多めに設定する）
(define-param source-size (* 5 beam-waist)) ; 光源の分布幅より大きく

;source を配置するリストを先に定義しておく　↓
(do
    ((r_0 (/ source-size -2) ;r_0 を - source-size/2 から
     (+ r_0 (/ source-size (- source-points 1))) ; += source-size/(source-points-1)でインクリメント
     ))
    ((> r_0 (/ source-size 2))) ; r_0 < source-size /2 の条件を満たす間
  (set! src_list 
	(append src_list
		(list (make source
			(src (make gaussian-src (wavelength lm) (width wd)))
			(amplitude (exp (- 0 (/ (* r_0 r_0) (* 2 beam-waist beam-waist)))))
			(component Hz)
			(center  (- (* r_0 (sin gl-ang-rad) ) 3)
				 (+ (* r_0 (cos gl-ang-rad)) 6)
				 )
				 )))
		))

; 上で定義した リスト ( src_list )でsource を定義　↓
(set! sources src_list) 

;回折格子の定義（パラメータは光源のパラメータの上　２５行目ぐらい？？）
(set! geometry ;; 誘電体の板から真空を切り取る順に定義
      (append
       (list 
	(make block 
	  (center 0 (/ len 4)) (size wid (/ len 2)) 
	  (material (make dielectric (epsilon ep)))))
       (geometric-object-duplicates 
	(vector3 pit 0) 0 (/ pit-num 2)
	(make block 
	  (center 0 (/ h 2))
	  (size w_v h)
	  (material air)))
       (geometric-object-duplicates 
	(vector3 (- 0 pit) 0) 0 (/ pit-num 2)
	(make block 
	  (center 0 (/ h 2))
	  (size w_v h) 
	  (material air))) 
       ))


;
; pml-layer，resolution の定義
;
(set! pml-layers (list (make pml (thickness dpml))))
(set! resolution res) ; initially 10
;
;output の定義

;
(use-output-directory)
(run-until (* 2 len)
		  (at-beginning output-epsilon)
		  (to-appended "ex" (at-every dt output-efield-x))
		  (to-appended "ey" (at-every dt output-efield-y))
		  (to-appended "hz" (at-every dt output-hfield-z))
)



