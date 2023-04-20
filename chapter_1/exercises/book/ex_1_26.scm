#lang simply-scheme

;Louis Reasoner is having great difficulty doing Exercise 1.24. His fast-prime? test seems to run more
; slowly than his prime? test. Louis calls his friend Eva Lu Ator over to help. When they examine Louis’s code, they
; find that he has rewrien the expmod procedure to use an explicit multiplication, rather than calling square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base
                       (expmod base (- exp 1) m))
                    m))))

; “I don’t see what difference that could make,” says Louis. “I do.” says Eva. “By writing the procedure
; like that, you have transformed the  (logn) process into a  (n) process.” Explain.

; Now remainder calls expmod twice, so, instead of halving the size of the problem, he created a recursion tree.
; We could have lead to think that the problem is only doubling in size, since we start making 2 calls to each case.
; But each of these 2 calls will make another 2 calls, so this is growing exponentially. We have log 2^n, which is n.