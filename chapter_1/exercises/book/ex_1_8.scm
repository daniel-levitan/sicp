#lang simply-scheme

; Newton’s method for cube roots is based on the fact that if y is an approximation to the cube root of x,
; then a better approximation is given by the value (x/y^2 + 2y) / 3
; Use this formula to implement a cube-root procedure analogous to the square-root procedure.

(define (square x) (* x x))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))  

(define (good-enough-alt? guess prev_guess)
  (< (/ (abs (- guess prev_guess)) guess) 0.001))

(define (cbrt-iter guess prev_guess x)
  (if (good-enough-alt? guess prev_guess)
      guess
      (cbrt-iter (improve guess x) guess x)))

(define (cbrt x)
  (cbrt-iter 1.0 0.0 x))


(cbrt 27)
