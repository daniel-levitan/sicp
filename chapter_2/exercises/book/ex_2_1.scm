#lang simply-scheme

; Define a better version of make-rat that handles both positive and negative arguments.make-rat should
; normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if
; the rational number is negative, only the numerator is negative.

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (numer x) (car x))
(define (denom x) (cdr x))


; This solution works, but is big
(define (make-rat-2 n d)
  (let ((g (gcd n d)))
    (let ((n (/ n g))
          (d (/ d g)) 
          )
      (cond ((and (> n 0) (> d 0)) (cons n d))
            ((and (< n 0) (< d 0)) (cons (* n -1) (* d -1))) 
            ((and (< n 0) (> d 0)) (cons n d))
            ((and (> n 0) (< d 0)) (cons (* n -1) (* d -1)))))))

; Best solution (we need to take abs from gcd)
(define (make-rat-3 n d)
  (let ((g (abs (gcd n d))))
    (if (< d 0)
        (cons (/ (* n -1) g) (/ (* d -1) g))
        (cons (/ n g) (/ d g)))))


; This solution doesn't work
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (< d 0)
        (cons (/ (* n -1) g) (/ (* d -1) g))
        (cons (/ n g) (/ d g)))))

  
(define a (make-rat-3 1 2))
(print-rat a)
(define b (make-rat-3 1 -2))
(print-rat b)

(define c (make-rat-3 -1 2))
(print-rat c)

(define d (make-rat-3 -1 -2))
(print-rat d)

(define e (make-rat-3 6 9))
(print-rat e)

(define f (make-rat-3 6 -9))
(print-rat f)

(define g (make-rat-3 -6 9))
(print-rat g)

(define h (make-rat-3 -6 -9))
(print-rat h)





