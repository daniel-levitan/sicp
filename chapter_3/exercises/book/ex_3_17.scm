#lang simply-scheme
(define (wrong-count-pairs x) 
  (if (not (pair? x)) 
      0 
      (+ (wrong-count-pairs (car x)) 
         (wrong-count-pairs (cdr x)) 
         1))) 
  
(define str1 '(foo bar baz)) 
;(wrong-count-pairs str1) ; 3 
  
(define x '(foo)) 
(define y (cons x x)) 
(define str2 (list y)) 
;(wrong-count-pairs str2) ; 4 
  
;(define x '(foo)) 
;(define y (cons x x)) 
(define str3 (cons y y)) 
;(wrong-count-pairs str3) ; 7 


(define (count-pairs x)
  (define visited '())
  (define (count-iter x)
    (if (and (pair? x) (not (memq x visited)))
        (begin (set! visited (cons x visited))
               (+ (count-iter (car x))
                  (count-iter (cdr x))
                  1))
        0))
  (count-iter x))

(count-pairs str1)
(count-pairs str2)
(count-pairs str3)


; My previous examples
(define one (list 1))
(define l4 (cons one (cons one '()) ))   ;This count as 4 pairs

(count-pairs l4)

(define y-2 (cons one one))
(define l7 (cons y-2 y-2))   ;This count as 7 pairs
(count-pairs l7)
