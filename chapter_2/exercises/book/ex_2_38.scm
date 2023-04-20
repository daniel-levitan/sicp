#lang simply-scheme

; Regular accumulator
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))



(define a (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define b (list 1 2 3 4 5))

(fold-right + 0 b)
(fold-left + 0 b)

(fold-right / 1 (list 1 2 3)) ; -> 1 / 2 / 3 = 1 / 6 ; ERRADO
;  (fold-right / 1 (list 1 2 3))
;  = (/ 1 (/ 2 (/ 3 1)))
;  = (/ 1 2/3)
;  = 3/2
(fold-left / 1 (list 1 2 3)) ; -> 3 / 2 / 1 = 3 / 2 ; ERRADO
;  (fold-left / 1 (list 1 2 3))
;  = (/ (/ (/ 1 1) 2) 3)
;  = (/ (/ 1 2) 3)
;  = (/ 1/2 3)
;  = 1/6
(fold-right list '() (list 1 2 3)) ; -> 1 2 3 ; ERRADO
;  (fold-right list nil (list 1 2 3))
;  = (list 1 (list 2 (list 3 nil)))
;  = (1 (2 (3 ())))
(fold-left list '() (list 1 2 3)) ; -> 3 2 1 ; ERRADO
;  (fold-left list nil (list 1 2 3))
;  = (list (list (list nil 1) 2) 3)
;  = (((() 1) 2) 3)

; Errei
; A ordem da operação não pode fazer diferença. Comutatividade.