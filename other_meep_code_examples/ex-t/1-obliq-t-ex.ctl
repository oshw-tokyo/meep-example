(define-param dpml 3.0)
(define-param sx (+ 50 dpml))
(define-param sy (+ 30 dpml))
(define-param lamb 1)
(define-param inci 1.46)
(define-param epsi (* inci inci))
(define-param pit  0.7)
(define-param dep (/ lamb (* 2 (- inci 1))))

(set! geometry-lattice (make lattice (size sx sy no-size)))

(set! geometry
(append
(list (make block (center  0 (/ sy 4)) (size sx (/ sy 2)) (material (make dielectric (epsilon epsi)))))
(geometric-object-duplicates (vector3 pit 0) 0 100
(make block (center (/ pit 1.5) (/ dep 2)) (size (/ pit 2) dep ) (material air)))
(geometric-object-duplicates (vector3 (- 0 pit) 0 ) 0 100
(make block (center (/ pit 1.5) (/ dep 2)) (size (/ pit 2) dep) (material air)))
))


(define-param rotation-angle (* (/ 45 360) 2 pi)) ; 傾ける角度
(define-param beam-waist 4) ; 光源の分布幅
(define-param source-points 100) ; 点光源の数多めに設定
(define-param source-size (* 5 beam-waist)) ; 光源サイズ分布幅より大
(define-param deltx (/ sx 4)) ; パルスの位置 
(define-param delty (/ sy 4)) ; 
(define-param sigmt 10) ; パルス長
(define-param src_list (list ))
;;Ex
(do
  ((   r_0 (/ source-size -2) ;　r_0 を- source-size/2 から
    (+ r_0 (/ source-size (- source-points 1))) ; +=source-size/(source-points-1) でインクリメント
  ))
  ((> r_0 (/ source-size 2))) ; r0< source-size/2 の条件を満たす間繰り返す
  (set! src_list (append src_list
   (list (make source
    (src (make gaussian-src (wavelength lamb) (width sigmt)))
    (amplitude (exp (- 0 (/ (* r_0 r_0) (* 2 beam-waist beam-waist)))))
    (component Ex)
    (center (- (* r_0 (sin rotation-angle)) deltx) (+ (* r_0 (cos rotation-angle)) delty))
   ))
  ))
)
;;Ey
(do
  ((   r_0 (/ source-size -2) ;　r_0 を- source-size/2 から
    (+ r_0 (/ source-size (- source-points 1))) ; +=source-size/(source-points-1) でインクリメント
  ))
  ((> r_0 (/ source-size 2))) ; r0< source-size/2 の条件を満たす間繰り返す
  (set! src_list (append src_list
   (list (make source
    (src (make gaussian-src (wavelength lamb) (width sigmt)))
    (amplitude (exp (- 0 (/ (* r_0 r_0) (* 2 beam-waist beam-waist)))))
    (component Ey)
    (center (- (* r_0 (sin rotation-angle)) deltx) (+ (* r_0 (cos rotation-angle)) delty))
   ))
  ))
)
(set! sources src_list)
(set! pml-layers (list (make pml (thickness dpml))))
(set! resolution 13) ;; initially 10
(use-output-directory)
(run-until (* 2 sx)
	   (at-beginning output-epsilon)
	   (at-every pit (output-png Ex "-s4 -Zc dkbluered"))
	   (to-appended "ex" (at-every pit output-efield-x))
;	   (to-appended "ex-t-0" (at-every (/ sx 2) (output-png Ex "-0y -0 Zc dkblured")))
;	   (to-appended "ex-t-0" (at-every (/ sx 2) (output-png Ex "-0y -2 Zc dkblured")))
;	   (to-appended "ex-t-0" (at-every (/ sx 2) (output-png Ex "-0y -5 Zc dkblured")))
;	   (to-appended "ex-t-0" (at-every (/ sx 2) (output-png Ex "-0y -10 Zc dkblured")))
)

