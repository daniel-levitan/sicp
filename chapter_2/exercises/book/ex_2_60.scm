#lang simply-scheme

; We specified that a set would be represented as a list with no duplicates. Now suppose we allow duplicates.
; For instance, the set {1, 2, 3} could be represented as the list (2 3 2 1 3 2 2). Design procedures element-of-
; set?, adjoin-set, union-set, and intersection-set that operate on this representation. How does the efficiency
; of each compare with the corresponding procedure for the non-duplicate representation? Are there applications for which
; you would use this representation in preference to the nonduplicate one?

(define (element-of-set? x set)
  (cond ((null? set)
         #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
      (cons x set))

(define (union-set set1 set2)
  (if (equal? set2 '())
      set1
      (union-set (cons (car set2) set1) (cdr set2))))


(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (if (element-of-set? (car set1) (cdr set1))
             (intersection-set (cdr set1) set2)
             (cons (car set1) (intersection-set (cdr set1) set2))))
        (else (intersection-set (cdr set1) set2))))


(define set2 (list 1 2 3))
(define set1 (list 1 2 3 2 3 1))
(define set3 (list 3 4 5))

;(element-of-set? 1 set1)
;(element-of-set? 3 set1)
;(element-of-set? 7 set1)

;(adjoin-set 2 set2)
;(union-set set2 set3)
(intersection-set set2 set1)
(intersection-set set1 set2)
(intersection-set set1 set3)
(intersection-set set3 set1)