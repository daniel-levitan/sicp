#lang simply-scheme

; -- Stream definitions
(define the-empty-stream '())
(define stream-null? null?)

(define-syntax delay
  (syntax-rules ()
    ((delay expr)
     (lambda () expr))))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)
     (cons a (delay b)))))

(define (force x)
  (x))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

; -- Other definitions used in this exercise
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))


(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x) (newline) (display x))

; -- This exercise

(define sum 0) ; sum -> 0
(define (accum x) (set! sum (+ x sum)) sum) ; sum -> 0

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20))) ; sum -> 1
; This sequence is 1, 1+2, 3+3, 6+4, 10+5, ...

(define y (stream-filter even? seq)) ; sum -> 6
; This sequence is 6, 10, 28, ...

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq)) ; sum -> 15
; This sequence is 15, 20, 50, 60, 110, 125, 195, 215
(display-stream z) 

(stream-ref y 7) ; sum -> 162 (this is the 8th element)

(display-stream z) ; sum -> 362
; Somehow this stream was changed to 15, 380, 430, 505

; I am not sure my delay implementation matches the first in the book
