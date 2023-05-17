#lang simply-scheme


; -- Previous defined functions
(define (set-cdr! z new-value)
  ((z 'set-cdr!) new-value) z)

(define (make-table)
  (list '*table*))



(define (assoc key records)
  (cond ((null? records) #f)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))


(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)

; -- Tests
;(define table)
;(set! table (make-table))
;(define table (make-table))
(insert! 'a 2 (make-table))

;(null? (cdr table))

