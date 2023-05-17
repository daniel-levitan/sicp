;#lang simply-scheme

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (display "Begin") (newline)
          (display "y ") (display y) (newline)
          (display "x ") (display x) (newline)
          (display "temp ") (display temp) (newline)
          (set-cdr! x y)
          (display "x ") (display x) (newline)
          (loop temp x))))
  (loop x '()))


(define v (list 'a 'b 'c 'd))

(define w (mystery v))

; -- Answer

; This is the result we get in w: (d c b a)
; That means that the procedure inverts a list, let's see how it works.

; The body of the mistery procedure is loop called for x with y set as the empty list '()

; Let's now analyze what loop does.
; At each step, x, which at the beginning is the full list, gets its cdr changed to y
; At the beginning y is the empty list '(), and y gets the value of cdr of x, we use a temp
; variable to get the cdr of x
; So at each step, x get its cdr set to y, but, at each step, x is set to be its own cdr, meaning
; that at the last step, x is the last element, and all others are inverted