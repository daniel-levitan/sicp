#lang simply-scheme
; Demonstrate that the Carmichael numbers listed in Footnote 1.47 really do fool the Fermat test. That is,
; write a procedure that takes an integer n and tests whether a^n is congruent to a modulo n for every a < n, and try your
; procedure on the given Carmichael numbers.
; 561, 1105, 1729, 2465, 2821, and 6601

; Fermat's Little Theorem: If n is a prime number and a is any positive integer less than n, then a raised to the nth
; power is congruent to a modulo n.

; This means that (a^n) % n === a. Modulo congruent. So I need to test every a from a to n. If any of the a's gives me
; a different number than a after elevating to the power of n and taking the modulo, then this is not a carmichael number.
; Prime numbers will also pass the test.

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

; First method: go over the fermat test knowing those numbers will pass when they shouldn't
(define (fermat-test n a)
   (= (expmod a n n) a))

(define (fermat-full n)
   (define (iter a)
     (cond ((= a 1) #t)
           ((not (fermat-test n a)) #f)
           (else (iter (- a 1)))))
   (iter (- n 1)))


; Second method: 
(define (carmichael a n)
  (cond ((= n a) #t)  ; Got to the end of the search
        ((= (expmod a n n) a) (carmichael (+ 1 a) n)) ; Let's try the next a to check if a^n % n is not a
        (else #f) ; n is not a, aˆn % n is not a, fails as a carmichael number
        ))


;561, 1105, 1729, 2465, 2821, and 6601
;(trace carmichael)
(carmichael 1 561)
;(carmichael 1 1105)
;(carmichael 1 1729)

; (2**561) % 561 === 2 % 561
;(fermat-full 561)


