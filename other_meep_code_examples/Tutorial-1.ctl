(set! geometry-lattice (make lattice (size 16 8 no-size)))
(set! geometry (list
                (make block (center 0 0) (size infinity 1 infinity)
                      (material (make dielectric (epsilon 12))))))
(set! sources (list
               (make source
                 (src (make continuous-src (frequency 0.15)))
                 (component Ez)
                 (center -7 0))))
