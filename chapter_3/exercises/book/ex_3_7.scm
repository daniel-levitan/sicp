#lang simply-scheme
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


(define (make-joint account original-password this-acc-password)
  (define (dispatch p m)
    (if (eq? p this-acc-password)
        (cond ((eq? m 'withdraw) (account original-password 'withdraw))
              ((eq? m 'deposit) (account original-password 'deposit))
              (else 'wrong-function))
        (lambda (x y) "Incorrect password")
        )
    )
  dispatch
  
  )
; -- test
; Original account definition
(define peter-acc (make-account 100 'open-sesame))
((peter-acc 'open-sesame 'deposit) 1)

; New joint account
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
((paul-acc 'rosebud 'withdraw) 1)
((paul-acc 'rosebud 'deposit) 5)