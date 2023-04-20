#lang simply-scheme

; The exponentiation algorithms in this section are based on performing exponentiation by means of
; repeated multiplication. In a similar way, one can perform integer multiplication by means of repeated addition. Thee
; following multiplication procedure (in which it is assumed that our language can only add, not multiply) is analogous
; to the expt procedure:

;(define (* a b)
;  (if (= b 0)
;      0
;      (+ a (* a (- b 1)))))

; This algorithm takes a number of steps that is linear in b. Now suppose we include, together with addition, operations
; double, which doubles an integer, and halve, which divides an (even) integer by 2. Using these, design a multiplication
; procedure analogous to fast-expt that uses a logarithmic number of steps.

(define (double n) (* n 2))
(define (halve n) (/ n 2))

(define (mult a b)
  (if (= b 1)
      a
      (if (even? b)
          (double (mult a (halve b)))
          (+ a (double (mult a (halve (- b 1)))))
          )
  )
)



;(trace mul)
;(mult 3 4)
;(mult 3 0) ; Do I need a special case?
(mult 3 5)
(mult 3 3)
(mult 2 3)
(mult 4 3)
(mult 4 4)
(mult 4 6)

;(mult-iter 3 3 1)
;(mult-iter 2 3 1)
;(mult-iter 4 3 1)
;(mult-iter 4 6 1)
;(mult-iter 4 4 1)