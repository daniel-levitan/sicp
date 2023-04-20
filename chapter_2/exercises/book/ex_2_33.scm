#lang simply-scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)) )  ))


(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))
;(accumulate (lambda x y) (p x y)) null sequence)) ; -> Usando square vemos que isso aqui está errado

; Isso aqui depende da operação, initial depende da operação
(define (square x) (* x x))
;(map square (list 1 2 3))


(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;(append (list 1 2 3) (list 4 5 6))


(define (count x y)
      (+ 1 y))

(define (length sequence)
  (accumulate count 0 sequence))

;(length (list 1 2 3 4))