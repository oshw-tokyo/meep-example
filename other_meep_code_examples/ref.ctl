(define-param dpml 3.0)
(define-param len (+ 20 dpml))
(define-param wid (+ 20 dpml))
(set! geometry-lattice (make lattice (size len wid no-size)))
(define-param rotation-angle (* (/ 45 360) 2 pi)) ; 傾ける角度
(define-param beam-waist 2.5) ; 光源の分布幅
(define-param source-points 60) ; 点光源の数多めに設定
(define-param source-size (* 10 beam-waist)) ; 光源サイズ分布幅より大
(define-param src_list (list ))
(do
  ((   r_0 (/ source-size -2) ;　r_0 を- source-size/2 から
    (+ r_0 (/ source-size (- source-points 1))) ; +=source-size/(source-points-1) でインクリメント
  ))
  ((> r_0 (/ source-size 2))) ; r0< source-size/2 の条件を満たす間繰り返す
  (set! src_list (append src_list
   (list (make source
    (src (make gaussian-src (wavelength 1) (width 3)))
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