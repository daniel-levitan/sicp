#lang simply-scheme

;Observe that our model of evaluation allows for combinations whose operators are compound expressions.
; Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
   ((if (> b 0) + -) a b))

; If b > 0, we get the addition of a and b, if b < 0, we get the subtraction between a and b,
; which gives us a + b in any case.
; This is, as the name states, the sum of a and the absolute value of b.

(a-plus-abs-b 2 4)
(a-plus-abs-b 5 -3)