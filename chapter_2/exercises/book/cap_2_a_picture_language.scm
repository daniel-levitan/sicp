#lang simply-scheme
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))
 
(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))
