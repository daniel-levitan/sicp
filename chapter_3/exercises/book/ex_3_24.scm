;(load "/Users/daniel/Documents/projects/cs61a/chapter_3/exercises/book/ex_3_24.scm")

; Using this program, both key-1 and key-2 must be numerical
; Inserting and looking up will compare numbers

(define (make-table same-key?)
  (let ((local-table (list '*table*)))

    (define (assoc key records)
      (cond ((null? records) #f)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))
    
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record (cdr record) false))
            false)))

    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1 (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))




; -- Testing

(define (eq-num? n1 n2)
  (if (< (abs (- n2 n1)) 0.1)
      #t
      #f))

(define operation-table (make-table eq-num?))
;(define operation-table (make-table equal?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))


;(put 'letters 'a 61)
;(put 'letters 'b 62)

;(put 'numbers 1 1)
;(put 'numbers 2 2)

;(get 'numbers 1)
;(get 'numbers 2)
