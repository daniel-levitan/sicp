#lang simply-scheme

; The good-enough? test used in computing square roots will not be very effective for finding the square
; roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited
; precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing
; how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch
; how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess.
; Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))
(define (improve guess x) (average guess (/ x guess)))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; An alternative strategy for implementing good-enough? is to watch how guess changes
; from one iteration to the next and to stop when the change is a very small fraction of the guess
(define (good-enough-alt? guess prev_guess)
  (< (/ (abs (- guess prev_guess)) guess) 0.001))

; Implementation using old good-enough
;(define (sqrt-iter guess x)
;  (if (good-enough? guess x)
;      guess
;      (sqrt-iter (improve guess x) x)))

; Implementation using new good-enough
(define (sqrt-iter guess prev_guess x)
  (if (good-enough-alt? guess prev_guess)
      guess
      (sqrt-iter (improve guess x) guess x)))

;(define (sqrt x)
;  (sqrt-iter 1.0 x))

; Calling sqrt-iter passing also our previous guess set to 0.0
(define (sqrt x)
  (sqrt-iter 1.0 0.0 x))



;(define a 0.000002242)
(define a 0.001)
(sqrt a)
(square (sqrt a))

;(define b 200000000000)
(define b 9999999999998)
(sqrt b)
(square (sqrt b))

