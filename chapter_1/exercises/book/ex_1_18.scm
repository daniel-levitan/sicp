#lang simply-scheme

; Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that generates an iterative process
; for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps

; 1.16
;(define (exp-iter b n a)
;  (if (= n 0)
;      a
;      (if (even? n)
;          (exp-iter (square b) (/ n 2) a)
;          (exp-iter b (- n 1) (* a b)) )))

; 1.17
;(define (mult a b)
;  (if (= b 1)
;      a
;      (if (even? b)
;          (double (mult a (halve b)))
;          (+ a (double (mult a (halve (- b 1))))) )))

(define (double n) (* n 2))
(define (halve n) (/ n 2))

(define (mult-iter a b product)
  (if (= b 0)
      product
       (if (even? b)
          (mult-iter (double a) (halve b) product)
          (mult-iter a (- b 1) (+ a product))
        )
      )
  )


(trace mult-iter)
(mult-iter 3 5 0)