#lang simply-scheme

(define a (list 1 2 3 4))
(define b (list 5 6 7 8))

; Just checking how to arrive at the cdr
;(define (find-last lst)
;  (if (not (null? (cdr lst)))
;      (find-last (cdr lst))
;      (car lst)))
;(find-last a)


; This is my version
(define (append! l1 l2)
  (if (not (null? (cdr l1)))
        (append! (cdr l1) l2)
        (set-cdr! l1 l2)))
  
; -- Testing
; Runs on Stklos
(append! a b)
a
; (1 2 3 4 5 6)


; Here's the book's version
(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z
;(a b c d)

(cdr x)
; ⟨response⟩ => (b)
; Since x is '(a b), the cdr of this list is (b)

(define w (append! x y))
w
; (a b c d)
(cdr x)
;⟨response⟩ => (b c d)

; append! inserts y at the end of x, and now x is '(a b c d), and that's why cdr x is '(b c d)

; What are the missing ⟨response⟩s? Draw box-and-pointer diagrams to explain your answer.

; First, this is what append does
;
;      ---------      ---------
;      |   |   |      |   |  /|
;x --->| | |  ------->| | | / |
;      | | |   |      | | |/  |
;      --|------      --|------
;        |              |        
;        V              V    
;       'a             'b    
;      
;      ---------      ---------
;      |   |   |      |   |  /|
;y --->| | |  ------->| | | / |
;      | | |   |      | | |/  |
;      --|------      --|------
;        |              |        
;        V              V    
;       'c             'd
;
;      ---------      ---------      ---------      ---------
;      |   |   |      |   |   |      |   |   |      |   |  /|
;z --->| | |  ------->| | |  ------->| | |  ------->| | | / |
;      | | |   |      | | |   |      | | |   |      | | |   |
;      --|------      --|------      --|------      --|------
;        |              |              |              |        
;        V              V              V              V    
;       'a             'b             'c             'd    
;

; And this, is what append! does
;
;      ---------      ---------
;      |   |   |      |   |  /|
;x --->| | |  ------->| | | / |
;      | | |   |      | | |/  |
;      --|------      --|------
;        |              |        
;        V              V    
;       'a             'b    
;      
;      ---------      ---------
;      |   |   |      |   |  /|
;y --->| | |  ------->| | | / |
;      | | |   |      | | |/  |
;      --|------      --|------
;        |              |        
;        V              V    
;       'c             'd
;

; Besides creating w, it appends y to x, changing x

; This is x, which is changed with set-cdr!:
;
;      ---------      ---------      ---------      ---------
;      |   |   |      |   |   |      |   |   |      |   |  /|
;x --->| | |  ------->| | |  ------->| | |  ------->| | | / |
;      | | |   |      | | |   |      | | |   |      | | |   |
;      --|------      --|------      --|------      --|------
;        |              |              |              |        
;        V              V              V              V    
;       'a             'b             'c             'd    

; And this is w:
;
;      ---------      ---------      ---------      ---------
;      |   |   |      |   |   |      |   |   |      |   |  /|
;w --->| | |  ------->| | |  ------->| | |  ------->| | | / |
;      | | |   |      | | |   |      | | |   |      | | |   |
;      --|------      --|------      --|------      --|------
;        |              |              |              |        
;        V              V              V              V    
;       'a             'b             'c             'd    


; Now we can see that (cdr x) on the first configuration, only gives us (b) back
; On the other hand, (cdr x) on the second configuration, gives us back (b c d)


     

