#lang simply-scheme

; If f is a numerical function and n is a positive integer, then we can form the nth repeated application
; of f, which is defined to be the function whose value at x is f (f (...(f (x))...)).
; For example, if f is the function x |-> x + 1, then the nth repeated application of f is the
; function x |-> x + n. If f is the operation of squaring a number, then the nth repeated application of f
; is the function that raises its argument to the 2^n-th power. Write a procedure that takes as inputs a
; procedure that computes f and a positive integer n and returns the procedure that computes
; the nth repeated application of f . Your procedure should be able to be used as follows:
; ((repeated square 2) 5)
; 625

(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (compose f g)
  (lambda (x) (f (g x))))


; Isso é o que eu queria fazer, só consegui vendo a resposta
; O ponto é que eu deveria passar uma função lambda como resposta, mas eu fiquei inclinado a passar (f x) e (f (f x))
(define (repeat f n i)
    (if (< i n)     
        (lambda (x) (f ((repeat f n (+ i 1)) x))) 
        (lambda (x) (f x)) ))

; A versão correta não deveria ter i e sim diminuir n
(define (repeated f n)
    (if (= n 1)     
        (lambda (x) (f x))
        (lambda (x) (f ((repeated f (- n 1)) x))) 
         ))


; Isso funciona, solução parcialmente minha
;(define (repeated f n)
;  (define (repeat f n i x)
;    (if (< i n)     
;        ;(repeat (lambda (x) (f (f x))) n (+ i 1)) ; This doesn't work            
;        (f (repeat f n (+ i 1) x)) ; Isso é o que eu queria fazer, mas não sabia como compor     
;        x
;        )
;  )
;  (lambda (x) (repeat f n 0 x))
;  )

; This solution is not mine
;(define (repeated f n) 
;  (if (= n 1) 
;      f 
;      (compose f (repeated f (- n 1))))) 
;  

((repeat inc 4 1) 0)
((repeat square 2 1) 5)

((repeated inc 4) 0)
((repeated square 2) 5)

;((repeated inc 4) 0)
;((repeated square 2) 5)
