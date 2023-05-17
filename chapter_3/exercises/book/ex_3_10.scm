#lang simply-scheme

; This is the let version of the code
(define (make-withdraw-v1 initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))


; This is the transformed lambda version after converting from let to lambda
(define (make-withdraw initial-amount)
  ((lambda (balance)  
     (lambda (amount)
       (if (>= balance amount)
           (begin (set! balance (- balance amount))
                  balance)
           "Insufficient funds")))
   initial-amount))

(define w1 (make-withdraw-v1 100))
(w1 6)

(define w (make-withdraw 100))
(w 6)

; This is the procedure object depicted

; global     ┌────────────────────────┐     
; env.   ───>│ make-withdrawal: ─┐    │
;            └───────────────────│────┘
;                                V  ^ 
;                               ◯◯──┘
;                               │
;                               V
;                   parameters: initial-amount                          
;                         body: (lambda (balance)  
;                                  (lambda (amount)
;                                    (if (>= balance amount)
;                                        (begin (set! balance (- balance amount))
;                                               balance)
;                                        "Insufficient funds")))

; And when we call define, this is the picture we have

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-withdrawal: ─────────────────────────────────────────────┐                │
;            │              w1: ──┐                                          │                │
;            └────────────────────│──────────────────────────────────────────│────────────────┘
;                                 │                      ^                   │          ^
;                                 │                      │                   V          │   
;                                 │                      │           parameters: initial-amount    
;                                 │                      │                 body: (lambda (balance) 
;                                 │                      │                         (lambda (amount)
;                                 │                      │          
;                                 │               ┌───────────────────────┐
;                                 │        E1 ───>│ initial-amount: 100   │
;                                 │               └───────────────────────┘
;                                 │                      ^
;                                 │                      │
;                                 │               ┌─────────────────────────┐
;                                 │        E2 ───>│ balance: initial-amount │ (equal to balance: 100)
;                                 │               └─────────────────────────┘
;                                 V        
;                     parameters: amount
;                           body: if...    

; We only have one parameter (amount) in this procedure when it is related to E2
; If we were looking at E1, the body would be: (lambda (amount)...)
; At each level we evaluate one parameters and, consequently, we have one lambda function less

; When the function is executed with amount 50 [(w1 50)], we have:

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-withdrawal: ─────────────────────────────────────────────┐                │
;            │              w1: ──┐                                          │                │
;            └────────────────────│──────────────────────────────────────────│────────────────┘
;                                 │                      ^                   │          ^
;                                 │                      │                   V          │   
;                                 │                      │           parameters: initial-amount    
;                                 │                      │                 body: (lambda (balance) 
;                                 │                      │                         (lambda (amount)
;                                 │                      │          
;                                 │               ┌───────────────────────┐
;                                 │        E1 ───>│ initial-amount: 100   │
;                                 │               └───────────────────────┘
;                                 │                      ^
;                                 │                      │
;                                 │               ┌──────────────┐
;                                 │        E2 ───>│ balance: 100 │ 
;                                 │               └──────────────┘
;                                 V                     ^
;                     parameters: amount                │
;                           body: if...                 │
;                                                       │
;                                                ┌────────────┐
;                                         E3 ───>│ amount: 50 │
;                                                └────────────┘

; The result of this call is

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-withdrawal: ─────────────────────────────────────────────┐                │
;            │              w1: ──┐                                          │                │
;            └────────────────────│──────────────────────────────────────────│────────────────┘
;                                 │                      ^                   │          ^
;                                 │                      │                   V          │   
;                                 │                      │           parameters: initial-amount    
;                                 │                      │                 body: (lambda (balance) 
;                                 │                      │                         (lambda (amount)
;                                 │                      │          
;                                 │               ┌───────────────────────┐
;                                 │        E1 ───>│ initial-amount: 100   │
;                                 │               └───────────────────────┘
;                                 │                      ^
;                                 │                      │
;                                 │               ┌─────────────┐
;                                 │        E2 ───>│ balance: 50 │ 
;                                 │               └─────────────┘
;                                 V                      
;                     parameters: amount                 
;                           body: if...                  

; Now, if w2 is define, we have

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-withdrawal: ...                                                           │
;            │              w2: ────────────────────────────────────────────┐                 │
;            │              w1: ──┐                                         │                 │
;            └────────────────────│─────────────────────────────────────────│─────────────────┘
;                                 │                      ^                  │              ^                   
;                                 │                      │                  │              │                   
;                                 │                      │                  │              │                   
;                                 │                      │                  │              │                   
;                                 │                      │                  │              │                   
;                                 │                      │                  │              │                   
;                                 │               ┌──────────────────────┐  │        ┌──────────────────────┐   
;                                 │        E1 ───>│ initial-amount: 100  │  │ E3 ───>│ initial-amount: 100  │   
;                                 │               └──────────────────────┘  │        └──────────────────────┘   
;                                 │                      ^                  │              ^                   
;                                 │                      │                  │              │                   
;                                 │               ┌─────────────┐           │        ┌──────────────┐            
;                                 │        E2 ───>│ balance: 50 │           │ E4 ───>│ balance: 100 │            
;                                 │               └─────────────┘           │        └──────────────┘            
;                                 │                      ^                  │               ^
;                                @=@─────────────────────┘                 @=@──────────────┘
;                                │                                         │
;                                │,────────────────────────────────────────┘
;                                │
;                                │ 
;                                V
;                     parameters: amount                 
;                           body: if...                  
