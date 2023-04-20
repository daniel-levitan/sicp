#lang simply-scheme

; Já posicionamos k - 1 rainhas de n formas
; For each of these ways, generate an extended set of positions by placing a queen in each row of the kth column.
; Now filter these, keeping only the positions for which the queen in the kth column is safe
; with respect to the other queens.

(define (flatmap proc seq) (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))



(define k 2)
(define rest-of-queens (list (list 0 2) (list 0 3)))
(define board-size 4)

(define empty-board '())



(define (adjoin-position new-row k rest-of-queens)
  (map (lambda (x) (append x new-row)) rest-of-queens))
  

(define safe? '())


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)  
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))



