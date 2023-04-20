#lang simply-scheme

; a) An infinite continued fraction is an expression of the form
;
;                   N_1
;    f = ------------------------
;                      N_2
;         D_1 + -----------------
;  
;                D_2 +    N_3
;                      ----------
;                       D_3 + ...
;
; As an example, one can show that the infinite continued fraction expansion with the Ni and the Di all
; equal to 1 produces 1/φ, where φ is the golden ratio (described in Section 1.2.2). One way to approximate
; an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation—
; a so-called k-term finite continued fraction—has the form
;
;               N_1
;    f = -------------------
;                   N_2
;         D_1 + ------------
;                ... + N_k
;                      ---
;                      D_k
; 
; Suppose that n and d are procedures of one argument (the term index i) that return the Ni and Di of the
; terms of the continued fraction. Define a procedure cont-frac such that evaluating (cont-frac n d k)
; computes the value of the k-term finite continued fraction. Check your procedure by approximating 1=φ using
;
; (cont-frac (lambda (i) 1.0)
;            (lambda (i) 1.0)
;            k)
;
; for successive values of k. How large must you make k in order to get an approximation that is accurate to
; 4 decimal places?
;
; b) If your cont-frac procedure generates a recursive process, write one that generates an iterative process. If
; it generates an iterative process, write one that generates a recursive process.


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

