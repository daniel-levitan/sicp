#lang simply-scheme

; In passing, Ben also cryptically comments: “By testing the signs of the endpoints of the intervals, it is
; possible to break mul-interval into nine cases, only one of which requires more than two multiplications.” Rewrite
; this procedure using Ben’s suggestion.

; After debugging her program, Alyssa shows it to a potential user, who complains that her program solves the wrong
; problem. He wants a program that can deal with numbers represented as a center value and an additive tolerance; for
; example, he wants to work with intervals such as 3:5 0:15 rather than [3.35, 3.65]. Alyssa returns to her desk and fixes
; this problem by supplying an alternate constructor and alternate selectors:

;(define (make-center-width c w)
;  (make-interval (- c w) (+ c w)))
;(define (center i)
;  (/ (+ (lower-bound i) (upper-bound i)) 2))
;(define (width i)
;(/ (- (upper-bound i) (lower-bound i)) 2))

; Unfortunately, most of Alyssa’s users are engineers. Real engineering situations usually involve measurements with
; only a small uncertainty, measured as the ratio of the width of the interval to the midpoint of the interval. Engineers
; usually specify percentage tolerances on the parameters of devices, as in the resistor specifications given earlier.


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


(define (spans-zero? y)
  (and (<= (lower-bound y) 0) (>= (upper-bound y) 0)))
  
(define (div-interval x y)
  (if (spans-zero? y)
      (error "Error: The denominator should not span 0.")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y)))) ))

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

(div-interval r-1 r-2)

(define a (make-interval 2 5))
(define b (make-interval -2 2))

;(div-interval a b)
