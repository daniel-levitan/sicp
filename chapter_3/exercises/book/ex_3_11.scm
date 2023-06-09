#lang simply-scheme


(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else
           (error "Unknown request: MAKE-ACCOUNT"
                  m))))
  dispatch)

; a) Show the environment structure generated by the sequence of interactions
;(define acc (make-account 50))
;((acc 'deposit) 40)
;90
;((acc 'withdraw) 60)
;30


; This depicts the call to (define acc (make-account 50))

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-account: ──┐                                                              │
;            │          acc: ──│─────────────────────────────┐                                │
;            └─────────────────│─────────────────────────────│────────────────────────────────┘
;                              │    ^                        │                      
;                              v    │                        │                      
;                     ┌───────@=@───┘                        v             ┌─────────────────────┐
;                     │                                     @=@     E1 ───>│ balance: 50         │
;                     v                                     │ │            │ withdrawal: ───┐    │
;            parameter: balance                             │ │            │ deposit: ...   │    │
;                 body: (define withdraw ...)               │ │            │ dispatch: ...  │    │
;						(define deposit)                    │ │            └────────────────│────┘     
;						(define dispatch...                 │ │                  ^          │  ^
;						  dispatch)                         │ └──────────────────┘          v  │
;                                                           │                              @=@─┘
;                                                           │                              │ 
;                                                           │                              │
;                                                           v                              v
;                                                  parameters: balance                   parameters: amount
;                                                        body: (define withdraw ...)           body: (if ...)
;                                                              (define deposit ...)
;                                                              (define dispatch ...
;                                                                dispatch)


; This depicts the call to ((acc 'deposit 40))

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-account: ──┐                                                              │
;            │          acc: ──│─────────────────────────────┐                                │
;            └─────────────────│─────────────────────────────│────────────────────────────────┘
;                              │    ^                        │                      
;                              v    │                        │                      
;                     ┌───────@=@───┘                        v             ┌─────────────────────┐
;                     │                                     @=@     E1 ───>│ balance: 90         │<─────────────┐ 
;                     v                                     │ │            │ withdrawal: ...     │          ┌──────────────┐                     
;            parameter: balance                             │ │            │ deposit: ──────┐    │   E3 ───>│ m: 'dispatch │
;                 body: (define withdraw ...)               │ │            │ dispatch: ...  │    │          └──────────────┘
;						(define deposit)                    │ │            └────────────────│────┘              ^
;						(define dispatch...                 │ │                  ^          │                   │            
;						  dispatch)                         │ └──────────────────┘          v               ┌──────────────┐
;                                                           │                              @=@       E2 ───>│ amount: 40   │
;                                                           │                              │ │              └──────────────┘
;                                                           │                              │ │                  ^ 
;                                                           v                              v └──────────────────┘
;                                         parameters: balance                 parameters: amount      
;                                               body: (define withdraw ...)         body: (set! ...)    
;                                                     (define deposit ...)
;                                                     (define dispatch ...
;                                                        dispatch)


; This depicts the call to ((acc 'withdrawal 30))

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-account: ──┐                                                              │
;            │          acc: ──│─────────────────────────────┐                                │
;            └─────────────────│─────────────────────────────│────────────────────────────────┘
;                              │    ^                        │                      
;                              v    │                        │                      
;                     ┌───────@=@───┘                        v             ┌─────────────────────┐
;                     │                                     @=@     E1 ───>│ balance: 60         │<─────────────┐ 
;                     v                                     │ │            │ withdrawal: ───┐    │          ┌────────────────┐                     
;            parameter: balance                             │ │            │ deposit: ...   │    │   E5 ───>│ m: 'withdrawal │
;                 body: (define withdraw ...)               │ │            │ dispatch: ...  │    │          └────────────────┘
;						(define deposit)                    │ │            └────────────────│────┘              ^
;						(define dispatch...                 │ │                  ^          │                   │            
;						  dispatch)                         │ └──────────────────┘          v               ┌──────────────┐
;                                                           │                              @=@       E4 ───>│ amount: 30   │
;                                                           │                              │ │              └──────────────┘
;                                                           │                              │ │                  ^ 
;                                                           v                              v └──────────────────┘
;                                         parameters: balance                 parameters: amount      
;                                               body: (define withdraw ...)         body: (if ...)    
;                                                     (define deposit ...)
;                                                     (define dispatch ...
;                                                        dispatch)


; Where is the local state for acc kept? Suppose we define another account (define acc2 (make-account 100))

; The local state is store for the first definition on E1. If we have now another acc, acc2, we will have
; another Environment, let's call it E6, in which this value will be stored.

; global     ┌─────────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│ make-account: ──┐                                                                   │
;            │          acc: ──│────────────────────┐                                              │
;            │         acc2: ──│────────────────────│───────────────────────────────────────────┐  │
;            └─────────────────│────────────────────│───────────────────────────────────────────│──┘         ┌─────────────────────┐
;                              │    ^               │                                           │     E2 ───>│ balance: 100        │
;                              v    │               │                                           v            │ withdrawal: ...     │
;                     ┌───────@=@───┘               v             ┌─────────────────────┐      @=@           │ deposit: ...        │
;                     │                            @=@     E1 ───>│ balance: 60         │      │ │           │ dispatch: ...       │
;                     v                            │ │            │ withdrawal: ...     │      │ │           └─────────────────────┘
;            parameter: balance                    │ │            │ deposit: ...        │      │ │                  ^
;                 body: (define withdraw ...)      │ │            │ dispatch: ...       │      │ └──────────────────┘ 
;                       (define deposit)           │ │            └─────────────────────┘      │
;                       (define dispatch...        │ │                  ^                      v
;                         dispatch)                │ └──────────────────┘                parameters: balance           
;                                                  │                                           body: (define withdraw ...)
;                                                  │                              
;                                                  │                              
;                                                  v                              
;                                         parameters: balance                 
;                                               body: (define withdraw ...)   
;                                                     (define deposit ...)
;                                                     (define dispatch ...
;                                                        dispatch)
