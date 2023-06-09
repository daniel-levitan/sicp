#lang simply-scheme



(define (union-set set1 set2)
  (cond ((and (null? set1) (null? set2)) '())
        ((null? set1) set2)
        ((null? set2) set1)        
        ((< (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) set2)))
        ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))
        (else (cons (car set1) (union-set (cdr set1) (cdr set2)) )) ))

(define set1 (list 1 4 7))
(define set2 (list 2 3 6))
(define set3 (list 1 5 9))

;(trace union-set)
(union-set set1 set2)
(union-set set1 set3)
(union-set set2 set3)

