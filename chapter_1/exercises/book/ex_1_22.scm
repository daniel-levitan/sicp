#lang simply-scheme

; Most Lisp implementations include a primitive called runtime that returns an integer that specifies
; the amount of time the system has been running (measured, for example, in microseconds). Thee following timedprime-
; test procedure, when called with an integern, prints n and checks to see if n is prime. If n is prime, the procedure
; prints three asterisks followed by the amount of time used in performing the test.


; Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a
; specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than
; 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth
; of Θ(√n), you should expect that testing for primes around 10,000 should take about sqrt(10) times as long as
; testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the
; Θ(√n) prediction? Is your result compatible with the notion that programs on your machine run in time proportional to
; the number of steps required for the computation?

; --- Prime definitions ---
(define (square x) (* x x))
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)  
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

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
;(timed-prime-test 199)

; Ambas as versões abaixo não representam o que foi pedido, aqui eu conto o número de primos já encontrados
; No livro é pedido que se verifique os primos dentro de um intervalo
; Além disso, aqui eu preciso de uma wrapper function para garantir que eu estou dando um número
; ímpar e não posso receber números pares
; Há outras soluções que já cuidam disso 

; Essa versão faz mais testes
(define (search-for-primes start-number count)
  (cond ((and (> count 0) (prime? start-number))
         (timed-prime-test start-number)
         (search-for-primes (+ start-number 2) (- count 1)))
        ((and (> count 0) (not (prime? start-number)))
         (search-for-primes (+ start-number 2) count))))

; Essa versão é mais compacta que a anterior
(define (search-for-primes-alt start-number count)
  (when (> count 0)
    (cond ((prime? start-number) (timed-prime-test start-number) (search-for-primes-alt (+ start-number 2) (- count 1)))
               (else (search-for-primes-alt (+ start-number 2) count)))))



;(trace search-for-primes-alt)
;(search-for-primes-alt 1000000001 3)

;(search-for-primes 1000000001 3)
;(search-for-primes 10000000001 3)   
;(search-for-primes 100000000001 3)  
(search-for-primes 1000000000001 3) 

