#lang simply-scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs) ))))

; -- matrix
(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))
; -- vectors
(define v (list 2 2 2 2))
(define y (list 2 2 2))

; -- dot product
; Multiplicando cada elemento do vetor pelo correspondente de mesmo índice no outro vetor
; returns the sum_i = v_i · w_i ;
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
;(dot-product (list 1 3) (list 2 5))

; -- matrix-vector multiplication
; Multiplicando cada linha da matriz m pelo vetor v e somando por linha - ou seja, dot product de cada linha e vetor
;(matrix-*-vector m v) returns the vector t where ti = sum_j m_ij · v_j ;
(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product v x)) m))
;(matrix-*-vector m v)

; -- transpose
; Retorna a matriz transposta
; (transpose m) returns the matrix n;
; where n_ij = m_ji
(define (transpose mat)
  (accumulate-n cons '() mat))
;(transpose m)

;(matrix-*-matrix m n) returns the matrix p
; Retorna o produto entre as matrizes
; where pij = sum k m_ik · n_kj 
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))



(define a (list (list 1 2) (list 3 4)))
(define b (list (list 1 1) (list 1 1)))
;(define b (list (list 7 6) (list 5 4)))
;(transpose b)
;(matrix-*-matrix a b)

