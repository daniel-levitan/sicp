;#lang simply-scheme
;(load "/Users/daniel/Documents/projects/cs61a/chapter_3/exercises/book/ex_3_22.scm")

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    
    ;⟨definitions of internal procedures⟩
    (define (empty-queue?)
      (null? front-ptr))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
               (set-cdr! rear-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)) ))

    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue" front-ptr)
          (car front-ptr)))

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue" front-ptr))
            (else (set! front-ptr (cdr front-ptr))
                  front-ptr)))
    
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'insert-queue!) insert-queue! )
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'delete-queue!) (delete-queue!))
            ))
    dispatch))


(define q (make-queue))
;(q 'empty-queue?)

((q 'insert-queue!) 1)
((q 'insert-queue!) 2)
((q 'insert-queue!) 3)
;(q 'empty-queue?)

;(q 'front-queue)