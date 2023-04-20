#lang simply-scheme
(require graphics/graphics)
(open-graphics)

; This draws the window
(define vp (open-viewport "A Picture Language" 600 600))   ; Essa linha já abre a janela na definição


; This would require me to use the vector, segment, and frame functions from the library.
; I am still trying to use all from graphic
;#lang sicp
;(#%require sicp-pict) 


; Previous code
; -- vector   (ex. 2.46)
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

; -- frame (ex. 2.47)
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1 frame)
  (cadr frame))

(define (edge2 frame)
  (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1 frame))
               (scale-vect (ycor-vect v) (edge2 frame))))))
; Testing frame coordinate map
;((frame-coord-map my-frame) (make-vect 0 0))
;((frame-coord-map my-frame) (make-vect 1 1))


; -- segment (ex. 2.48)
(define (make-segment vect1 vect2)
  (list vect1 vect2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cadr seg))

; Ex. 2.49
; This exercise definition
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line- ((frame-coord-map frame)
                   (start-segment segment))
                  ((frame-coord-map frame)
                   (end-segment segment))))
     segment-list)))


; -- adaptor
; This code is necessary in order to pass a vector to the draw-line method from the graphics library
(define (vector-to-posn v)
  (make-posn (xcor-vect v) (ycor-vect v)))

; Defining an alternative draw-line method without overloading the library's definition
; I had to change segments->painter
(define (draw-line- v1 v2)
  ((draw-line vp) (vector-to-posn v1) (vector-to-posn v2)))

; -- Tests

; -- drawing
;((draw-line vp) (make-posn 30 30) (make-posn 100 100))

; Creating the segments
(define my-1-edge (make-vect 0 40))
(define my-2-edge (make-vect 40 0))
(define my-origin (make-vect 10 10))

; Creating the frame
(define my-frame (make-frame my-origin my-1-edge my-2-edge))

;(draw-line- my-origin my-2-edge)


; Here I defined the segments to be painted

; a)
(define outline-segments
  (list (make-segment (make-vect 0.0 0.0) (make-vect 0.0 10.0))
        (make-segment (make-vect 0.0 0.0) (make-vect 10.0 0.0))
        (make-segment (make-vect 10.0 0.0) (make-vect 10.0 10.0))
        (make-segment (make-vect 0.0 10.0) (make-vect 10.0 10.0))))

; And this is how I can paint the segments
;((segments->painter outline-segments) my-frame)

; b)
(define x-segments
  (list (make-segment (make-vect 0.0 0.0) (make-vect 1.0 1.0))
        (make-segment (make-vect 0.0 1.0) (make-vect 1.0 0.0))))
((segments->painter x-segments) my-frame)

; c)
(define diamond-segments
  (list (make-segment (make-vect 0.5 0.0) (make-vect 0.0 0.5))
        (make-segment (make-vect 0.0 0.5) (make-vect 0.5 1.0))
        (make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.5))
        (make-segment (make-vect 0.5 0.0) (make-vect 1.0 0.5))))
;((segments->painter diamond-segments) my-frame)

; d)
(define wave-segments
  (list
   ; -- head
   (make-segment (make-vect 0.0 4.8) (make-vect .8 4.5))
   (make-segment (make-vect 0.0 5.2) (make-vect .8 5.5))
   (make-segment (make-vect 1.4 5.2) (make-vect .8 5.5))
   (make-segment (make-vect 1.4 4.8) (make-vect .8 4.5))
   ; -- neck
   (make-segment (make-vect 1.4 5.2) (make-vect 1.6 5.3))  ;right
   (make-segment (make-vect 1.4 4.8) (make-vect 1.6 4.7))  ;left
   ; -- shoulders
   (make-segment (make-vect 1.4 5.5) (make-vect 1.6 5.3))  ;right
   (make-segment (make-vect 1.4 4.5) (make-vect 1.6 4.7))  ;left
   ; -- right arm
   (make-segment (make-vect 1.4 5.5) (make-vect 3 7))  ;up
   (make-segment (make-vect 1.9 5.5) (make-vect 3.2 6.9))  ;bottom
   ; -- left arm
   (make-segment (make-vect 1.4 4.5) (make-vect 2.0 3.5))  ; up arm
   (make-segment (make-vect 1.8 4.5) (make-vect 2.4 3.4))  ; bottom arm
   (make-segment (make-vect 1.2 2.6) (make-vect 2.0 3.5))  ; up forearm
   (make-segment (make-vect 1.5 2.6) (make-vect 2.4 3.4))  ; up forearm
   ; -- body
   (make-segment (make-vect 1.9 5.5) (make-vect 2.85 5.35))  ; right up
   (make-segment (make-vect 1.8 4.5) (make-vect 2.85 4.65))  ; left up
   ; -- legs
   (make-segment (make-vect 6 4) (make-vect 2.85 4.65))  ; left out
   (make-segment (make-vect 6 6) (make-vect 2.85 5.35))  ; right out
   (make-segment (make-vect 3.8 4.8) (make-vect 6 4.3))  ; inner left
   (make-segment (make-vect 3.8 5.1) (make-vect 6 5.65))  ; inner right
   ; -- coccyx
   (make-segment (make-vect 3.8 4.8) (make-vect 3.8 5.1))  ; inner right
   ))

;((segments->painter wave-segments) my-frame)