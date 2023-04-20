#lang simply-scheme

(define (square x) (* x x))

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op)))) dispatch)


(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) x)
          ((eq? op 'angle) y)
          ((eq? op 'real-part) (* x (cos y))) 
          ((eq? op 'imag-part) (* x (sin y)))
          (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op)))) dispatch)

;(define real-part-2 (make-from-real-imag-2 3 4))
;(real-part-2 'real-part)
;(real-part-2 'magnitude)

(define (apply-generic op arg) (arg op))

(define z (make-from-real-imag 3 4))
(apply-generic 'real-part z)
(apply-generic 'imag-part z)
(apply-generic 'magnitude z)
(apply-generic 'angle z)

(define w (make-from-mag-ang 5 0.9272952180016122))
(apply-generic 'real-part w)
(apply-generic 'imag-part w)
(apply-generic 'magnitude w)
(apply-generic 'angle w)