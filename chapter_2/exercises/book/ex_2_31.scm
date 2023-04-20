#lang simply-scheme

; Abstract your answer to Exercise 2.30 to produce a procedure tree-map with the property that squaretree
; could be defined as
; (define (square-tree tree) (tree-map square tree))



(define t (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(define (square x) (* x x))

(define (my-map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (my-map proc (cdr items)))))

(define (tree-map func tree)
  (my-map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map func sub-tree)
             (func sub-tree)))
          tree))

(define (square-tree tree) (tree-map square tree))
(square-tree t)

;(1 (4 (9 16) 25) (36 49))

; Define square-tree both directly (i.e., without using any higher-order procedures) and also
; by using map and recursion.

;(tree-map square tree)