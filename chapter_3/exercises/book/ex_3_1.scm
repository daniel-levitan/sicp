#lang simply-scheme

; An accumulator is a procedure that is called repeatedly with a single numeric argument and accumulates
; its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure
; make-accumulator that generates accumulators, each maintaining an independent sum. The input to make-accumulator
; should specify the initial value of the sum. for example
; (define A (make-accumulator 5))
; (A 10)
; 15
; (A 10)
; 25

; Let aqui não me ajuda já que o valor é passado por parâmetro
(define (make-accumulator initial-value)
  (let ((s initial-value))
    (lambda (value)
      (begin (set! s (+ s value))
             s))))

; Nessa versão eu não preciso de let
(define (make-accumulator-2 initial-value)
  (lambda (value)
     (begin (set! initial-value (+ initial-value value))
            initial-value)))

(define acc1 (make-accumulator 0))
(acc1 2)
(acc1 7)

(define acc1-2 (make-accumulator-2 0))
(acc1-2 2)
(acc1-2 7)

(define acc2 (make-accumulator 10))
(acc2 27)