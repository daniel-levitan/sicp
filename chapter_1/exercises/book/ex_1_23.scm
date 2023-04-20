#lang simply-scheme

; --- Prime definitions ---
(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
        ;(else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))
(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

; --- Timing an operation definitions ---
(define (runtime) (current-milliseconds))
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (when (prime? n) (report-prime (- (runtime) start-time))))
  ;(if (prime? n)
  ;    (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


; --- Testing ---

; Essa versão faz mais testes
(define (search-for-primes start-number count)
  (cond ((and (> count 0) (prime? start-number))
         (timed-prime-test start-number)
         (search-for-primes (+ start-number 2) (- count 1)))
        ((and (> count 0) (not (prime? start-number)))
         (search-for-primes (+ start-number 2) count))))

(define (search-for-primes-alt start-number count)
  (when (> count 0)
    (cond ((prime? start-number) (timed-prime-test start-number) (search-for-primes-alt (+ start-number 2) (- count 1)))
               (else (search-for-primes-alt (+ start-number 2) count)))))

;(search-for-primes 1000000001 3)
;(search-for-primes 10000000001 3)   
;(search-for-primes 100000000001 3)  
(search-for-primes 1000000000001 3)

