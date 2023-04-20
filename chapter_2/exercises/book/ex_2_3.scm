#lang simply-scheme
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

;(define (make-segment p1 p2)
;  (cons p1 p2))
;(define (start-segment seg) (car seg))
;(define (end-segment seg) (cdr seg))

; It seems too big of a solution
; I could have defined width and height to get the intermediate info
; and then calculate based on that

(define (make-rectangle start end)
  (cond ( (and (< (car start) (car end)) (< (cdr start) (cdr end)))  
             (cons (cons (car start) (cdr start)) (cons (car end) (cdr end))))        
        ( (and (< (car start) (car end)) (> (cdr start) (cdr end)))  
             (cons (cons (car start) (cdr end)) (cons (car end) (cdr start))))
        ( (and (> (car start) (car end)) (< (cdr start) (cdr end)))  
             (cons (cons (car end) (cdr start)) (cons (car start) (cdr end))))
        ( (and (> (car start) (car end)) (> (cdr start) (cdr end)))  
             (cons (cons (car end) (cdr end)) (cons (car start) (cdr start))))   ))

(define (rect-start rect) (car rect))
(define (rect-end rect) (cdr rect))


(define (get-perimeter rect)
  (let ( ( end-x (x-point (rect-end rect)))
         ( start-x (x-point (rect-start rect)))
         ( end-y (y-point (rect-end rect)))
         ( start-y (y-point (rect-start rect)))
      
         )
    (+ (* 2 (- end-x start-x)) (* 2 (- end-y start-y)))
    ))

(define (get-area rect)
  (let ( ( end-x (x-point (rect-end rect)))
         ( start-x (x-point (rect-start rect)))
         ( end-y (y-point (rect-end rect)))
         ( start-y (y-point (rect-start rect)))
      
         )
    (* (- end-x start-x) (- end-y start-y))
    ))


; ------- Testing -----
(define start (make-point -1 0))
(define end (make-point 3 -2))

(define my-rect (make-rectangle start end))

(rect-start my-rect)
(rect-end my-rect)

(get-perimeter my-rect)
(get-area my-rect)

(define a (make-point 0 0))
(define b (make-point 2 10))

(define r (make-rectangle a b))
(get-perimeter r)
(get-area r)






