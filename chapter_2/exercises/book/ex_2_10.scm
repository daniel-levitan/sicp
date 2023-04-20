#lang simply-scheme

; Ben Bitdiddle, an expert systems programmer, looks over Alyssa’s shoulder and comments that it is
; not clear what it means to divide by an interval that spans zero. Modify Alyssa’s code to check for this condition and
; to signal an error if it occurs.
;
; O problema é ter um intervalo que passe por zero, aparentemente isso não pode e não entendi por que

; Isso aqui estava nas notas cs61a:
; (Note: “Spans zero” means that one bound is <= zero and the other is >= zero!)

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


(define (spans-zero-2? y)
  (< (* (lower-bound y)
        (upper-bound y))
     0) )
  
;(define (<= x)
;  (or (< x 0) (= x 0)))

;(define (>= x)
;   (or (> x 0) (= x 0))
  

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

(div-interval a b)
