#lang simply-scheme

; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced 
; with is using applicativeorder evaluation or normal-order evaluation. He defines the
; following two procedures:

(define (p) (p))
	(define (test x y)
		(if (= x 0) 0 y))
		
;Then he evaluates the expression

(test 0 (p))

; What behavior will Ben observe with an interpreter that uses applicative-order evaluation? 
; What behavior will he observe with an interpreter that uses normal-order evaluation?

; Explain your answer. (Assume that the evaluation rule for the special form if is 
; the same whether the interpreter is using normal or applicative order: The predicate
; expression is evaluated first, and the result determines whether to evaluate the 
; consequent or the alternative expression.)


; Answer:
; In normal order evaluation, the interpreter expand the terms and then reduce them
; In applicative order evaluation, the interpreter evaluates operator and operands and 
; apply the results to the rest of the arguments

; If we first try to expand, x would be substituted by 0. When the interpreter checks this 
; condition, it is evaluated to true and then the return result is 0.
;
; In the other hand, for the applicative order evaluation, the interpreter would try to
; evaluate every term, but (p) is not resolved and the interpreter enter an infinite loop.

