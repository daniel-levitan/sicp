#lang simply-scheme

; Há erro aqui

(define (square x) (* x x))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))



(define (circle-test x1 x2 y1 y2)
  (let ((x (random-in-range x1 (+ x2 1))))
    (let ((y (random-in-range y1 (+ y2 1))))
      (if (<= (+ (square (- x (/ (+ x1 x2) 2)))
                (square (- y (/ (+ y1 y2) 2))))
             (square (/ (- x2 x1) 2)))
          #t
          #f)) ))

(define (estimate-integral P x1 x2 y1 y2 n)
  (define (integral-test)    
    (P x1 x2 y1 y2))  
  (monte-carlo n integral-test)
)


(exact->inexact (estimate-integral circle-test 2 8 4 10 1000))



