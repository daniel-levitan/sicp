#lang simply-scheme

(define (equ? n1 n2)
  (if (and (eq? (type-tag n1) (type-tag n2))
           (eq? (contents n1) (contents n2)))
      #t
      #f
      )
  )