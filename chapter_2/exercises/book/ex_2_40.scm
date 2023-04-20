#lang simply-scheme

; Define a procedure unique-pairs that, given an integer n, generates the sequence of pairs (i, j) with
; 1 <= j < i <= n. Use unique-pairs to simplify the definition of prime-sum-pairs given above.

; Prime definitions
(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)  
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))


(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))


(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)) )  ))


(define (unique-pairs n) 
  (accumulate
   append '() (map (lambda (i)
                     (map (lambda (j) (list i j))
                          (enumerate-interval 1 (- i 1))))
                   (enumerate-interval 1 n))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))


;(unique-pairs 4)

;(define (prime-sum-pairs n)
;  (map make-pair-sum
;       (filter prime-sum? (flatmap
;                           (lambda (i)
;                             (map (lambda (j) (list i j))
;                                  (enumerate-interval 1 (- i 1))))
 ;                          (enumerate-interval 1 n)))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))


(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum? (unique-pairs n))))

(define n 4)
(filter prime-sum? (unique-pairs n))
(prime-sum-pairs n)

; They generate the same pairs (prime-sum-pairs adds the sum)