#lang simply-scheme

; a)
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))


; global     ┌──────────────────┐
; env.   ───>│ factorial: ─┐    │
;            └─────────────│────┘
;                          V  ^ 
;                         ◯◯──┘
;                         │
;                         V
;             parameters: n
;                   body: (if (= n 1)
;                             1
;                             (* n (factorial (- n 1))))


; global     ┌──────────────────┐
; env.   ───>│                  │
;            └──────────────────┘
;               ^
;               │   
;           ┌──────┐            
;    E1 ───>│n: 6  │
;           └──────┘
;
; From here, we add all other environments

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│                                                                                │
;            └────────────────────────────────────────────────────────────────────────────────┘
;               ^                  ^                  ^                       ^    
;               │                  │                  │                       │    
;           ┌──────┐           ┌──────┐           ┌──────┐                ┌──────┐             
;    E1 ───>│n: 6  │    E2 ───>│n: 5  │    E3 ───>│n: 4  │   ...   E6 ───>│n: 1  │ 
;           └──────┘           └──────┘           └──────┘                └──────┘ 
;     (factorial 6)          (factorial 5)         (factorial 4)          1       
;     (* 6 (factorial 5))    (* 5 (factorial 4))   (* 4 (factorial 3))    
;
;
; b) 
(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter produt counter max-count)
  (if (> counter max-count)
       product
       (fact-iter (* counter product) (+ counter 1) max-counter)))

; global     ┌────────────────────────────────────────────┐
; env.   ───>│ factorial: ─────────────────────────┐      │
;            │ fact-iter: ─┐                       │      │
;            └─────────────│───────────────────────│──────┘
;                          V  ^                    V  ^ 
;                         ◯◯──┘                   ◯◯──┘
;                         │                       │              
;                         V                       V              
;             parameters: product,                parameters: n       
;                         counter,                      body: (fact-iter 1 1 n)      
;                         max-count                           
;                   body: (if (> counter-max...)        

; global     ┌────────────────────────────────────────────────────────────────────────────────┐
; env.   ───>│                                                                                │
;            └────────────────────────────────────────────────────────────────────────────────┘
;               ^                     ^                          ^                                 ^         
;               │                     │                          │                                 │         
;           ┌──────┐           ┌──────────────┐           ┌──────────────┐                  ┌──────────────┐ 
;    E1 ───>│n: 6  │    E2 ───>│product:   1  │    E3 ───>│product:   1  │           E8 ───>│product:  720 │ 
;           └──────┘           │counter:   1  │           │counter:   2  │                  │counter:   7  │ 
;     (factorial 6)            │max-count: 6  │           │max-count: 6  │                  │max-count: 6  │                   
;     (fact-iter 1 1 n)        └──────────────┘           └──────────────┘                  └──────────────┘    
;                              (fact-iter 1 1 6)          (fact-iter 1 2 6)                 720   