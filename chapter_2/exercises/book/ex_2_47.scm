#lang simply-scheme
; A frame can be described by three vectors—an origin vector and two edge vectors. The origin vector
; specifies the offset of the frame’s origin from some absolute origin in the plane, and the edge vectors
; specify the offsets of the frame’s corners from its origin.

; Let's represent a frame as 3 points, origin, edge1, and edge 2. These points are enough to represent vectors since
; the origin vector will be the line segment from the origin of the plane to this point. The same idea may be applied
; to the other edges


; -- vector
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

; -- frame
; === Constructor 1 ===
(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-vect-1 frame)
  (car frame))

(define (edge1-vect-1 frame)
  (cadr frame))

(define (edge2-vect-1 frame)
  (caddr frame))

; --- Tests for constructor 1 ---
;(define frame-1 (make-frame-1 (make-vect 1 2) (make-vect 3 4) (make-vect 5 6)))
;frame-1
;(origin-vect-1 frame-1)
;(edge1-vect-1 frame-1)
;(edge2-vect-1 frame-1)


; === Constructor 2 ===
(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-vect-2 frame)
  (car frame))

(define (edge1-vect-2 frame)
  (cadr frame))

(define (edge2-vect-2 frame)
  (cddr frame))


; --- Tests for constructor 2 ---
(define frame-2 (make-frame-2 (make-vect 1 2) (make-vect 3 4) (make-vect 5 6)))
;frame-2
(origin-vect-2 frame-2)
(edge1-vect-2 frame-2)
(edge2-vect-2 frame-2)
