#lang simply-scheme

; Modify the make-account procedure so that it creates password-protected accounts. That is, make-account
; should take a symbol as an additional argument, as in
; (define acc (make-account 100 'secret-password))
; The resulting account object should process a request only if it is accompanied by the password with which the account
; was created, and should otherwise return a complaint:

; ((acc 'secret-password 'withdraw) 40)
; > 60
;((acc 'some-other-password 'deposit) 50)
; > "Incorrect password"

(define (make-account balance password)
  (define (withdraw amount)
    (if (<= amount balance)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient balance"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (dispatch p m)
    (if (eq? p password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else 'wrong-function))
          (lambda x "Incorrect Password")))   ; Instead of writing a function to treat it, lambda can handle it
  dispatch)

; -- test 1
(define acc (make-account 100 '1234))
((acc '1234 'deposit) 27)
((acc '1234 'withdraw) 200)
((acc '1234 'withdraw) 20)

((acc '123 'my-message-2) 100)