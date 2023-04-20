#lang simply-scheme

; a) The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-
; order procedures. Write an analogous procedure called product that returns the product of the values of a
; function at points over a given range. Show how to define factorial in terms of product. Also use product
; to compute approximations to pi using the formula
;
;    pi       2·4·4·6·6·8···
;    ---  =  ----------------
;    4        3·3·5·5·7·7···

; b) If your product procedure generates a recursive process, write one that generates an iterative process. If
; it generates an iterative process, write one that generates a recursive process.

(define (inc n) (+ n 1))
(define (identity n) n)

(define (square x) (* x x))
(define (next x) (+ x 2))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

; Iterative version of productorium
(define (product-iter term a next b)
   (define (iter a result)
     (if (> a b)
         result
         (iter (next a) (* result (term a)))))
  (iter a 1))


; This is how to build factorial (increasing order)
;(product identity 1 inc 5)
;(product-iter identity 1 inc 5)

; Implementing Walli's product according to the book's "definition"
; I had read in multiple sources, in the end I noticed that I could start the numerator from 4 up to n
; I had to correct the lack of 2 on the numerator by multiplying on the denominator of the left side
; The denominator starts from 3 up to n - 1.
; I discovered up to which number (n or n -1) to go by taking a look at the formula.

(define (pi-aprox n)
  (* (* 2 4) (/ (/ (product square 4 next n) n) (product square 3 next (- n 1)))) )
;(pi-aprox 100)
(exact->inexact (pi-aprox 10000))
;(display "3.1417497371492673")
