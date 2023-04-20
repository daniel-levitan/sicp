#lang simply-scheme

; Design a procedure that evolves an iterative exponentiation process that uses successive squaring
; and uses a logarithmic number of steps, as does fast-expt. (Hint: Using the observation that [b^(n/2)]^2 = (b^2)^(n/2), keep,
; along with the exponent n and the base b, an additional state variable a, and define the state transformation in such
; a way that the product (ab)^n is unchanged from state to state. At the beginning of the process a is taken to be 1, and the
; answer is given by the value of a at the end of the process. In general, the technique of defining an invariant quantity
; that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

; The idea here is to keep a third variable (accumulator) to be recording what is happening while
; we work our way through the solution.
; As mentioned in the book we can keep the product accumulator * base^n constant.

; For the even case, whenever we divide the exponent by two, we need to square the base, meaning that
; at every iteration the base  will be power of two of the previous base.
; It's here that the (b^n/2)^2 = (b^2)^n/2 gets in.
; For the odd case, we need to correct the accumulator by multiplying it by b (base)
; Note that any correction (from odd to even) will happen early in the algorithm and at the last step (n = 1 -> 0)

; The important point here is that for the even case we don't change the accumulator at all, we just change the
; base as a consequence of changing the exponent.
;
; Here is the evolution for the even case:
;
;    b    n   acc     acc * b^n
;   (2    4    1)       1 * 2^4
;   (4    2    1)       1 * 4^2
;   (16   1    1)       1 * 16^1
;   (16^0 0    16)      1 * 2^4

; Here is the evolution for the odd case
;
;    b    n   acc     acc * b^n
;   (2    5    1)       1 * 2^5
;   (2    4    2)       2 * 2^4
; From this point on, everything is equal to the example above

(define (square x) (* x x))

(define (exp-iter b n a)
  (if (= n 0)
      a
      (if (even? n)
          (exp-iter (square b) (/ n 2) a)
          (exp-iter b (- n 1) (* a b))
          )
      ))

; Preciso passar a base para os parâmetros b e a.
(define (exp-iter-2 b n a)
  (if (= n 1)
      a
      (if (even? n)
          (exp-iter-2 (square b) (/ n 2) (* a b))
          (* b (exp-iter-2 (square b) (/ (- n 1) 2) (* a b))) )))

(define (exp-iter-3 b n acc)
  (cond ((= n 0) acc)
        ((even? n) (exp-iter-3 (square b) (/ n 2) acc))
        (else (exp-iter-3 (square b) (/ (- n 1) 2) (* acc b)))))


;(exp-iter-2 4 8 4)
;(exp-iter-2 4 3 4)
;(trace exp-iter)
;(exp-iter 4 8 1) ; ->  65536
;(exp-iter 4 3 1) ; -> 8
;(expt 2 8)
(exp-iter 2 8 1)
(exp-iter-2 2 8 2)
(exp-iter-3 2 8 1)
