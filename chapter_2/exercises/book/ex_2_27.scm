#lang simply-scheme

(define (reverse lst)
  (if (null? lst)
      '()
      (append (reverse (cdr lst)) (list (car lst))) ))


;(define (deep-reverse lst)
;  (cond ((null? lst) '())
;        ((pair? (car lst)) (append (list (deep-reverse (car lst))) (deep-reverse (cdr lst))))
;        (else (append (deep-reverse (cdr lst)) (list (car lst))) )))

(define (deep-reverse lst)
  (if (null? lst)
      '()
      (append (deep-reverse (cdr lst))
              (if (pair? (car lst))
                  (list (deep-reverse (car lst)))
                  (list (car lst)))) ))

; ou 

;(define (deep-reverse lst)
;  (cond ((null? lst) '())
;        ((pair? (car lst)) (append (deep-reverse (cdr lst)) (list (deep-reverse (car lst)))))
;        (else              (append (deep-reverse (cdr lst)) (list (car lst)))) )) 


(define (deep-reverse-2 l)
  (cond ((null? l) '())        
        ((not (pair? l)) l)
        (else (append  (deep-reverse-2 (cdr l)) (list (deep-reverse-2 (car l))))  ) ))


(define x (list (list 1 2) (list 3 4)))
(display "Original     : ") (display x) (newline)
(display "Reverse      : ") (display (reverse x)) (newline)
(display "Goal         : ") (display "((4 3) (2 1))") (newline)

(display "Deep-reverse : ") (display (deep-reverse x)) (newline)
(display "Deep-reverse : ") (display (deep-reverse-2 x)) (newline)
