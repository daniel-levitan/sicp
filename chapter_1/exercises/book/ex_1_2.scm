#lang simply-scheme

;Translate the following expression into prefix form:

;5 + 4 + (2 - (3 - (6 + 4 / 5 )))
;--------------------------------
;	   3 (6 - 2)(2 - 7)

;> (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (*  3 (- 6 2) (- 2 7)))
;The result is - 37/150
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (*  3 (- 6 2) (- 2 7)))