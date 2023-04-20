#lang simply-scheme

; To be more precise, we can define equal? recursively in terms of the basic eq? equality of symbols by saying
; that a and b are equal? if they are both symbols and the symbols are eq?, or if they are both lists such that
; (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b).

(define (equal? a b)
  (cond ((or (and (null? a) (not (null? b)))
             (and (null? b) (not (null? a)))) #f)
        ((and (null? a) (null? b)) #t)
        (else (and (eq? (car a) (car b))
                   (equal? (cdr a) (cdr b))) )))


(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))

