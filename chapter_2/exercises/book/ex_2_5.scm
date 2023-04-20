#lang simply-scheme

; Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations
; if we represent the pair a and b as the integer that is the product 2^a * 3^b .
; Give the corresponding definitions of the procedures cons, car, and cdr.

(define (square x) (* x x))
(define (divides? a b) (= (remainder a b) 0))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


(define (cons a b)
  (* (fast-expt 2 a) (fast-expt 3 b)))

(define (car z) 
  (define (get_left z count)  
    (cond ((divides? z 3) (get_left (/ z 3) 0))
          ((divides? z 2) (get_left (/ z 2) (+ count 1)))
          (else count) ))
  (get_left z 0))       

(define (cdr z) 
  (define (get_right z count)  
    (cond ((divides? z 2) (get_right (/ z 2) 0))
          ((divides? z 3) (get_right (/ z 3) (+ count 1)))
          (else count) ))
  (get_right z 0)) 


(define z (cons 3 2))
(car z)
(cdr z)
