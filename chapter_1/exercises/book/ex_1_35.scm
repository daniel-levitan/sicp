#lang simply-scheme

; Show that the golden ratio φ (Section 1.2.2) is a fixed point of the transformation x |-> 1 + 1/x, and
; use this fact to compute φ by means of the fixed-point procedure.

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (golden-ratio x) (+ 1 (/ 1 x)))

(fixed-point golden-ratio 1.0)