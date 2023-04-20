; The process that a procedure generates is of course dependent on the rules used by the interpreter.
;As an example, consider the iterative gcd procedure given above. Suppose we were to interpret this procedure using
; normal-order evaluation, as discussed in Section 1.1.5. (The normal-order-evaluation rule for if is described in Exercise
; 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating (gcd 206 40) and
; indicate the remainder operations that are actually performed. How many remainder operations are actually performed
; in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?


; Assume that the evaluation rule for the special form if is the same whether the interpreter
; is using normal or applicative order: the predicate expression is evaluated first, and the result determines
; whether to evaluate the consequent or the alternative expression.)


(define (gcd a b)
	(if (= b 0)
	a
	(gcd b (remainder a b))))


; Normal-order
;=> (gcd 206 40)

	(gcd 206 40)
		(if (= 40 0) ; (= 40 0)
		206
		(gcd 40 (remainder 206 40)))
; 0 operation
		

; => (gcd 40 (remainder 206 40))
	(gcd 40 (remainder 206 40))
		(if (= (remainder 206 40) 0) 
		;(if (= 6 0) ; -> Translation from the line above
		40
		(gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
; Above we have 1 operation (if question)


; => (gcd (remainder 206 40) (remainder 40 (remainder 206 40))
	(gcd (remainder 206 40) (remainder 40 (remainder 206 40))) 
		(if (= (remainder 40 (remainder 206 40)) 0)   ;(= 4 0)
		; (if (= 4 0) ; -> Translation from the line above
		(remainder 206 40)
		(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
; Above we have 2 remainder operations evaluated


(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
	(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)   ;(= (rem 6 4) 0) -> (= 2 0)
	(if (= 2 0)   ; -> Translation from the line above
	(remainder 40 (remainder 206 40))
	(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
; Above we have 4 remainder operations (if question) 

(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
	(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
	(if (= 0 0))
	(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ; This is the result -> 2
	(gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
; Above we have 7 remainder operations on the if question and 4 to calculate the result (first branch of if)
; In total we have 18 remainder operations: 1 + 2 + 4 + 11 = 18

; Applicative order
(gcd 206 40)
(gcd 40 (remainder 206 40))
(gcd 40 6)
(gcd 6 (remainder 40 6))
(gcd 6 4)
(gcd 4 (remainder 6 4))
(gcd 4 2)
(gcd 2 (remainder 4 2))
(gcd 2 0)
> 2

