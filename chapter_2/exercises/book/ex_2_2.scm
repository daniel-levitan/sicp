#lang simply-scheme

; Consider the problem of representing line segments in a plane. Each segment is represented as a pair
; of points: a starting point and an ending point. Define a constructor make-segment and selectors start-segment and
; end-segment that define the representation of segments in terms of points. Furthermore, a point can be represented
; as a pair of numbers: the x coordinate and the y coordinate. Accordingly, specify a constructor make-point and
; selectors x-point and y-point that define this representation. Finally, using your selectors and constructors, define a
; procedure midpoint-segment that takes a line segment as argument and returns its midpoint (the point whose coordinates
; are the average of the coordinates of the endpoints). To try your procedures, you’ll need a way to print points:

; make-segment, start-segment, end-segment
; make-point, x-point, y-point

;midpoint-segment

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2)
  (cons p1 p2))
(define (start-segment seg) (car seg))
(define (end-segment seg) (cdr seg))

(define (mid-point seg)
  (let ((x1 (x-point (start-segment seg)))
        (y1 (y-point (start-segment seg)))
        (x2 (x-point (end-segment seg)))
        (y2 (y-point (end-segment seg)))
       )
  (make-point (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))
  )
)
; Eu podia ter recuperado o segmento e usado a recuperação de ponto dentro. 


(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define p (make-point 1 1))
(print-point p)

(define q (make-point 3 5))
(print-point q)

(define s (make-segment p q))

(define m (mid-point s))
(print-point m)