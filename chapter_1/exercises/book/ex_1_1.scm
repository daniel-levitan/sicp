#lang simply-scheme

; Exercise 1.1: Below is a sequence of expressions. What is the result printed by
; the interpreter in response to each expression? Assume that the sequence is to be evaluated
;in the order in which it is presented.

;a) 10
;> 10

;b) (+ 5 3 4)
;> 12

;c) (- 9 1)
;> 8

;d) (/ 6 2)
;> 3

;e) (+ (* 2 4) (- 4 6))
;> 6
(+ (* 2 4) (- 4 6))

;f) (define a 3)
;> a or nothing
;a = 3
(define a 3)

;g) (define b (+ a 1))
;> b or nothing
;b = 4
(define b (+ a 1))

;h) (+ a b (* a b))
;> 19
(+ a b (* a b))

;i) (= a b)
;> #f
(= a b)

;j) (if (and (> b a) (< b (* a b)))
;      b
;      a)
;> 4
;(> b a) -> #t
;(< b (12)) -> #t
;(and #t #t) -> b
(if (and (> b a) (< b (* a b)))
      b
      a)

;k) (cond ((= a 4) 6)
;      ((= b 4) (+ 6 7 a))
;      (else 25))
;> 16
;(= a 4) -> #f
;(= b 4) -> #t -> (+ 6 7 a) -> (+ 6 7 3) -> 16
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

;l) (+ 2 (if (> b a) b a))
;> 6
;(> b a) -> #f -> a -> (+ 2 a) -> 6
(+ 2 (if (> b a) b a))

;m) (* (cond ((> a b) a)
;         ((< a b) b)
;         (else -1))
;      (+ a 1))
;> 16
;(> a b) -> #f
;(< a b) -> #t -> b => (* (b (+ a 1))) -> (* 4 4) -> 16
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
      (+ a 1))