#lang simply-scheme

;(load "/Users/daniel/Documents/projects/cs61a/chapter_3/exercises/book/ex_3_51.scm")

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

; -- Other definitions for this exercise
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (display-line x) (newline) (display x))

(define (show x)
  (display-line x)  
  x)

(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))

(display "Now showing") (newline)
(stream-ref x 5)
(stream-ref x 7)
(stream-ref x 3)

; The definition of x already shows the first value for x, which is 0