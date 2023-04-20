#lang simply-scheme

; Define a procedure cubic that can be used together with the newtons-method procedure in expressions
; of the form (newtons-method (cubic a b c) 1) to approximate zeros of the cubic x^3 + ax^2 + bx + c.

; Fixed point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; Derivative
(define dx 0.00001)

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

; Newton's transform
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

; Newton's method
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

; x^3 + ax^2 + b^x + c.
(define (square x) (* x x))
(define (cube x) (* x (square x)))

; Não é asim que ele quer
;(define (cubic a b c x)
;  (newtons-method (lambda (x) (+ (cube x) (* a (square x)) (* b x) c) ) 1.0))
;(cubic 1 2 3 1.0)


(define (cubic a b c)
  (lambda (y) (+ (cube y) (* a (square y)) (* b y) c)))

(newtons-method (cubic 1 2 3) 1)
(newtons-method (cubic 3 -2.4 6) 1)
