#lang simply-scheme

; Using reasoning analogous to Alyssa’s, describe how the difference of two intervals may be computed.
; Define a corresponding subtraction procedure, called sub-interval.

(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

; interval subtraction: [a,b] - [c,d] = [a - d, b - c]
(define (sub-interval itrvl-1 itrvl-2)
  (make-interval (- (lower-bound itrvl-1) (upper-bound itrvl-2))
                 (- (upper-bound itrvl-1) (lower-bound itrvl-2)) ))



; --- Testing ---
(define r-1 (make-interval 6.12 7.48))
(define r-2 (make-interval 2.58 2.97))

