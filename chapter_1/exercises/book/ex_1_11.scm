#lang simply-scheme

; A function f is defined by the rule that
;           n if n < 3,
; f (n) =   f (n - 1) + 2f (n - 2) + 3f (n - 3) if n >= 3
; Write a procedure that computes f by means of a recursive process.
; Write a procedure that computes f by means of an iterative process.

(define (f-rec n)
  (if (< n 3)
      n
      (+ (f-rec (- n 1)) (* 2 (f-rec (- n 2))) (* 3 (f-rec (- n 3)))) ))

(f-rec 4)

(define (f-iter a b c count)
  (if (< count 3)
      a
      (f-iter (+ a (* 2 b) (* 3 c))
              a
              b
              (- count 1)) ))


(define (f n)
  (if (< n 3)
      n
      (f-iter 2 1 0 n) ))



(f 4)
; The solution is based on fib below. The transformation is the hard part
; Attention to the main call (f-2)
;(define (fib n)
;  (fib-iter 1 0 n))
;(define (fib-iter a b count)
;  (if (= count 0)
;      b
;      (fib-iter (+ a b) a (- count 1))))

; Acho que é mais fácil ver que f(n-1) passa a ser f(n-2) e que f(n-2) passa a ser f(n-3).
; Podemos notar isso porque o valor atual, n passa a ser n-1 e atualizamos n.

