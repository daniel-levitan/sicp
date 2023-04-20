#lang sicp
(#%require sicp-pict)

; -- Testing
;(paint (flip-vert einstein))

; -- Examples from the book

; Defining wave4 and 2 using combinations
(define wave einstein)
(define wave2 (beside wave (flip-vert wave)))
(define wave4 (below wave2 wave2))
;(paint wave2)
;(paint wave4)

; Defining the flipping of a pair and wave4 depending on it
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define wave4-2 (flipped-pairs wave))
;(paint wave4-2)

; Defining multiple operations
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))
;(paint (right-split einstein 1))


; (ex. 2.44)
; Paint the figure above splitted
(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
;(paint (up-split einstein 2))


(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)               ; lado esquerdo da figura, painter & top-left 
                  (below bottom-right corner))))))       ; lado direito da figure, bottom-right & corner novamente

;(paint (corner-split einstein 2))


(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))
;(paint (square-limit einstein 2))

; Agora usando high-order procedures, podemos redefinir uma função que atua no painter
; em 4 quadrantes:
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))


(define (flipped-pairs-2 painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

;(paint (flipped-pairs-2 einstein))

; ex. 2.45
; Definir split genérico

; As duas definições abaixo são equivalentes, a primeira me parece mais simples

;(define (split func1 func2)
;  (lambda (painter)
;    (func1 painter (func2 painter painter))) )

(define (split func1 func2)
  (lambda (painter)
    (let ((smaller (func2 painter painter)))     
      (func1 painter smaller)) ))

; -- Testing
(paint (right-split einstein 1))
(define right-split-2 (split beside below))
(paint (right-split-2 einstein))

(paint (up-split einstein 1))
(define up-split-2 (split below beside))
(paint (up-split-2 einstein))