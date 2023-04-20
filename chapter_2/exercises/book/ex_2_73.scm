#lang simply-scheme

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (make-sum a1 a2) (list '+ a1 a2))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))
(define (make-product m1 m2) (list '* m1 m2))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

; Definitions using data-directed programming
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


; -- Tests
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)


(define (install-derivatives)

  ;; internal procedures
  (define (sum addend augend)
    (make-sum (deriv (addend exp) var) (deriv (augend exp) var)))

  (define (product multiplier multiplicand)
    (make-sum (make-product (multiplier exp)
                            (deriv (multiplicand exp) var))
              (make-product (deriv (multiplier exp) var)
                            (multiplicand exp))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'deriv x))

  (put '+ '(deriv) sum)
  (put '* '(deriv) product)

 
  
'done)


; a) Instead of having a condition for every transaction type, we can have a general rule to apply
;    any operation to the arguments.
;    number? and variable? are tests that are not operations. We are not applying an operation to the arguments
; b) Write the procedures for derivatives of sums and products,
;    and the auxiliary code required to install them in the table used by the program above.
