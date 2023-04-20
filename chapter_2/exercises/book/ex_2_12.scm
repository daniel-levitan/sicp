#lang simply-scheme

; Define a constructor make-center-percent that takes a center and a percentage tolerance and produces
; the desired interval. You must also define a selector percent that produces the percentage tolerance for a given
; interval. The center selector is the same as the one shown above.

;(define (make-center-width c w)
;  (make-interval (- c w) (+ c w)))
;(define (center i)
;  (/ (+ (lower-bound i) (upper-bound i)) 2))
;(define (width i)
;(/ (- (upper-bound i) (lower-bound i)) 2))


;(define (center i)
;  (/ (+ (lower-bound i) (upper-bound i)) 2))
;(define (width i)
;(/ (- (upper-bound i) (lower-bound i)) 2))



(define (make-interval a b) (cons a b))

(define (make-center-width c percent)
  (make-interval (- c (* c percent)) (+ c (* c percent))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent r)
  (/ (- (upper-bound r) (center r)) (center r)))


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

(define r (make-center-width 100 0.05))
(percent r)


;(div-interval r-1 r-2)

(define a (make-interval 2 5))
(define b (make-interval -2 2))

;(div-interval a b)
