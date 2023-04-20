#lang simply-scheme

; Tree definitions
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define my-set (adjoin-set 11 (adjoin-set 5 (adjoin-set 1 (adjoin-set 9 (adjoin-set 3 (adjoin-set 7 '())))))))

;(element-of-set? 11 my-set)
;(element-of-set? 2 my-set)


; This exercise book definitions
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree) (tree->list-1 (right-branch tree)))) ) )

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))) )  
  (copy-to-list tree '()) )


; Tests

(trace tree->list-1)
(tree->list-1 my-set)
;(trace tree->list-2)
;(trace copy-to-list)
;(tree->list-2 my-set)


; trace tree->list-1
;>(tree->list-1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
;> (tree->list-1 '(3 (1 () ()) (5 () ())))
;> >(tree->list-1 '(1 () ()))
;> > (tree->list-1 '())
;< < '()
;> > (tree->list-1 '())
;< < '()
;< <'(1)
;> >(tree->list-1 '(5 () ()))
;> > (tree->list-1 '())
;< < '()
;> > (tree->list-1 '())
;< < '()
;< <'(5)
;< '(1 3 5)
;> (tree->list-1 '(9 () (11 () ())))
;> >(tree->list-1 '())
;< <'()
;> >(tree->list-1 '(11 () ()))
;> > (tree->list-1 '())
;< < '()
;> > (tree->list-1 '())
;< < '()
;< <'(11)
;< '(9 11)
;<'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)

;tree-list-2 trace
;>(copy-to-list '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))) '())
;> (copy-to-list '(9 () (11 () ())) '())
;> >(copy-to-list '(11 () ()) '())
;> > (copy-to-list '() '())
;< < '()
;> >(copy-to-list '() '(11))
;< <'(11)
;> (copy-to-list '() '(9 11))
;< '(9 11)
;>(copy-to-list '(3 (1 () ()) (5 () ())) '(7 9 11))
;> (copy-to-list '(5 () ()) '(7 9 11))
;> >(copy-to-list '() '(7 9 11))
;< <'(7 9 11)
;> (copy-to-list '() '(5 7 9 11))
;< '(5 7 9 11)
;>(copy-to-list '(1 () ()) '(3 5 7 9 11))
;> (copy-to-list '() '(3 5 7 9 11))
;< '(3 5 7 9 11)
;>(copy-to-list '() '(1 3 5 7 9 11))
;<'(1 3 5 7 9 11)
;'(1 3 5 7 9 11)
;> 