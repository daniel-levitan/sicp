#lang simply-scheme

; This exercise has its explanation in a footnote on page 68:
; Thee reduction steps in the cases where the exponent e is greater than 1 are based
; on the fact that, for any integers x, y, and m, we can find the remainder of x times y
; modulo m by computing separately the remainders of x modulo m and y modulo m,
; multiplying these, and then taking the remainder of the result modulom. For instance,
; in the case where e is even, we compute the remainder of b^(e/2) modulo m, square this,
; and take the remainder modulo m. This technique is useful because it means we can
; perform our computation without ever having to deal with numbers much larger than m.

; Although correct, the algorithm takes more time.



(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


(define (expmod-alt base exp m)
  (remainder (fast-expt base exp) m))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m)) ))


(define (runtime) (current-milliseconds))

(define (report-elapsed-time start-time) 
  (display " *** ") 
  (display (- (runtime) start-time))
  (newline))


; Test 1: Checking the squares generated
; (define (square m)  
;   (display "square ")(display m)(newline) 
;   (* m m)) 

;(expmod 5 101 101)
;(expmod-alt 5 101 101)


; Test 2: Measuring time

(define (square x) (* x x ))

(define start-time-1; (runtime)) 
(expmod 999999 1000000 1000000)
(report-elapsed-time start-time-1)

(define start-time-2 (runtime)) 
(expmod-alt 999999 1000000 1000000)
(report-elapsed-time start-time-2)

; Confirming both generate the correct result
  
;(define n 100)
;(define base (random n))
;(define exp (random n))
;(define m (random n))

;(expmod base exp m)
;(expmod-alt base exp m)