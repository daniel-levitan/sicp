#lang simply-scheme

; Define a procedure square-tree analogous to the square-list procedure of Exercise 2.21. That is, squaretree
; should behave as follows:

(define t (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))


(define (my-map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (my-map proc (cdr items)))))

(define (square-tree-2 tree)
  (my-map (lambda (sub-tree)
            (if (pair? sub-tree)
                (square-tree-2 sub-tree)
                (square sub-tree)))
          tree))

(define (square-tree-3 tree)
  (if (list? tree)
      (map (lambda (sub-tree) (square-tree-3 sub-tree)) tree)
      (square tree)))


(square-tree t)
(square-tree-2 t)
(square-tree-3 t)
;(1 (4 (9 16) 25) (36 49))

; Define square-tree both directly (i.e., without using any higher-order procedures) and also
; by using map and recursion.

(define (deep-map fn lol)
  (if (list? lol)
      (map (lambda (element) (deep-map fn element))
           lol)
      (fn lol)))

(deep-map square t)