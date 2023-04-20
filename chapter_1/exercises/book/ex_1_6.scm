#lang simply-scheme

(define (new-if predicate then-clause else-clause)
     (cond (predicate then-clause)
     (else else-clause)))

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))
(define (improve guess x) (average guess (/ x guess)))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))



(define (sqrt-iter-new guess x)
  (new-if (good-enough? guess x) 
          guess
          (sqrt-iter-new (improve guess x) x)))



(define (sqrt-iter guess x)
  (cond ((good-enough? guess x) guess)
        (sqrt-iter (improve guess x) x)
   ))

;(new-if (= 2 3) 'a 'b)
;(new-if (= 1 1) 'a 'b)

;(define (sqrt x) (sqrt-iter 1.0 x))
;(sqrt 9)

(define (sqrt x) (sqrt-iter-new 1.0 x))
(trace sqrt)
(trace sqrt-iter-new)
(trace new-if)
;(trace good-enough?)
(sqrt 9)


; Below we see the sequence of operations. What happens is that the new-if is an operations that gets it
; operands evaluated whenver it is called. That means that the arguments for the if are evaluated: predicated,
; then-clause, and the else-clause. Since the else-clause is a call to the process that called the if clause,
; we enter an infinite loop.
;
; If we use the cond expression instead of created a procedure that uses it, we are able to escape the infinite
; loop, and still get the results we would had we used the if construct.

;>(sqrt 9)
;>(sqrt-iter 1.0 9)
;> (sqrt-iter 5.0 9)
;> >(sqrt-iter 3.4 9)
;> > (sqrt-iter 3.023529411764706 9)
;> > >(sqrt-iter 3.00009155413138 9)
;> > > (sqrt-iter 3.000000001396984 9)
;> > > >(sqrt-iter 3.0 9)
;> > > > (sqrt-iter 3.0 9)
;> > > > >(sqrt-iter 3.0 9)
;> > > > > (sqrt-iter 3.0 9)
;> > > >[10] (sqrt-iter 3.0 9)
;> > > >[11] (sqrt-iter 3.0 9)
;> > > >[12] (sqrt-iter 3.0 9)
;> > > >[13] (sqrt-iter 3.0 9)