#lang simply-scheme
;Define a procedure that takes three numbers as arguments 
; and returns the sum of the squares of the two larger numbers.

(define (square x)
  (* x x))

(define (sum_square x y)
  (+ (square x) (square y))
  )

(define (sum_max a b c)
  (cond ((and (< a b) (< a c)) (sum_square b c))
        ((and (< b a) (< b c)) (sum_square a c))
        ((and (< c a) (< c b)) (sum_square a b))
  )
)


(sum_max 1 2 3)
(sum_max 2 1 3)
(sum_max 3 2 1)