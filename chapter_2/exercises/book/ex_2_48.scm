#lang simply-scheme

; A directed line segment in the plane can be represented as a pair of vectors — the vector running from
; the origin to the start-point of the segment, and the vector running from the origin to the end-point of the segment.
; Use your vector representation from Exercise 2.46 to define a representation for segments with a constructor makesegment
; and selectors start-segment and end-segment.

; Previous code

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
             (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
             (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect s vect)
  (make-vect (* s (xcor-vect vect))
             (* s (ycor-vect vect))))


; This exercise

;(define (make-segment vect1 vect2)
;  (list vect1 vect2))

(define (make-segment vect1 vect2)
  (list vect1 vect2))


; I could have used cons, but I rather use lists.

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cadr seg))


; Tests
(define vect1 (make-vect (/ 3 10) (/ 1 2)))
(define vect2 (make-vect (/ 1 10) (/ 2 10)))

(define seg1 (make-segment vect1 vect2))
(start-segment seg1)
(end-segment seg1)

