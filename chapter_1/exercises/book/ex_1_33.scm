#lang simply-scheme

; You can obtain an even more general version of accumulate (Exercise 1.32) by introducing the notion
; of a filter on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy
; a specified condition. The resulting filtered-accumulate abstraction takes the same arguments as accumulate, together
; with an additional predicate of one argument that specifies the filter. Write filtered-accumulate as a procedure.
; Show how to express the following using filtered-accumulate:

; a) the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate
; already written)
; b) the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n
; such that GCD(i, n) = 1).

(define (square x) (* x x))
(define (inc n) (+ n 1))
(define (identity n) n)

(define (smallest-prime-factor n m)
  (if (= (remainder n m) 0)
      m
      (smallest-prime-factor n (+ m 1))))

(define (is-prime? n)
  (if (= n 1)
      #f
      (= (smallest-prime-factor n 2) n)))
 
; A lógica aqui é simples, eu só acumulo aquilo que passo o filtro, caso contrário vou para o próximo elemento.
(define (filtered-accumulate combiner null-value term a next b filter)
  ;(cond ( (> a b) null-value)
  (cond ((> a b) null-value)
        ((filter a) (combiner (term a) (filtered-accumulate combiner null-value term (next a) next b filter)))
        (else (combiner null-value (filtered-accumulate combiner null-value term (next a) next b filter))) ))

(filtered-accumulate + 0 identity 1 inc 11 is-prime?)
(filtered-accumulate + 0 square 1 inc 11 is-prime?)
