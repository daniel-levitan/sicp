#lang simply-scheme

; Usando cons só conseguimos adicionar um elemento no início da lista
; Se revertemos o processo adicionamos uma nova lista em cdr
; Essa é a assimetria a qual o professor se referiu
; Para consertar essa função devemos usar append

; Louis Reasoner tries to rewrite the first squarelist procedure of Exercise 2.21 so that it evolves an iterative
; process:
(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
  (if (null? things)
    answer
    (iter (cdr things)
          (cons (square (car things))
                answer))))
  (iter items '()))

(square-list (list 1 2 3 4))

; Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?
; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))

(square-list-2 (list 1 2 3 4))

; This doesn’t work either. Explain.

(define (square-list-3 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer                              ; Modificação
                    (list (square (car things)))))))      ; Modificação
  (iter items '()))

(square-list-3 (list 1 2 3 4))
