#lang simply-scheme

; Alyssa’s program is incomplete because she has not specified the implementation of the interval abstraction.
; Here is a definition of the interval constructor:
; (define (make-interval a b) (cons a b))

; Define selectors upper-bound and lower-bound to complete the implementation.

(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

; --- Testing ---
(define r (make-interval 6.12 7.48))
(upper-bound r)
(lower-bound r)
