#lang simply-scheme


; Implement the union-set operation for the unordered-list representation of sets.

(define (element-of-set? x set)
  (cond ((null? set)
         #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (remove-element-set x set)
  (cond ((null? set) '())
        ((not (equal? (car set) x)) (cons (car set) (remove-element-set x (cdr set))))
        (else (remove-element-set x (cdr set)))))

;(define (union-set set1 set2)
 ; (cond ((and (null? set1) (null? set2)) '())
 ;       ((and (null? set1) (not (null? set2))) set2)
 ;       ((and (null? set2) (not (null? set1))) set1)
 ;       ((element-of-set? (car set1) set2)  (cons   )
        
 ; )
;)

(define (union-set set1 set2)
  (cond ((and (null? set1) (null? set2)) '())
        ((equal? set2 '()) set1)
        ((not (element-of-set? (car set2) set1)) (union-set (cons (car set2) set1) (cdr set2)))
        (else   (union-set set1 (cdr set2)))
      
      ))

 



; --- Tests ---
(define set1 (list 1 2 3 4))
(define set2 (list 3 4 5 6))

(element-of-set? 1 set1)
;(element-of-set? 1 set2)

;(adjoin-set 7 set1)
;(adjoin-set 1 set1)

;(intersection-set set1 set2)
;(intersection-set set2 set1)

;(remove-element-set 1 set1)

(union-set set1 set2)

(union-set set1 '())
(union-set '() set2)
(union-set set1 '(8))