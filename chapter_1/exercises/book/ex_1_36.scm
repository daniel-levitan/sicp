#lang simply-scheme

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;(define (golden-ratio x) (+ 1 (/ 1 x)))
(define (average a b) (/ (+ a b) 2))

(define (x-to-x x) (/ (log 1000) (log x)))
(define (avg-damping x) (average x (x-to-x x)))

;(fixed-point x-to-x 1.1)
(fixed-point avg-damping 1.1)