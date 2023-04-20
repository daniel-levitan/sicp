#lang simply-scheme

; The width of an interval is half of the difference between its upper and lower bounds. The width is a
; measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the
; result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the
; width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or
; difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples
; to show that this is not true for multiplication or division.


(define (make-interval a b) (cons a b))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
               (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval
   x
   (make-interval (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y)))))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))



(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))



; interval subtraction: [a,b] - [c,d] = [a - d, b - c]
(define (sub-interval itrvl-1 itrvl-2)
  (make-interval (- (lower-bound itrvl-1) (upper-bound itrvl-2))
                 (- (upper-bound itrvl-1) (lower-bound itrvl-2)) ))



; --- Testing ---
(define r-1 (make-interval 6.12 7.48))
(define r-2 (make-interval 2.58 2.97))

(width r-1)

; 6.12 - 7.48
; 2.58 - 2.97
; 6.12 - 2.97 até 7.48 - 2.58
;(sub-interval r-1 r-2)
