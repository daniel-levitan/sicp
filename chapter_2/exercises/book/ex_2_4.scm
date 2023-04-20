#lang simply-scheme

; Here is an alternative procedural representation of pairs. For this representation,
; verify that (car (cons x y)) yields x for any objects x and y.

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

(define p (cons 1 2))

(car p)
(cdr p)

; Substitution
;
; (car (cons x y))
; (car (lambda (m) (m x y)))
; (z (lambda (p q) p))
; ((lambda (m) (m x y)) (lambda (p q) p))
; m is (lambda (p q) p) so
; ((lambda (p q) p)  x y)
; x



