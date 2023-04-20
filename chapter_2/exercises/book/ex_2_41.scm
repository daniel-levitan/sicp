#lang simply-scheme

; Write a procedure to find all ordered triples of distinct positive integers i, j, and k less than or equal to
; a given integer n that sum to a given integer s.

; -- Funções gerais definidas no livro --
(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

; Verficiar se o triplet tem algarismos iguais
(define (all-diff-triplet? a b c)
  (cond ((equal? a b) #f)
        ((equal? b c) #f)
        ((equal? a c) #f)
        (else #t)))

(define (diff-trip? triplet)
  (all-diff-triplet? (car triplet)
                     (cadr triplet)
                     (caddr triplet)))
  


; Gera lista de 2 dimensões com triplets
(define (all-triplets n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1) )))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

; Define a soma de triplets
(define (sum-triplet triplet)
  (+ (car triplet) (cadr triplet) (caddr triplet)))

; Verifica se o triplet tem soma n
(define (sum-n? triplet n)
  (= n (+ (car triplet) (cadr triplet) (caddr triplet)) ))


(define n 5)
(define m 10)

; Isso aqui precisa vir numa função
(filter (lambda (x) (sum-n? x m)) (all-triplets n))

  
;(all-triplets 5)
;(filter diff-trip? (all-triplets 3))


;(filter diff-trip? (all-triplets 3))