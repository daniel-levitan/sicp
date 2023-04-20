#lang simply-scheme

(define (f x)
  (+ (* 2 x) 1))

(define dx 0.00001)
(define (smooth f)
  (lambda (x) (/ (+ (f x) (f (+ x dx)) (f (- x dx))) 3)) )

(define (repeated f n)
    (if (= n 1)     
        (lambda (x) (f x))
        (lambda (x) (f ((repeated f (- n 1)) x))) 
         ))


(define (n-fold-smooth f n)
  (repeated (smooth f) n))


; Tests

((repeated (smooth f) 2) 2)
((n-fold-smooth f 2) 2)