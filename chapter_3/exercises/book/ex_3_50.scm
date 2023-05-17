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


; -- Auxiliary procedures
(define (show-stream strm . args) ;2nd arg is how many
  (if (null? args)
      (ss1 strm 10 10)
      (ss1 strm (car args) (car args))))

(define ss show-stream)

(define (ss1 strm this all)
  (cond ((null? strm) '())
	((= this 0) '(...))
	((and (pair? strm) (procedure? (cdr strm)))
	 (cons (ss1 (stream-car strm) all all)
	       (ss1 (stream-cdr strm) (- this 1) all)))
	(else strm)))


; -- This exercise
;(define (stream-map proc s)
;  (if (stream-null? s)
;      the-empty-stream
;      (cons-stream (proc (stream-car s))
;                   (stream-map proc (stream-cdr s)))))

; A use case would be giving two or three integer lists and summing them
; argstreams é uma lista
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

; -- Testing
(define (ints-from from)
      (cons-stream from (ints-from (+ from 1))))

(define integers (ints-from 1))

(ss integers)

(ss (stream-map (lambda (x) (* x 2)) integers)) 

