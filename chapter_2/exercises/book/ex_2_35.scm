#lang simply-scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)) )  ))

;(define (count-leaves x)
;  (cond ((null? x) 0)
;      ((not (pair? x)) 1)
;      (else (+ (count-leaves (car x))
;               (count-leaves (cdr x))))))

;(define (count-leaves t)
;  (accumulate ⟨??⟩ ⟨??⟩ (map ⟨??⟩ ⟨??⟩)))




(define (tree-to-sequ t)
  (define (dfs-2 t l)
    (cond ((null? t) l)
          ((not (pair? (car t))) (append l t))
          (else (append (dfs-2 (car t) l) (dfs-2 (cdr t) l)) )))
  (dfs-2 t '()))

; Vamos tentar usar esse
(define (enumerate-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))


(define (to-one tree)
  (map (lambda (sub-tree)
       (if (pair? sub-tree)
           (to-one sub-tree)
           1))
       tree))

; Sem usar map
;(define (count-leaves t)
;  (accumulate + 0 (to-one (tree-to-sequ x))))

; Usando o meu procedimento para transformar árvore em lista
;(define (count-leaves t)
;  (accumulate + 0 (map (lambda (x) 1) (tree-to-sequ x))))

; Usando o procedimento do livro para transformar árvore em lista
(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree x))))


(define x (cons (list 1 2) (list 3 4)))




(count-leaves x)