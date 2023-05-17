#lang simply-scheme


(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))


; a)
; 10^6: P1 and then P2 or P2 and then P1
; 10^3: P1 reads x, P2 reads x, P1 sets x^2, P2 sets x^3
; 10^2: P1 reads x, P2 reads x, P2 sets x^3, P1 sets x^2
; 10^4: P1 reads x (10), P2 reads x (10), P2 sets x^3, P1 reads x (10^3), P1 sets 10 x 10^3
; 10^5: P1 reads x (10), P2 reads x (10), P1 sets x^2, P2 reads the new x twice
;       or P1 reads x (10), P2 reads x (10), P1 sets x^2, P2 reads the new x

; b)
; Now the only possibility is 10^6

