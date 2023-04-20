#lang simply-scheme

; Essa versão é a anterior a data-directed programming. O que isso significa? Que as funções possíveis e os tipos
; de dados com os quais o programa lida estão espalhados pela implementação.
;
; Os médotos que realizam as operações aritméticas chamanm as funções para obter as partes real e imaginária e
; a magnitude e o ângulo como se não houvesse um problema de diferentes representações.
;
; Porém, as funções que são chamadas variam de acordo com o tipo de dado e por isso essas funções precisam
; identificar que tipo de representação está sendo usada para então chamar o correto método que por fim
; retorna os valores requisitados.
;
; A maneira como estes procedimentos são capazes de identificar que tipo de dado foi armazenado é através do
; uso de tags (nomes) que identificam o tipo de dado.

; -- General definitions
(define (square x) (* x x))

; -- Complex operations definition
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

; -- General selectors based on tags
(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type: REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type: IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type: MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type: ANGLE" z))))

(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))
(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))


; -- Rectangular

; -- sem usar tag
;(define (real-part z) (car z))
;(define (imag-part z) (cdr z))
;(define (magnitude z)
;  (sqrt (+ (square (real-part z))
;           (square (imag-part z)))))
;(define (angle z)
;  (atan (imag-part z) (real-part z)))
;(define (make-from-real-imag x y) (cons x y))
;(define (make-from-mag-ang r a)
;  (cons (* r (cos a)) (* r (sin a))))

; -- usando tags
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))

(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))

(define (make-from-mag-ang-rectangular r a)
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))

; -- Polar

; -- sem usar tag
;(define (real-part z) (* (magnitude z) (cos (angle z))))
;(define (imag-part z) (* (magnitude z) (sin (angle z))))
;(define (magnitude z) (car z))
;(define (angle z) (cdr z))
;(define (make-from-real-imag x y)
;  (cons (sqrt (+ (square x) (square y)))
;        (atan y x)))
;(define (make-from-mag-ang r a) (cons r a))

; --usando tags
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))

(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
              (cons (sqrt (+ (square x) (square y)))
                    (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))



; -- Tag implementation
(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

(define (rectangular? z) (eq? (type-tag z) 'rectangular))
(define (polar? z) (eq? (type-tag z) 'polar))

; -- Tests
;(make-from-real-imag (real-part z) (imag-part z))
;(make-from-mag-ang (magnitude z) (angle z))


