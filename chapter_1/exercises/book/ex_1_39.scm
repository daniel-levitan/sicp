#lang simply-scheme

; Helping me thinking

;def print_term(k, i, par):
;   if k == i:
;      print(f'(N_{i} / D_{i})', end = "")
;      print(par * ')')
;   else:
;      print(f'(N_{i} / (D_{i} + ', end="")
;      print_term(k, i + 1, par + 2)

;(define (term k i)
;  (cond ((= k i) (/ i i))
;        (else (/ i (+ i (term k (+ i 1))))) ))

;(define (n i) 1)
;(define (d i) 1)


(define (cont-frac n d k)
  (define (term k i)
    (cond ((= k i) (/ (n i) (d i)))
          (else (/ (n i) (+ (d i) (term k (+ i 1))))) ))
  (term k 1)
  )


(/ 1(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           100))

