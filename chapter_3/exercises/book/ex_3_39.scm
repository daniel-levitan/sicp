#lang simply-scheme

;101: P1 sets x to 100 and then P2 increments x to 101.
;121: P2 increments x to 11 and then P1 sets x to x * x.
;110: P2 changes x from 10 to 11 between the two times that
;     P1 accesses the value of x during the evaluation of (* x x).
; 11: P2 accesses x, then P1 sets x to 100, then P2 sets x.
;100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.

(define x 10)
(define s (make-serializer))
(parallel-execute
 (lambda () (set! x ((s (lambda () (* x x)))))) ; P1
 (s (lambda () (set! x (+ x 1)))))              ; P2

; The two results below are still possible
; 101
; 121

; Now let's see the less obvious
; 1. Protected part of P1 runs, then P2 runs, and then P1 set the result of it's calculation: 100

; I'm not sure that P1 can happen between P2 accessing and setting it, it may be the case
; because the setting part of P1 is not protected
; 2. The other possibility is for P1 to access x and calculate the result of x times x, 100
;    P2 access x
;    P1 sets x to 100 -> This event can happen in between the access and setting because it's not protected
;    P2 calculates x + 1
;    P2 sets x to 11
     

; 110 and 11 cannot be generated since 