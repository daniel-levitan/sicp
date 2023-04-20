#lang simply-scheme

; NOT WORKING

; --- Prime definitions ---
(define (square x) (* x x))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define n-of-times 10)

; --- Timing an operation definitions ---
(define (runtime) (current-milliseconds))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (when (fast-prime? n n-of-times)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


; --- Testing ---

; Essa versão faz mais testes
(define (search-for-primes start-number count)
  (cond ((and (> count 0) (fast-prime? start-number n-of-times))
         (timed-prime-test start-number)
         (search-for-primes (+ start-number 2) (- count 1)))
        ((and (> count 0) (not (fast-prime? start-number n-of-times)))
         (search-for-primes (+ start-number 2) count))))

(define (search-for-primes-alt start-number count)
  (when (> count 0)
    (cond ((fast-prime? start-number n-of-times) (timed-prime-test start-number) (search-for-primes-alt (+ start-number 2) (- count 1)))
               (else (search-for-primes-alt (+ start-number 2) count)))))


;(search-for-primes 1000000001 3)
;(search-for-primes 10000000001 3)   
;(search-for-primes 100000000001 3)  
(search-for-primes-alt 1000000000001 3)