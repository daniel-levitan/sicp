#lang simply-scheme


;(define (element-of-set? x set)
;  (cond ((null? set) false)
;        ((= x (car set)) true)
;        ((< x (car set)) false)
;        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< x (car set)) (cons x set))
        ((> x (car set)) (cons (car set) (adjoin-set x (cdr set))))
        (else set) ))


(define set1 (list 2 4 6))

(adjoin-set 1 '())
(adjoin-set 1 set1)
(adjoin-set 3 set1)
(adjoin-set 5 set1)
(adjoin-set 7 set1)

