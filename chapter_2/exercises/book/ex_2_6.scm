#lang simply-scheme

; Não entendi o que zero significa
(define zero (lambda (f) (lambda (x) x)))
; Isso é a representação de zero nesse universo, 0 ocorre quando uma 

; It's important to note that the definition for zero above does not evaluate to the integer 0,
; it is just a representation for 0.
; The procedure zero represents the integer 0 by returning a procedure that applies its input procedure zero times. 

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Let's substitute to see what we get
;(lambda (f) (lambda (x) (f ( (n f) x) ) ) )
;(lambda (f) (lambda (x) (f ( (zero f) x) ) ) )

;(lambda (f) (lambda (x) (f ( ( ( lambda (f) ( lambda (x) x ) ) f ) x) ) ) )
;                                \___________________________/
;                                         zero
;(lambda (f) (lambda (x) (f ( ( ( lambda (f) ( lambda (x) x ) ) f ) x) ) ) )
;                              \_________________________________/
;                                  = lambda (x) x for x == f -> ( lambda (x) x )

;(lambda (f) (lambda (x) (f ( ( lambda (x) x ) x ) ) ) )
;                            \__________________/
;                                     x
;(lambda (f) (lambda (x) (f ( ( lambda (x) x ) x ) ) ) )
; (lambda (f) (lambda (x) (f x ) ) ) or (lambda (f) (lambda (x) (f x)))


(trace add-1)
(add-1 zero)