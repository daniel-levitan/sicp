; How to count the number of pairs in any list structure?
;

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(define l3 (cons 1 (cons 2 (cons 3 '()))))
(count-pairs l3)

; In my opinion we have 4 pairs below
(define tail (cons 1 '()))
(define middle (cons tail tail))
(define head-4 (cons middle '()))
(count-pairs head-4) 
  
; Again, in my opinion one is being places twice, meaning that we have 2 cons from the one's, and other 2 cons. 
; If I change cons for list, I still have cons, since list is a cons of cons.
(define one (cons 1 '()))
(define l4 (cons one (cons one '()) ))
(count-pairs l4)

; The same for 7
(define y (cons one one))
(define l7 (cons y y))
(count-pairs l7)

; The last one is simply a circular list in which the cdr of the last pair points to the first pair

