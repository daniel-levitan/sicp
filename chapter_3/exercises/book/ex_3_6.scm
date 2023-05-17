#lang simply-scheme

; It is useful to be able to reset a random-number generator to produce a sequence starting from a given value.
; Design a new rand procedure that is called with an argument that is either the symbol generate or the symbol
; reset and behaves as follows: (rand 'generate) produces a new random number; ((rand 'reset) ⟨new-value ⟩) resets
; the internal state variable to the designated ⟨new-value ⟩.
; Thus, by resetting the state, one can generate repeatable sequences.
; These are very handy to have when testing and debugging programs that use random numbers.


;(define rand (let ((x random-init))
;               (lambda ()
;                 (set! x (rand-update x))
;                 x)))

(define random-init 0) 
(define (rand-update x) (+ x 1)) 


(define (rand)
  (let ((x random-init))
    
    (define (generate)
      (begin (set! x (rand-update x))
             x))
    (define (reset value)
      (begin (set! x value)
             x))
    
    (define (dispatch m)
      (cond ((eq? m 'generate) (generate))
            ((eq? m 'reset) reset)
            (else (error "Unknown request: " m))))
  dispatch))

(define c (rand))
;(c 'generate)
( (c 'reset) 5)
(c 'generate)
(c 'generate)
