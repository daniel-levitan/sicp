#lang simply-scheme
; -- append! procedure and auxiliaries
;(define (last-pair x)
;	(if (null? (cdr x)) x (last-pair (cdr x))))

;(define (append! x y)
;  (set-cdr! (last-pair x) y)
;  x)  

;(define (part-of? element queue)
;  (cond ((null? queue) #f)
;        ((eq? element queue) #t)
;        (else (part-of? element (cdr queue)))))
;
; -- Counting pairs
;(define queue (list 'queue))

;(define one (cons 1 '()))
;(define two (list 2))
;(define three (list 3))
;(define four (list 4))

;(append! queue one)
;(append! queue two)
;(append! queue three)



;(part-of? four queue)
;(part-of? one queue)
;(part-of? two queue)
;(part-of? three queue)

;(cdr queue)


; -------

(define str1 '(foo bar baz))

(define x '(foo)) 
(define y (cons x x)) 
(define str2 (list y)) 


;str1

(memq 'foo str1)
(member? 'foo str1)





; Does not work with memq, since the online intepreter does not recognize memq
; Does not work on racket. no set-cdr!
; May work on stkloss

; -- append! procedure and auxiliaries
; v1
; -----
;(define (last-pair x)
;  (if (null? (cdr x)) x (last-pair (cdr x))))

;(define (append! x y)
;  (set-cdr! (last-pair x) y)
;  x)  

;(define (part-of? element queue)
;  (cond ((null? queue) #f)
;        ((eq? element queue) #t)
;        (else (part-of? element (cdr queue)))))

;(define queue (list 'queue))

; An important detail in the following procedure is to add to the queue
; a list of the element being visited. Otherwise we add the element as a list
; and, since cdr lst is another pair that we will visit, it won't be counted
; We are actually adding an address to a list. It would be better to have a 
; way to only add the actual address, since this would take less space
;(define (count-pairs lst c)
;  (cond ((not (null? lst)) (if (part-of? lst queue)
;                               (count-pairs (cdr lst) c)
;                               (begin (append! queue (list lst))
;                                      (count-pairs (cdr lst) (+ c 1)))))
;        (else c)))


; -- Building some examples
;(define l3 (cons 1 (cons 2 (cons 3 '()))))   ; This counts as 3 pairs

;(define one (list 1))
;(define l4 (cons one (cons one '()) ))   ;This count as 4 pairs

;(define y (cons one one))
;(define l7 (cons y y))   ;This count as 7 pairs


; -- Checking the correct result
;(count-pairs l3 0)
;(count-pairs l4 0) ; It is not working properly for l4, or l4 does not have 3 pairs
;(count-pairs l7 0)

