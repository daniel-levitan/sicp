#lang simply-scheme
(define (make-account balance password)
  (let ((counter 0))
    (define (withdraw amount)
      (if (<= amount balance)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient balance"))
  
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)

    (define (incorrect x)
      (set! counter (+ counter 1))
      (if (< counter 7) 
          "Incorrect password"
          "Call the cops"))
  
    (define (dispatch p m)
      (if (eq? p password)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else 'wrong-function))                                
          incorrect))
    dispatch))

; -- test 1
(define acc (make-account 100 '1234))
((acc '1234 'deposit) 27)
((acc '1234 'withdraw) 200)
((acc '1234 'withdraw) 20)

((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
((acc '123 'my-message-2) 100)
