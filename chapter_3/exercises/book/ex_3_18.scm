;#lang simply-scheme
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
(define z (make-cycle (list 'a 'b 'c)))



(define (circular? x)
  (define visited '())  
  (define (visit x)
     (if (pair? x)
         (if (memq x visited)
             #t
             (begin (set! visited (cons x visited))
                    (visit (cdr x))))
         #f))
  (visit x))

(circular? z)


(define str4 '(foo bar baz)) 


