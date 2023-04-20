#lang simply-scheme

; Cube function
(define (cube x) (* x x x ))

; Defining the sum procedure
(define (sum term a next b)
	(if (> a b)
	0
	(+ (term a) (sum term (next a) next b))))

; This is the original approximation
(define (integral f a b dx)
	(define (add-dx x)
		(+ x dx))
	(* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(display "Original: ")
(integral cube 0 1 0.01)


; Simpson's Rule
(define (simpson f a b n)
     (define h (/ (- b a) n))  ; h definition -> h = (b - a) / n, where b, a, and n are all parameters

     (define (inc x) (+ x 1))

     (define (y k)             ; y(k) definition -> y_k = f(a + k·h), where a is a parameter, k is an index, h is a parameter
       (f (+ a (* k h))))

     (define (term k)
        (* (cond ((or (= k 0) (= k n)) 1)
                 ((odd? k) 4)
                 ((even? k) 2))            
           (y k) ))
  (* (/ h 3) (sum term 0 inc n)) )

(display "Simpson : ")
(simpson cube 0 1 100.0)



