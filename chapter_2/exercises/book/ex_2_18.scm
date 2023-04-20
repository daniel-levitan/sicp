#lang simply-scheme

; Define a procedure reverse that takes a list as argument and returns a list of the same elements in reverse
; order:
; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)

;(define (last-pair lst)
;  (if (equal? (cdr lst) '())
;      (car lst)
;      (last-pair (cdr lst)) ))

; Posso fazer usando nth, posso fazer recursivamente usando last-pair e posso fazer de trás para frente



(define (reverse-print lst)  
  (when (not (null? lst))
    (reverse-print (cdr lst))
    (display (car lst))
    (newline) ))

;def reverse_string(s):
;   if s == '':
;      return ''
;   else:
;      return reverse_string(s[1:]) + s[0]

(define (reverse lst)
  (if (null? lst)
      '()
      (append (reverse (cdr lst)) (list (car lst))) ))

; Isso não funciona
(define (reverse-2 lst)
  (if (= (length lst) 1)
      lst
  ;(if (empty? lst)
   ;   '()
      ;(cons (car lst) (reverse (cdr lst)))
      (cons (reverse (cdr lst)) (car lst))
      )
  )

; Funciona, mas é iterativo
(define (reverse-3 items)
  (define (iter things answer)
  (if (null? things)
    answer
    (iter (cdr things)
          (cons (car things)
                answer))))
  (iter items '()))

(reverse (list 1 4 9 16 25))
(reverse-2 (list 1 4 9 16 25))
(reverse-3 (list 1 4 9 16 25))