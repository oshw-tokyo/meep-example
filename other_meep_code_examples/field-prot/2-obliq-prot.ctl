(define-param dpml 3.0)
(define-param len (+ 80 dpml))
(define-param wid (+ 40 dpml))
(define-param lamb 1 )
(define-param inci 1.46 )
(set-param epsi (* inci inci))
(set-param hight (/ lamb (- inci 1)))

(set! geometry-lattice (make lattice (size len wid no-size)))

(set! geometryp
      (append
       (list 
	(make block (center (- 0 (/  wid  4)) 0) (size (/ wid 2) len)  ;
	      (material (make dielectric (epsilon epsi)))))
       (geometric-object-duplicates (vector3 0 4) 0 20
				    (make block (center 2 1) (size 5 3) (material air)))
       (geometric-object-duplicates (vector3 0 -4) 0 20
				    (make block (center 2 1) (size 5 3) (material air)))
))

(define-param rotation-angle (* (/ 45 360) 2 pi)) ; 傾ける角度
(define-param beam-waist 2.5) ; 光源の分布幅
(define-param source-points 60) ; 点光源の数多めに設定
(define-param source-size (* 10 beam-waist)) ; 光源サイズ分布幅より大
(define-param src_list (list ))
(do
  ((   r_0 (/ source-size -2) ;　r_0 を- source-size/2 から
    (+ r_0 (/ source-size (- source-points 1))) ; +=source-size/(source-points-1) でインクリメント
  ))
  ((> r_0 (/ source-size 2))) ; r0< source-size/2 の条件を満たす間60繰り返す
  (set! src_list (append src_list
   (list (make source
    (src (make gaussian-src (wavelength lamb) (width 3)))
    (amplitude (exp (- 0 (/ (* r_0 r_0) (* 2 beam-waist beam-waist)))))
    (component Ez)
    (center (* r_0 (sin rotation-angle)) (* r_0 (cos rotation-angle)))
   ))
  ))
)
(set! sources src_list)
(set! pml-layers (list (make pml (thickness dpml))))
(set! resolution 10)
(use-output-directory)
(run-until (* 2 len)
       (at-every 2 (output-png Ez "-Zc /usr/share/h5utils/colormaps/dkbluered"))
)
