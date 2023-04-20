#lang simply-scheme

; a) Show that sum and product (Exercise 1.31) are both special cases of a still more general notion called accumulate
; that combines a collection of terms, using some general accumulation function:
; (accumulate combiner null-value term a next b)
; accumulate takes as arguments the same term and range specifications as sum and product, together with
; a combiner procedure (of two arguments) that specifies how the current term is to be combined with the
; accumulation of the preceding terms and a null-value that specifies what base value to use when the terms
; run out. Write accumulate and show how sum and product can both be defined as simple calls to accumulate.

; b) If your accumulate procedure generates a recursive process, write one that generates an iterative process.
; If it generates an iterative process, write one that generates a recursive process.

(define (inc n) (+ n 1))
(define (identity n) n)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (sum term a next b)
	(if (> a b)
	0
	(+ (term a) (sum term (next a) next b))))

(define (accumulate combiner null-value term a next b)
   (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b)))
  )

(define (accumulate-iter combiner null-value term a next b)
   (define (iter a result)
     (if (> a b)
         result
         (iter (next a) (combiner result (term a)))))
  (iter a null-value))


; Testing for product
(product identity 1 inc 4)
(accumulate * 1 identity 1 inc 4)
(accumulate-iter * 1 identity 1 inc 4)
; Testing for sum
(sum identity 1 inc 3)
(accumulate + 0 identity 1 inc 3)
(accumulate-iter + 0 identity 1 inc 3)