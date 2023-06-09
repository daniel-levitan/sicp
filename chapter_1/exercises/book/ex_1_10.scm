#lang simply-scheme

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; --- (define (f n) (A 0 n)) ---
;(A 1 10)
;(A 2 4)
;(A 3 3)

;(A 0 n)
;2 * n
;f(n) = 2·n

; --- (define (g n) (A 1 n)) ---
;(A 1 n)
;(A 0 (A 1 (- n 1)))
;
;(A 0 (A 1 (- n 1)))
;     (A 1 (- n 1))
;     (A 0 (A 1 (- (- y 1) 1)))
;(A 0 (A 0 (A 1 (- (- y 1) 1))))

;(define n 3)
;(A 1 3)
;(A 0 (A 1 2))
;(A 0 (A 0 (A 1 1)))
;(A 0 (A 0 2))
;--> n^2

;(A 1 4)
;(A 0 (A 1 3))
;(A 0 (A 0 (A 1 2)))
;(A 0 (A 0 (A 0 (A 1 1))))
;(A 0 (A 0 (A 0 2)))
;--> n^2

; --- (define (h n) (A 2 n)) ---
;(A 2 2)
(A 2 2) ; (* 2 2)
(A 2 3) ; (* (* 2 2) (* 2 2))
(A 2 4) ; ( * (* (* (* 2 2) (* 2 2)) (* (* 2 2) (* 2 2)) (* (* (* 2 2) (* 2 2)) (* (* 2 2) (* 2 2)))

; h(n) = 2^[h(n-1)] or 2^(2^(2^(2...(n *)))) 

;(define n 3)
;(A 2 3)
;(A 1 (A 2 2))
;(A 1 (A 1 (A 1 1)))
;(A 1 (A 1 2))
;(A 1 (A 0 (A 1 1)))
;(A 1 (A 0 2))
;(A 1 4)
;(A 0 (A 1 3))
;(A 0 (A 0 (A 1 2)))
;(A 0 (A 0 (A 0 (A 1 1))))
;(A 0 (A 0 (A 0 2)))
;(A 0 (A 0 4))
;(A 0 8)
;(* 2 8)

;(trace A)
;(define n 4)
;(A 2 4)

