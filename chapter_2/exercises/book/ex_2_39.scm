#lang simply-scheme

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse-r sequence)
  (fold-right (lambda (x y) (append y (list x)) ) '() sequence))

(reverse-r (list 1 4 9 16 25))



(define (reverse-l sequence)
  (fold-left (lambda (x y) (append (list y) x)) '() sequence))

(reverse-l (list 1 4 9 16 25))

