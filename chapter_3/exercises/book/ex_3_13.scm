#lang simply-scheme

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)



; We start with the list:
;
;      ---------      ---------      ---------
;      |   |   |      |   |   |      |   |  /|
;  --->| | |  ------->| | |  ------->| | | / |
;      | | |   |      | | |   |      | | |/  |
;      --|------      --|------      --|------
;        |              |              |        
;        V              V              V    
;       'a             'b             'c

(define z (make-cycle (list 'a 'b 'c)))

; Now, if we change the last cdr to point to x, we have this:
;
; |-------------------------------------------------|       
; |                                                 |
; |    ---------      ---------      ---------      |
; |--->|   |   |      |   |   |      |   |  /|      |
;  --->| | |  ------->| | |  ------->| | |  --------|
;      | | |   |      | | |   |      | | |/  |
;      --|------      --|------      --|------
;        |              |              |        
;        V              V              V    
;       'a             'b             'c
;
;
; What happens if we try to compute (last-pair z)?
; The procedure will get into an infinite loop because it will
; not be able to get to a pair which cdr is null