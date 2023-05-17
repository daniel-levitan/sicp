;(load "/Users/daniel/Documents/projects/cs61a/chapter_3/exercises/book/ex_3_25.scm")

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

  

(define (make-table)
  (list '*table*))

; -- Testing
(define my-table (make-table))
