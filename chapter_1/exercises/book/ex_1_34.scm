#lang simply-scheme

(define (square x) (* x x))

(define (f g) (g 2))

(f square)

(f (lambda (z) (* z (+ z 1))))

(f f)

; application: not a procedure;
; expected a procedure that can be applied to arguments
;  given: 2

; When we gave a function/procedure to f, it evaluates the function g for the input 2.
; In the case of a square procedure, we get the square of 2
; In the case we give f as the argument, we have
; (f f)
; (f 2)
; (2 2)
; So what we see is that the interpreter first applies the argument f to the definition g 2,
; and we get (f 2)
; Now the interpreter has (f 2), and it tries to compute (2 2), and that returns the error.
; It was expecting the argument to be applied to a function, not a number.