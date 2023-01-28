;
;Def. of Domain
;
(define-param dpml 3.0)
(define-param len (+ 40 dpml))
(define-param wid (+ 40 dpml))
(set! geometry-lattice (make lattice (size wid len  no-size)))

;
;Def. of Sournce
;
(define-param lm 1.035) ; wavelength
(define-param wd 3) ; gaussian-src の幅 ???
(define-param src_list (list )) ; 空のリストで src_list を定義
(define-param gl-ang 45) ; in deg. <--To be changed 
(define-param rotation-angle (* (/ gl-ang 360) 2 pi) ) ; sourc を分布するラインをを傾ける角度
(define-param beam-waist 2.5) ; 光源の分布幅
(define-param source-points 601) ;点光源の数（多めに設定する）
(define-param source-size (* 10 beam-waist)) ; 光源の分布幅より大きく
;source を配置するリストを先に定義しておく　↓
(do
    ((r_0 (/ source-size -2) ;r_0 を - source-size/2 から
     (+ r_0 (/ source-size (- source-points 1))) ; += source-size/(source-points-1)でインクリメント
     ))
    ((> r_0 (/ source-size 2))) ; r_0 < source-size /2 の条件を満たす間
  (set! src_list 
	(append src_list
		(list (make source
			(src (make gaussian-src (wavelength lm) (width 3)))
			(component Hz)
			(center (* r_0 (cos rotation-angle))
				(* r_0 (sin rotation-angle))
			)))
		))
)
;横方向の強度分布はガウス分布にならず（端をのぞいて）ほぼ一様な定義になっている点に注意
; 上で定義した リスト ( src_list )でsource を定義　↓
(set! sources src_list) 

;
;誘電体層、および回折格子の定義
;
(define-param nd 1.46)
(define-param ep (* nd nd))
(define-param pit (/ 0.7 lm))
(define-param w_v (/ pit 2))
(define-param w_p (- pit w_v))
(define-param h (/ lm (* 2 (- nd 1))))
;
(set! geometry ;; 誘電体の板から真空を切り取る順に定義
      (append
       (list 
	(make block 
	  (center 0 (/ len 2)) (size wid (/ len 2)) 
	  (material (make dielectric (epsilon ep)))))
       (geometric-object-duplicates 
	(vector3 pit 0) 0 20
	(make block 
	  (center 0 (/ h 2))
	  (size w_v h)
	  (material air)))
       (geometric-object-duplicates 
	(vector3 (- 0 pit) 0) 0 20
	(make block 
	  (center 0 (/ h 2))
	  (size w_v h) 
	  (material air)))
       ))


;
; pml-layer，resolution の定義
;
(set! pml-layers (list (make pml (thickness dpml))))
(set! resolution 10) ; initially 10
;
;output の定義
;
(use-output-directory)
(run-until (* 2 len)
		  (at-beginning output-epsilon)
		  (to-appended "ex" (at-every 2 output-efield-x)))
					; (at-every 2 (output-png Ex "-Zc /usr/share/h5utils/colormaps/dkbluered"))


